import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:majot/core/permissions/app_permissions.dart';
import 'package:majot/core/permissions/app_roles.dart';
import 'package:majot/core/permissions/permission_widget.dart';
import 'package:majot/core/permissions/role_manager_provider.dart';
import 'package:majot/feature/profile/presentation/blocs/auth_bloc.dart';
import 'package:majot/feature/profile/presentation/pages/login.dart';
import 'package:majot/feature/profile/presentation/pages/register.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roleManager = ref.watch(roleManagerProvider);

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          // ถ้าผู้ใช้เข้าสู่ระบบแล้ว
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // การ์ดต้อนรับ
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.2),
                              backgroundImage: state.user.photoURL != null
                                  ? NetworkImage(state.user.photoURL!)
                                  : null,
                              child: state.user.photoURL == null
                                  ? Icon(Icons.person,
                                      size: 30,
                                      color:
                                          Theme.of(context).colorScheme.primary)
                                  : null,
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'สวัสดี, ${state.user.displayName ?? "คุณ"}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'บทบาท: ${roleManager.currentRole.displayName}',
                                  style: TextStyle(
                                    color:
                                        _getRoleColor(roleManager.currentRole),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // ส่วนหัวข้อคุณลักษณะ
                const Text(
                  'คุณลักษณะทั้งหมด',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                // กริดคุณลักษณะ
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      // ฟีเจอร์โรงแรม - ทุกคนมองเห็น
                      _buildFeatureCard(
                        context,
                        'โรงแรม',
                        Icons.hotel,
                        Colors.blue,
                        () {
                          ref.read(selectedNavIndexProvider.notifier).state = 1;
                        },
                      ),

                      // ฟีเจอร์ช้อปปิ้ง - ทุกคนมองเห็น
                      _buildFeatureCard(
                        context,
                        'ช้อปปิ้ง',
                        Icons.shopping_bag,
                        Colors.green,
                        () {
                          ref.read(selectedNavIndexProvider.notifier).state = 2;
                        },
                      ),

                      // แผงควบคุมแอดมิน - เฉพาะผู้มีสิทธิ์
                      PermissionWidget(
                        permission: AppPermission.viewDashboard,
                        child: _buildFeatureCard(
                          context,
                          'แอดมิน',
                          Icons.admin_panel_settings,
                          Colors.purple,
                          () {
                            ref.read(selectedNavIndexProvider.notifier).state =
                                3;
                          },
                        ),
                      ),

                      // โปรไฟล์ - ทุกคนมองเห็น
                      _buildFeatureCard(
                        context,
                        'โปรไฟล์',
                        Icons.person,
                        Colors.orange,
                        () {
                          ref.read(selectedNavIndexProvider.notifier).state = 4;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        // ถ้ายังไม่ได้เข้าสู่ระบบ
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.app_registration_rounded,
                  size: 80,
                  color: Colors.deepPurple,
                ),
                const SizedBox(height: 32),
                const Text(
                  'ยินดีต้อนรับสู่ Majot',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'เริ่มต้นใช้งานด้วยการสร้างบัญชีหรือเข้าสู่ระบบ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 48),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const RegisterScreen();
                      }),
                    );
                  },
                  icon: const Icon(Icons.person_add),
                  label: const Text('สมัครสมาชิก'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 56),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const LoginScreen();
                      }),
                    );
                  },
                  icon: const Icon(Icons.login),
                  label: const Text('มีบัญชีอยู่แล้ว? เข้าสู่ระบบ'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.deepPurple,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRoleColor(AppRole role) {
    switch (role) {
      case AppRole.user:
        return Colors.blue;
      case AppRole.staff:
        return Colors.green;
      case AppRole.admin:
        return Colors.purple;
    }
  }
}

// Provider เก็บค่า index ของ tab ที่เลือกในปัจจุบัน
final selectedNavIndexProvider = StateProvider<int>((ref) => 0);
