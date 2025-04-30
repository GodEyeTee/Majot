// lib/pages/helps/help_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:majot/core/widgets/bottom_navbar.dart';

class HelpScreen extends ConsumerWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ช่วยเหลือ'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _HelpSection(
            title: 'การจองโรงแรม',
            icon: Icons.hotel,
            items: [
              'ค้นหาโรงแรมที่คุณต้องการ',
              'เลือกวันที่เข้าพักและออกจากที่พัก',
              'เลือกจำนวนห้องและผู้เข้าพัก',
              'ชำระเงินและรับการยืนยันการจอง',
            ],
          ),
          SizedBox(height: 16),
          _HelpSection(
            title: 'การซื้อสินค้า',
            icon: Icons.shopping_bag,
            items: [
              'เลือกสินค้าที่คุณต้องการ',
              'เพิ่มสินค้าลงตะกร้า',
              'ใส่ข้อมูลการจัดส่ง',
              'เลือกวิธีการชำระเงิน',
              'ยืนยันการสั่งซื้อ',
            ],
          ),
          SizedBox(height: 16),
          _HelpSection(
            title: 'การตั้งค่าโปรไฟล์',
            icon: Icons.person,
            items: [
              'แก้ไขข้อมูลส่วนตัว',
              'เปลี่ยนรหัสผ่าน',
              'ตั้งค่าการแจ้งเตือน',
              'เปลี่ยนภาษาและธีม',
            ],
          ),
          SizedBox(height: 16),
          _HelpSection(
            title: 'การใช้งานระบบสิทธิ์',
            icon: Icons.security,
            items: [
              'ผู้ใช้ทั่วไป: สามารถดูและจองโรงแรม, ซื้อสินค้า, แก้ไขโปรไฟล์ตัวเอง',
              'ผู้แก้ไข: สามารถจัดการข้อมูลโรงแรม, สินค้า, และดูข้อมูลการจองและสั่งซื้อทั้งหมด',
              'ผู้ดูแลระบบ: มีสิทธิ์ทั้งหมดในระบบ รวมถึงการจัดการผู้ใช้และตั้งค่าระบบ',
            ],
          ),
          SizedBox(height: 16),
          _HelpSection(
            title: 'การติดต่อเรา',
            icon: Icons.contact_support,
            items: [
              'อีเมล: support@majot.com',
              'โทรศัพท์: 099-999-9999',
              'Line: @majot',
              'เวลาทำการ: 9:00 - 18:00 น. ทุกวัน',
            ],
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}

class _HelpSection extends StatelessWidget {
  const _HelpSection({
    required this.title,
    required this.icon,
    required this.items,
  });

  final String title;
  final IconData icon;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ', style: TextStyle(fontSize: 16)),
                      Expanded(
                        child: Text(
                          item,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
