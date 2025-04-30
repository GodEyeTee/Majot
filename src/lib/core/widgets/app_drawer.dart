import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:majot/core/config/localization/localization.dart';
import 'package:majot/core/config/theme/app_themes.dart';
import 'package:majot/core/permissions/app_permissions.dart';
import 'package:majot/core/permissions/app_roles.dart';
import 'package:majot/core/permissions/permission_widget.dart';
import 'package:majot/core/permissions/role_manager_provider.dart';
import 'package:majot/feature/profile/presentation/blocs/auth_bloc.dart';
import 'package:majot/feature/profile/presentation/pages/settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;
    final currentThemeMode = ref.watch(themeModeProvider);
    final currentLocale = ref.watch(localeProvider);
    final roleManager = ref.watch(roleManagerProvider);

    return Drawer(
      child: Column(
        children: [
          // Header ส่วนหัวของ Drawer
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage:
                  user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
              child: user?.photoURL == null
                  ? Icon(Icons.person,
                      size: 40, color: Theme.of(context).colorScheme.primary)
                  : null,
            ),
            accountName: Text(
              user?.displayName ?? 'ผู้ใช้งาน',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user?.email ?? 'ไม่ได้เข้าสู่ระบบ'),
                const SizedBox(height: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    roleManager.currentRole.displayName,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // รายการเมนูใน Drawer
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('โปรไฟล์'),
            onTap: () {
              Navigator.pop(context); // ปิด Drawer
              // นำทางไปหน้าโปรไฟล์
            },
          ),

          // เมนูตั้งค่าภาษา
          ExpansionTile(
            leading: const Icon(Icons.language),
            title: const Text('ภาษา'),
            children: [
              RadioListTile<Locale>(
                title: const Text('English'),
                value: const Locale('en'),
                groupValue: currentLocale,
                onChanged: (Locale? value) {
                  if (value != null) {
                    ref.read(localeProvider.notifier).setLocale(value);
                    // Navigator.pop(context); // อาจจะไม่ปิด drawer ทันทีเพื่อให้ผู้ใช้เปลี่ยนได้หลายครั้ง
                  }
                },
              ),
              RadioListTile<Locale>(
                title: const Text('ไทย'),
                value: const Locale('th'),
                groupValue: currentLocale,
                onChanged: (Locale? value) {
                  if (value != null) {
                    ref.read(localeProvider.notifier).setLocale(value);
                  }
                },
              ),
            ],
          ),

          // เมนูตั้งค่าธีม
          ExpansionTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('ธีม'),
            children: [
              RadioListTile<AppThemeMode>(
                title: Text(context.l10n.lightMode), // ใช้ localization
                value: AppThemeMode.light,
                groupValue: currentThemeMode,
                onChanged: (AppThemeMode? value) {
                  if (value != null) {
                    ref.read(themeModeProvider.notifier).setThemeMode(value);
                  }
                },
              ),
              RadioListTile<AppThemeMode>(
                title: Text(context.l10n.darkMode), // ใช้ localization
                value: AppThemeMode.dark,
                groupValue: currentThemeMode,
                onChanged: (AppThemeMode? value) {
                  if (value != null) {
                    ref.read(themeModeProvider.notifier).setThemeMode(value);
                  }
                },
              ),
              RadioListTile<AppThemeMode>(
                title: Text(context.l10n.systemMode), // ใช้ localization
                value: AppThemeMode.system,
                groupValue: currentThemeMode,
                onChanged: (AppThemeMode? value) {
                  if (value != null) {
                    ref.read(themeModeProvider.notifier).setThemeMode(value);
                  }
                },
              ),
            ],
          ),

          // เมนูตั้งค่า (นำไปหน้าตั้งค่าทั้งหมด)
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('ตั้งค่า'),
            onTap: () {
              Navigator.pop(context); // ปิด Drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),

          // ตัวคั่นเมนู
          const Divider(),

          // เมนูสำหรับแอดมิน
          PermissionWidget(
            permission: AppPermission.viewDashboard,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.admin_panel_settings),
                  title: const Text('แผงควบคุมแอดมิน'),
                  onTap: () {
                    Navigator.pop(context); // ปิด Drawer
                    // นำทางไปหน้า Admin Dashboard
                  },
                ),
                const Divider(),
              ],
            ),
          ),

          // เมนูทดสอบบทบาท (สำหรับการทดสอบ)
          ExpansionTile(
            leading: const Icon(Icons.security),
            title: const Text('ทดสอบบทบาท'),
            children: [
              RadioListTile<AppRole>(
                title: const Text('ผู้ใช้งานทั่วไป'),
                value: AppRole.user,
                groupValue: roleManager.currentRole,
                onChanged: (AppRole? value) {
                  if (value != null) {
                    roleManager.setRole(value);
                  }
                },
              ),
              RadioListTile<AppRole>(
                title: const Text('พนักงาน'),
                value: AppRole.staff,
                groupValue: roleManager.currentRole,
                onChanged: (AppRole? value) {
                  if (value != null) {
                    roleManager.setRole(value);
                  }
                },
              ),
              RadioListTile<AppRole>(
                title: const Text('ผู้ดูแลระบบ'),
                value: AppRole.admin,
                groupValue: roleManager.currentRole,
                onChanged: (AppRole? value) {
                  if (value != null) {
                    roleManager.setRole(value);
                  }
                },
              ),
            ],
          ),

          const Spacer(), // ดันปุ่มออกจากระบบไปไว้ด้านล่าง

          // ปุ่มออกจากระบบ
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                // แสดงกล่องยืนยันก่อนออกจากระบบ
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('ยืนยันการออกจากระบบ'),
                      content: const Text('คุณต้องการออกจากระบบใช่หรือไม่?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('ยกเลิก'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // ปิดกล่องโต้ตอบ
                            Navigator.pop(context); // ปิด Drawer
                            context
                                .read<AuthBloc>()
                                .add(AuthSignOutRequested());
                          },
                          child: const Text('ออกจากระบบ'),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red,
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.logout),
              label: const Text('ออกจากระบบ'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
