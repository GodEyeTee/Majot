import 'package:flutter/material.dart';
import 'package:majot/core/widgets/bottom_navbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HotelListScreen extends ConsumerWidget {
  const HotelListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel Booking'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.hotel,
              size: 80,
              color: Colors.deepPurple,
            ),
            SizedBox(height: 20),
            Text(
              'Hotel Booking Feature',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'This feature is under development',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavbar(), // ใช้ alias
    );
  }
}
