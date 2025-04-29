// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appTitle => 'หมาจด';

  @override
  String get signIn => 'เข้าสู่ระบบ';

  @override
  String get signUp => 'สมัครสมาชิก';

  @override
  String get welcome => 'ยินดีต้อนรับ';

  @override
  String get welcomeBack => 'ยินดีต้อนรับกลับมา';

  @override
  String get signInWithGoogle => 'เข้าสู่ระบบด้วย Google';

  @override
  String get signUpWithGoogle => 'สมัครสมาชิกด้วย Google';

  @override
  String get successfullySignedIn => 'เข้าสู่ระบบสำเร็จ!';

  @override
  String get settings => 'ตั้งค่า';

  @override
  String get language => 'ภาษา';

  @override
  String get theme => 'ธีม';

  @override
  String get darkMode => 'โหมดมืด';

  @override
  String get lightMode => 'โหมดสว่าง';

  @override
  String get systemMode => 'ตามระบบ';
}
