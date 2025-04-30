/// Defines all possible permissions within the application
///
/// This enum follows the principle of granular permission control,
/// where each permission represents a specific action rather than
/// a general capability.
enum AppPermission {
  // Authentication permissions
  login,
  register,
  resetPassword,

  // Content access permissions
  viewPublicContent,
  viewUserContent,

  // Profile permissions
  viewOwnProfile,
  editOwnProfile,

  // Hotel booking permissions
  viewHotels,
  searchHotels,
  bookHotel,
  cancelBooking,
  viewBookingHistory,

  // Shopping permissions
  viewProducts,
  addToCart,
  checkout,
  viewOrderHistory,

  // Administrative permissions
  manageUsers,
  manageHotels,
  manageProducts,
  viewMetrics,

  // System permissions
  accessAdminPanel,
  configureSystem;

  /// Human-readable display name for the permission
  String get displayName {
    switch (this) {
      // Authentication
      case AppPermission.login:
        return 'Sign in to account';
      case AppPermission.register:
        return 'Create new account';
      case AppPermission.resetPassword:
        return 'Reset password';

      // Content access
      case AppPermission.viewPublicContent:
        return 'View public content';
      case AppPermission.viewUserContent:
        return 'View member content';

      // Profile
      case AppPermission.viewOwnProfile:
        return 'View own profile';
      case AppPermission.editOwnProfile:
        return 'Edit own profile';

      // Hotel
      case AppPermission.viewHotels:
        return 'View available hotels';
      case AppPermission.searchHotels:
        return 'Search for hotels';
      case AppPermission.bookHotel:
        return 'Book hotel rooms';
      case AppPermission.cancelBooking:
        return 'Cancel hotel bookings';
      case AppPermission.viewBookingHistory:
        return 'View booking history';

      // Shopping
      case AppPermission.viewProducts:
        return 'View products';
      case AppPermission.addToCart:
        return 'Add items to cart';
      case AppPermission.checkout:
        return 'Complete purchases';
      case AppPermission.viewOrderHistory:
        return 'View order history';

      // Admin
      case AppPermission.manageUsers:
        return 'Manage user accounts';
      case AppPermission.manageHotels:
        return 'Manage hotel listings';
      case AppPermission.manageProducts:
        return 'Manage product listings';
      case AppPermission.viewMetrics:
        return 'View system metrics';

      // System
      case AppPermission.accessAdminPanel:
        return 'Access admin dashboard';
      case AppPermission.configureSystem:
        return 'Configure system settings';
    }
  }

  /// Category grouping for the permission
  PermissionCategory get category {
    switch (this) {
      case AppPermission.login:
      case AppPermission.register:
      case AppPermission.resetPassword:
        return PermissionCategory.authentication;

      case AppPermission.viewPublicContent:
      case AppPermission.viewUserContent:
        return PermissionCategory.content;

      case AppPermission.viewOwnProfile:
      case AppPermission.editOwnProfile:
        return PermissionCategory.profile;

      case AppPermission.viewHotels:
      case AppPermission.searchHotels:
      case AppPermission.bookHotel:
      case AppPermission.cancelBooking:
      case AppPermission.viewBookingHistory:
        return PermissionCategory.hotel;

      case AppPermission.viewProducts:
      case AppPermission.addToCart:
      case AppPermission.checkout:
      case AppPermission.viewOrderHistory:
        return PermissionCategory.shopping;

      case AppPermission.manageUsers:
      case AppPermission.manageHotels:
      case AppPermission.manageProducts:
      case AppPermission.viewMetrics:
      case AppPermission.accessAdminPanel:
      case AppPermission.configureSystem:
        return PermissionCategory.administration;
    }
  }
}

/// Categories to group related permissions
enum PermissionCategory {
  authentication,
  content,
  profile,
  hotel,
  shopping,
  administration;

  String get displayName {
    switch (this) {
      case PermissionCategory.authentication:
        return 'Authentication';
      case PermissionCategory.content:
        return 'Content';
      case PermissionCategory.profile:
        return 'Profile';
      case PermissionCategory.hotel:
        return 'Hotel';
      case PermissionCategory.shopping:
        return 'Shopping';
      case PermissionCategory.administration:
        return 'Administration';
    }
  }
}
