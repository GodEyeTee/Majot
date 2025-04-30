import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_permissions.dart';
import 'app_roles.dart';
import 'role_manager_provider.dart';

/// A widget that only shows its child if the user has the required permission
class PermissionWidget extends ConsumerWidget {
  const PermissionWidget({
    super.key,
    required this.permission,
    required this.child,
    this.fallbackWidget,
  });

  /// The permission required to view the child widget
  final AppPermission permission;

  /// The widget to show if the user has the required permission
  final Widget child;

  /// The widget to show if the user does not have the required permission
  /// If null, nothing will be shown
  final Widget? fallbackWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roleManager = ref.watch(roleManagerProvider);

    if (roleManager.hasPermission(permission)) {
      return child;
    } else {
      return fallbackWidget ?? const SizedBox.shrink();
    }
  }
}

/// A widget that only shows its child if the user has any of the required permissions
class AnyPermissionWidget extends ConsumerWidget {
  const AnyPermissionWidget({
    super.key,
    required this.permissions,
    required this.child,
    this.fallbackWidget,
  });

  /// The permissions - any one of which allows viewing the child widget
  final List<AppPermission> permissions;

  /// The widget to show if the user has any of the required permissions
  final Widget child;

  /// The widget to show if the user does not have any of the required permissions
  /// If null, nothing will be shown
  final Widget? fallbackWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roleManager = ref.watch(roleManagerProvider);

    if (roleManager.hasAnyPermission(permissions)) {
      return child;
    } else {
      return fallbackWidget ?? const SizedBox.shrink();
    }
  }
}

/// A widget that only shows its child if the user has the specified role
class RoleWidget extends ConsumerWidget {
  const RoleWidget({
    super.key,
    required this.role,
    required this.child,
    this.fallbackWidget,
  });

  /// The role required to view the child widget
  final AppRole role;

  /// The widget to show if the user has the required role
  final Widget child;

  /// The widget to show if the user does not have the required role
  /// If null, nothing will be shown
  final Widget? fallbackWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roleManager = ref.watch(roleManagerProvider);

    if (roleManager.hasRole(role)) {
      return child;
    } else {
      return fallbackWidget ?? const SizedBox.shrink();
    }
  }
}
