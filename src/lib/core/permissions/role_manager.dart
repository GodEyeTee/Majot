import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Defines possible application roles for RBAC (Role-Based Access Control)
enum AppRole {
  guest,
  user,
  admin,
  superAdmin;

  String get displayName {
    switch (this) {
      case AppRole.guest:
        return 'Guest';
      case AppRole.user:
        return 'User';
      case AppRole.admin:
        return 'Administrator';
      case AppRole.superAdmin:
        return 'Super Administrator';
    }
  }
}

/// Manages role-based permissions throughout the application
class RoleManager {
  RoleManager({this.defaultRole = AppRole.guest});

  /// Default role for unauthenticated users
  final AppRole defaultRole;

  /// Current user role - defaults to guest until authenticated
  AppRole _currentRole = AppRole.guest;

  /// Get the current user role
  AppRole get currentRole => _currentRole;

  /// Set the user role based on authentication state or admin action
  void setRole(AppRole role) {
    _currentRole = role;
  }

  /// Reset the role to default (typically used during logout)
  void resetRole() {
    _currentRole = defaultRole;
  }

  /// Check if current role has specific permission
  bool hasPermission(Permission permission) {
    switch (_currentRole) {
      case AppRole.guest:
        return _guestPermissions.contains(permission);
      case AppRole.user:
        return _userPermissions.contains(permission);
      case AppRole.admin:
        return _adminPermissions.contains(permission);
      case AppRole.superAdmin:
        return true; // Super admin has all permissions
    }
  }

  /// Check if the current role can access a specific feature
  bool canAccess(AppFeature feature) {
    switch (_currentRole) {
      case AppRole.guest:
        return _guestFeatures.contains(feature);
      case AppRole.user:
        return _userFeatures.contains(feature);
      case AppRole.admin:
        return true; // Admin can access all features except superadmin ones
      case AppRole.superAdmin:
        return true; // Super admin can access all features
    }
  }

  // Permission definitions for different roles
  static const Set<Permission> _guestPermissions = {
    Permission.viewPublicContent,
    Permission.login,
    Permission.register,
  };

  static const Set<Permission> _userPermissions = {
    Permission.viewPublicContent,
    Permission.viewUserProfile,
    Permission.editOwnProfile,
    Permission.viewHotels,
    Permission.bookHotel,
    Permission.viewShoppingItems,
    Permission.purchaseItems,
    Permission.logout,
  };

  static const Set<Permission> _adminPermissions = {
    Permission.viewPublicContent,
    Permission.viewUserProfile,
    Permission.editOwnProfile,
    Permission.viewHotels,
    Permission.bookHotel,
    Permission.viewShoppingItems,
    Permission.purchaseItems,
    Permission.manageUsers,
    Permission.manageContent,
    Permission.viewMetrics,
    Permission.logout,
  };

  // Feature access definitions
  static const Set<AppFeature> _guestFeatures = {
    AppFeature.authentication,
    AppFeature.publicContent,
  };

  static const Set<AppFeature> _userFeatures = {
    AppFeature.authentication,
    AppFeature.publicContent,
    AppFeature.profile,
    AppFeature.hotelBooking,
    AppFeature.shopping,
  };
}

/// Application permissions
enum Permission {
  viewPublicContent,
  login,
  register,
  viewUserProfile,
  editOwnProfile,
  viewHotels,
  bookHotel,
  viewShoppingItems,
  purchaseItems,
  manageUsers,
  manageContent,
  viewMetrics,
  logout,
}

/// Application features
enum AppFeature {
  authentication,
  publicContent,
  profile,
  hotelBooking,
  shopping,
  adminDashboard,
}

/// Provider for the RoleManager
final roleManagerProvider = Provider<RoleManager>((ref) {
  return RoleManager();
});
