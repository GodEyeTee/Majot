import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:majot/core/widgets/bottom_navbar.dart';
import 'package:majot/feature/admin_dashboard/presentation/pages/admin_dashboard_screen.dart';
import 'package:majot/feature/hotel_booking/presentation/pages/hotel_list_screen.dart';
import 'package:majot/feature/profile/presentation/pages/profile_screen.dart';
import 'package:majot/feature/shopping/presentation/pages/shopping_screen.dart';
import 'package:majot/pages/home/home.dart';

class MainLayout extends ConsumerWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavProvider);

    // Return the appropriate screen based on the selected index
    return IndexedStack(
      index: selectedIndex,
      children: const [
        HomePage(),
        HotelListScreen(),
        ShoppingScreen(),
        ProfileScreen(),
        AdminDashboardScreen(),
      ],
    );
  }
}
