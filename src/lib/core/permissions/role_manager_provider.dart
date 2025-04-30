import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'role_manager.dart';

/// Provider for the RoleManager
final roleManagerProvider = Provider<RoleManager>((ref) {
  throw UnimplementedError("Provider has not been initialized");
});

/// Function to override the roleManagerProvider with an initialized instance
/// Call this in the main() function after initializing SharedPreferences
void initializeRoleManager(ProviderContainer container, SharedPreferences prefs,
    FirebaseAuth firebaseAuth) {
  container.updateOverrides([
    roleManagerProvider.overrideWithValue(
      RoleManager(
        prefs: prefs,
        firebaseAuth: firebaseAuth,
      ),
    ),
  ]);
}
