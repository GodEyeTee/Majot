import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:majot/core/widgets/app_drawer.dart';
import 'package:majot/core/widgets/bottom_navbar.dart';
import 'package:majot/feature/admin_dashboard/presentation/pages/admin_dashboard_screen.dart';
import 'package:majot/feature/hotel_booking/presentation/pages/hotel_list_screen.dart';
import 'package:majot/feature/profile/presentation/pages/profile_screen.dart';
import 'package:majot/pages/home/home.dart';

// Provider สำหรับจัดการหน้าปัจจุบัน
final currentPageProvider = StateProvider<Widget>((ref) => const HomePage());

class MainAppScaffold extends ConsumerWidget {
  const MainAppScaffold({
    Key? key,
    this.initialIndex = 0,
  }) : super(key: key);

  final int initialIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedNavIndexProvider);
    final currentPage = ref.watch(currentPageProvider);

    // ตรวจสอบ initialIndex ตอนสร้าง widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (initialIndex != selectedIndex) {
        ref.read(selectedNavIndexProvider.notifier).state = initialIndex;
        _updatePageForIndex(ref, initialIndex);
      }
    });

    return Scaffold(
      // AppBar แสดงชื่อแอปและปุ่มเปิด Drawer
      appBar: AppBar(
        title: const Text('Majot'),
        centerTitle: true,
      ),

      // Drawer Menu
      drawer: const AppDrawer(),

      // เนื้อหาหน้าจอปัจจุบัน
      body: currentPage,

      // Bottom Navigation Bar
      bottomNavigationBar: MajotBottomNavBar(
        onTabSelected: (index) => _updatePageForIndex(ref, index),
      ),
    );
  }

  // อัปเดตหน้าปัจจุบันตาม index ที่เลือก
  void _updatePageForIndex(WidgetRef ref, int index) {
    final newPage = _getPageForIndex(index);
    ref.read(currentPageProvider.notifier).state = newPage;
  }

  // สร้างหน้าตาม index
  Widget _getPageForIndex(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const HotelListScreen();
      case 2:
        return const Scaffold(
            body: Center(child: Text('หน้าช้อปปิ้ง'))); // ตัวอย่างหน้าช้อปปิ้ง
      case 3:
        return const AdminDashboardScreen();
      case 4:
        return const ProfileScreen(); // ต้องสร้างหน้า ProfileScreen
      default:
        return const HomePage();
    }
  }
}
