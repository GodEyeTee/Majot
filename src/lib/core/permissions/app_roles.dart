import 'app_permissions.dart';

/// Roles for the application
enum AppRole { user, staff, admin }

/// Extension methods for AppRole
extension AppRoleExt on AppRole {
  /// Returns the permissions for this role
  Set get permissions {
    switch (this) {
      case AppRole.user:
        return {
          // Hotel permissions
          AppPermission.viewHotels,
          AppPermission.bookHotel,
          AppPermission.viewOwnBookings,
          AppPermission.cancelOwnBooking,

          // Shopping permissions
          AppPermission.viewProducts,
          AppPermission.purchaseProducts,
          AppPermission.viewOwnOrders,
          AppPermission.cancelOwnOrder,

          // Profile permissions
          AppPermission.editOwnProfile,
          AppPermission.changeSettings,
        };

      case AppRole.staff:
        return {
          // All user permissions
          ...AppRole.user.permissions,

          // Additional hotel permissions
          AppPermission.viewAllBookings,

          // Additional shopping permissions
          AppPermission.viewAllOrders,
          AppPermission.manageOrders,

          // Additional profile permissions
          AppPermission.viewProfiles,
        };

      case AppRole.admin:
        // Admin has all permissions
        return Set.from(AppPermission.values);
    }
  }

  /// Returns a human-readable name for this role
  String get displayName {
    switch (this) {
      case AppRole.user:
        return 'ผู้ใช้ทั่วไป';
      case AppRole.staff:
        return 'พนักงาน';
      case AppRole.admin:
        return 'ผู้ดูแลระบบ';
    }
  }

  /// Returns a description of this role
  String get description {
    switch (this) {
      case AppRole.user:
        return 'ผู้ใช้ทั่วไปที่มีสิทธิ์พื้นฐาน';
      case AppRole.staff:
        return 'พนักงานที่มีสิทธิ์ในการดูแลลูกค้า';
      case AppRole.admin:
        return 'ผู้ดูแลระบบที่มีสิทธิ์ทั้งหมด';
    }
  }
}
