import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_permissions.dart';
import 'app_roles.dart';

/// Central service for managing roles and permissions in the application
class RoleManager extends ChangeNotifier {
  RoleManager({
    required this.prefs,
    required this.firebaseAuth,
  }) {
    _initializeFromAuth();
    firebaseAuth.authStateChanges().listen((_) {
      _initializeFromAuth();
    });
  }

  final SharedPreferences prefs;
  final FirebaseAuth firebaseAuth;
  AppRole _currentRole = AppRole.user; // Default role is user

  /// Current user role
  AppRole get currentRole => _currentRole;

  /// Current user ID (or null if not authenticated)
  String? get currentUserId => firebaseAuth.currentUser?.uid;

  /// Returns true if the current user has the specified permission
  bool hasPermission(AppPermission permission) {
    return _currentRole.permissions.contains(permission);
  }

  /// Returns true if the current user has any of the specified permissions
  bool hasAnyPermission(List<AppPermission> permissions) {
    return permissions.any((permission) => hasPermission(permission));
  }

  /// Returns true if the current user has all of the specified permissions
  bool hasAllPermissions(List<AppPermission> permissions) {
    return permissions.every((permission) => hasPermission(permission));
  }

  /// Returns true if the current user has the specified role
  bool hasRole(AppRole role) {
    return _currentRole == role;
  }

  /// Returns true if the current user has any of the specified roles
  bool hasAnyRole(List<AppRole> roles) {
    return roles.contains(_currentRole);
  }

  /// Set the current user role
  Future<void> setRole(AppRole role) async {
    if (_currentRole != role) {
      _currentRole = role;
      await _saveRole();
      notifyListeners();
    }
  }

  /// Initialize role from either Firebase user claims or local storage
  Future<void> _initializeFromAuth() async {
    final user = firebaseAuth.currentUser;

    if (user == null) {
      // If no user, set to default role
      _currentRole = AppRole.user;
      notifyListeners();
      return;
    }

    try {
      // Try to get role from Firebase user claims
      await user.getIdTokenResult(true).then((idTokenResult) {
        final claims = idTokenResult.claims;
        if (claims != null && claims['role'] != null) {
          final roleStr = claims['role'] as String;
          _currentRole = AppRole.values.firstWhere(
            (role) => role.name == roleStr,
            orElse: () => AppRole.user,
          );
        } else {
          // Fallback to stored preferences
          _loadRoleFromPrefs(user.uid);
        }
      });
    } catch (e) {
      // Fallback to stored preferences on error
      _loadRoleFromPrefs(user.uid);
    }

    notifyListeners();
  }

  /// Load role from shared preferences
  void _loadRoleFromPrefs(String userId) {
    final roleIndex = prefs.getInt('user_role:$userId') ?? AppRole.user.index;
    _currentRole = AppRole.values[roleIndex];
  }

  /// Save role to shared preferences
  Future<void> _saveRole() async {
    final userId = currentUserId;
    if (userId != null) {
      await prefs.setInt('user_role:$userId', _currentRole.index);
    }
  }
}
