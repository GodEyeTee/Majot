import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme_extensions.dart';

// Theme Mode
enum AppThemeMode { light, dark, system }

// Theme Service
class ThemeService {
  ThemeService(this.prefs);
  final SharedPreferences prefs;

  // ดึงธีมที่เลือกหรือใช้ค่าเริ่มต้น
  AppThemeMode get themeMode {
    final savedTheme = prefs.getString('theme_mode');
    if (savedTheme != null) {
      return AppThemeMode.values.firstWhere(
        (e) => e.toString() == savedTheme,
        orElse: () => AppThemeMode.system,
      );
    }
    return AppThemeMode.system; // ค่าเริ่มต้น
  }

  // บันทึกธีมที่เลือก
  Future<void> setThemeMode(AppThemeMode mode) async {
    await prefs.setString('theme_mode', mode.toString());
  }

  // แปลง AppThemeMode เป็น ThemeMode ของ Flutter
  ThemeMode get flutterThemeMode {
    switch (themeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }
}

// Light Theme
ThemeData getLightTheme() {
  const Color primaryColor = Colors.deepPurple;

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.black87,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: Colors.black87),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
    ),
    extensions: [
      const AppThemeExtension(
        primaryButtonColor: primaryColor,
        secondaryButtonColor: Colors.white,
        cardBorderColor: Color(0xFFE0E0E0),
        accentColor: Color(0xFF6200EE),
        defaultBorderRadius: BorderRadius.all(Radius.circular(12)),
        defaultPadding: EdgeInsets.all(16),
      ),
    ],
  );
}

// Dark Theme
ThemeData getDarkTheme() {
  const Color primaryColor = Colors.deepPurpleAccent;

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
    ),
    extensions: [
      const AppThemeExtension(
        primaryButtonColor: primaryColor,
        secondaryButtonColor: Color(0xFF303030),
        cardBorderColor: Color(0xFF404040),
        accentColor: Color(0xFFBB86FC),
        defaultBorderRadius: BorderRadius.all(Radius.circular(12)),
        defaultPadding: EdgeInsets.all(16),
      ),
    ],
  );
}

// Provider สำหรับ Theme Service
final themeServiceProvider = Provider<ThemeService>((ref) {
  throw UnimplementedError(); // จะถูก override ใน main.dart
});

// Provider สำหรับ Theme Mode
final themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, AppThemeMode>((ref) {
  final themeService = ref.watch(themeServiceProvider);
  return ThemeModeNotifier(themeService);
});

// Notifier สำหรับจัดการ Theme Mode
class ThemeModeNotifier extends StateNotifier<AppThemeMode> {
  ThemeModeNotifier(this._themeService) : super(_themeService.themeMode);
  final ThemeService _themeService;

  Future<void> setThemeMode(AppThemeMode mode) async {
    await _themeService.setThemeMode(mode);
    state = mode;
  }
}
