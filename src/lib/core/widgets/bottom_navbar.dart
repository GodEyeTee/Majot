import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:majot/core/config/localization/localization.dart';
import 'package:majot/core/config/theme/app_themes.dart';
import 'package:majot/core/permissions/app_permissions.dart';
import 'package:majot/core/permissions/permission_widget.dart';

// Provider เก็บค่า index ของ tab ที่เลือกในปัจจุบัน
final selectedNavIndexProvider = StateProvider<int>((ref) => 0);

class MajotBottomNavBar extends ConsumerWidget {
  const MajotBottomNavBar({
    Key? key,
    this.onTabSelected,
  }) : super(key: key);

  final Function(int)? onTabSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedNavIndexProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // เลือกสีที่เหมาะสมตาม theme
    final activeColor = Theme.of(context).colorScheme.primary;
    final inactiveColor = isDarkMode ? Colors.grey[400] : Colors.grey[600];

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // ปุ่มหน้าหลัก
              _buildNavItem(
                context,
                icon: Icons.home,
                label: 'หน้าหลัก',
                index: 0,
                selectedIndex: selectedIndex,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                onTap: () => _selectTab(ref, 0),
              ),

              // ปุ่ม Hotel (เฉพาะผู้ใช้ที่มีสิทธิ์)
              PermissionWidget(
                permission: AppPermission.viewHotels,
                child: _buildNavItem(
                  context,
                  icon: Icons.hotel,
                  label: 'โรงแรม',
                  index: 1,
                  selectedIndex: selectedIndex,
                  activeColor: activeColor,
                  inactiveColor: inactiveColor,
                  onTap: () => _selectTab(ref, 1),
                ),
              ),

              // ปุ่ม Shopping (เฉพาะผู้ใช้ที่มีสิทธิ์)
              PermissionWidget(
                permission: AppPermission.viewProducts,
                child: _buildNavItem(
                  context,
                  icon: Icons.shopping_bag,
                  label: 'ช้อปปิ้ง',
                  index: 2,
                  selectedIndex: selectedIndex,
                  activeColor: activeColor,
                  inactiveColor: inactiveColor,
                  onTap: () => _selectTab(ref, 2),
                ),
              ),

              // ปุ่ม Admin Dashboard (เฉพาะผู้ดูแลระบบ)
              PermissionWidget(
                permission: AppPermission.viewDashboard,
                child: _buildNavItem(
                  context,
                  icon: Icons.admin_panel_settings,
                  label: 'แอดมิน',
                  index: 3,
                  selectedIndex: selectedIndex,
                  activeColor: activeColor,
                  inactiveColor: inactiveColor,
                  onTap: () => _selectTab(ref, 3),
                ),
              ),

              // ปุ่มโปรไฟล์
              _buildNavItem(
                context,
                icon: Icons.person,
                label: 'โปรไฟล์',
                index: 4,
                selectedIndex: selectedIndex,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                onTap: () => _selectTab(ref, 4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ฟังก์ชันสร้าง Nav Item แต่ละปุ่ม
  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required int index,
    required int selectedIndex,
    required Color activeColor,
    required Color? inactiveColor,
    required VoidCallback onTap,
  }) {
    final isSelected = selectedIndex == index;
    return InkWell(
      onTap: onTap,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? activeColor : inactiveColor,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? activeColor : inactiveColor,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ฟังก์ชันเปลี่ยน tab
  void _selectTab(WidgetRef ref, int index) {
    ref.read(selectedNavIndexProvider.notifier).state = index;
    if (onTabSelected != null) {
      onTabSelected!(index);
    }
  }
}

// เพิ่ม alias สำหรับความสะดวกในการใช้งาน
typedef BottomNavbar = MajotBottomNavBar;
