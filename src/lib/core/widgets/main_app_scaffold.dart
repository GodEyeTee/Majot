import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:majot/core/permissions/role_manager.dart';
import 'package:majot/core/widgets/bottom_navbar.dart';
import 'package:majot/feature/admin_dashboard/presentation/pages/admin_dashboard_screen.dart';
import 'package:majot/feature/hotel_booking/presentation/pages/hotel_list_screen.dart';
import 'package:majot/feature/profile/presentation/pages/profile_screen.dart';
import 'package:majot/feature/shopping/presentation/pages/shopping_screen.dart';
import 'package:majot/pages/home/home.dart';

/// Main application scaffold providing a consistent layout for the app
/// with bottom navigation and role-based access control
class MainAppScaffold extends ConsumerWidget {
  const MainAppScaffold({
    required this.roleManager,
    super.key,
  });

  final RoleManager roleManager;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the current navigation index from our provider
    final selectedIndex = ref.watch(bottomNavProvider);

    // Determine which body content to display based on the selected index
    Widget bodyContent = _buildBodyContent(selectedIndex, context);

    return Scaffold(
      body: bodyContent,
      bottomNavigationBar:
          _buildBottomNavigationBar(context, ref, selectedIndex),
    );
  }

  /// Builds the main content area based on the selected navigation item
  Widget _buildBodyContent(int selectedIndex, BuildContext context) {
    // Check role-based access for admin pages
    final bool canAccessAdmin =
        roleManager.canAccess(AppFeature.adminDashboard);

    switch (selectedIndex) {
      case 0:
        return const HomePage(); // Home is accessible to all
      case 1:
        if (roleManager.canAccess(AppFeature.hotelBooking)) {
          return const HotelListScreen();
        }
        return _buildUnauthorizedScreen(context);
      case 2:
        if (roleManager.canAccess(AppFeature.shopping)) {
          return const ShoppingScreen();
        }
        return _buildUnauthorizedScreen(context);
      case 3:
        if (roleManager.canAccess(AppFeature.profile)) {
          return const ProfileScreen();
        }
        return _buildUnauthorizedScreen(context);
      case 4:
        if (canAccessAdmin) {
          return const AdminDashboardScreen();
        }
        return _buildUnauthorizedScreen(context);
      default:
        return const HomePage();
    }
  }

  /// Builds the unauthorized access screen with option to go back to home
  Widget _buildUnauthorizedScreen(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.lock_outline,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 24),
          const Text(
            'Unauthorized Access',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'You do not have permission to access this feature.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              // Navigate back to home screen
              // Using provider to change the selected index to 0 (home)
            },
            child: const Text('Back to Home'),
          ),
        ],
      ),
    );
  }

  /// Builds the bottom navigation bar
  Widget _buildBottomNavigationBar(
      BuildContext context, WidgetRef ref, int selectedIndex) {
    return const BottomNavbar();
  }
}
