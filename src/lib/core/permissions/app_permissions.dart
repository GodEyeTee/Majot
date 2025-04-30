/// Permissions for the application
enum AppPermission {
  // Hotel Module Permissions
  viewHotels,
  bookHotel,
  viewOwnBookings,
  cancelOwnBooking,
  viewAllBookings,
  manageHotels,

  // Shopping Module Permissions
  viewProducts,
  purchaseProducts,
  viewOwnOrders,
  cancelOwnOrder,
  viewAllOrders,
  manageProducts,
  manageOrders,

  // Profile Module Permissions
  editOwnProfile,
  changeSettings,
  viewProfiles,
  editProfiles,

  // Admin Dashboard Permissions
  viewDashboard,
  viewReports,
  manageSystem,
  manageUsers,
  assignRoles
}

/// Extension methods for AppPermission
extension AppPermissionExt on AppPermission {
  /// Returns the module that this permission belongs to
  String get module {
    switch (this) {
      case AppPermission.viewHotels:
      case AppPermission.bookHotel:
      case AppPermission.viewOwnBookings:
      case AppPermission.cancelOwnBooking:
      case AppPermission.viewAllBookings:
      case AppPermission.manageHotels:
        return 'hotel_booking';

      case AppPermission.viewProducts:
      case AppPermission.purchaseProducts:
      case AppPermission.viewOwnOrders:
      case AppPermission.cancelOwnOrder:
      case AppPermission.viewAllOrders:
      case AppPermission.manageProducts:
      case AppPermission.manageOrders:
        return 'shopping';

      case AppPermission.editOwnProfile:
      case AppPermission.changeSettings:
      case AppPermission.viewProfiles:
      case AppPermission.editProfiles:
        return 'profile';

      case AppPermission.viewDashboard:
      case AppPermission.viewReports:
      case AppPermission.manageSystem:
      case AppPermission.manageUsers:
      case AppPermission.assignRoles:
        return 'admin_dashboard';
    }
  }

  /// Returns a human-readable description of this permission
  String get description {
    switch (this) {
      case AppPermission.viewHotels:
        return 'View available hotels';
      case AppPermission.bookHotel:
        return 'Book a hotel room';
      case AppPermission.viewOwnBookings:
        return 'View your own bookings';
      case AppPermission.cancelOwnBooking:
        return 'Cancel your own booking';
      case AppPermission.viewAllBookings:
        return 'View all user bookings';
      case AppPermission.manageHotels:
        return 'Manage hotel information';

      case AppPermission.viewProducts:
        return 'View products for sale';
      case AppPermission.purchaseProducts:
        return 'Purchase products';
      case AppPermission.viewOwnOrders:
        return 'View your own orders';
      case AppPermission.cancelOwnOrder:
        return 'Cancel your own order';
      case AppPermission.viewAllOrders:
        return 'View all user orders';
      case AppPermission.manageProducts:
        return 'Manage product information';
      case AppPermission.manageOrders:
        return 'Manage order status and processing';

      case AppPermission.editOwnProfile:
        return 'Edit your own profile';
      case AppPermission.changeSettings:
        return 'Change app settings';
      case AppPermission.viewProfiles:
        return 'View other user profiles';
      case AppPermission.editProfiles:
        return 'Edit other user profiles';

      case AppPermission.viewDashboard:
        return 'View admin dashboard';
      case AppPermission.viewReports:
        return 'View system reports';
      case AppPermission.manageSystem:
        return 'Manage system settings';
      case AppPermission.manageUsers:
        return 'Manage user accounts';
      case AppPermission.assignRoles:
        return 'Assign roles to users';
    }
  }
}
