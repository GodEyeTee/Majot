import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ต้องเพิ่ม shared_preferences ใน dependencies

class LocalizationService {
  LocalizationService(this.prefs);
  final SharedPreferences prefs;

  // ค่าเริ่มต้นที่ตั้งไว้หรือค่าที่เคยบันทึกไว้
  Locale get locale {
    final savedLocale = prefs.getString('locale');
    if (savedLocale != null) {
      final parts = savedLocale.split('_');
      if (parts.length > 1) {
        return Locale(parts[0], parts[1]);
      }
      return Locale(parts[0]);
    }
    return const Locale('en'); // ค่าเริ่มต้น
  }

  // เปลี่ยนภาษา
  Future<void> setLocale(Locale newLocale) async {
    if (newLocale.countryCode != null) {
      await prefs.setString(
          'locale', '${newLocale.languageCode}_${newLocale.countryCode}');
    } else {
      await prefs.setString('locale', newLocale.languageCode);
    }
  }

  // ภาษาที่รองรับ
  static List<Locale> supportedLocales = const [
    Locale('en'), // English
    Locale('th'), // Thai
  ];

  // ชื่อภาษาสำหรับแสดงในหน้า UI
  static Map<String, String> availableLanguages = {
    'en': 'English',
    'th': 'ไทย',
  };
}

// Provider สำหรับ Localization Service
final localizationServiceProvider = Provider<LocalizationService>((ref) {
  throw UnimplementedError(); // จะถูก override ใน main.dart หลังจาก initialize SharedPreferences
});

// Provider สำหรับ Current Locale
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  final localizationService = ref.watch(localizationServiceProvider);
  return LocaleNotifier(localizationService);
});

// Notifier สำหรับจัดการ Locale
class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier(this._localizationService)
      : super(_localizationService.locale);
  final LocalizationService _localizationService;

  Future<void> setLocale(Locale locale) async {
    await _localizationService.setLocale(locale);
    state = locale;
  }
}

// Extension สำหรับเข้าถึง AppLocalizations ได้ง่าย
extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
