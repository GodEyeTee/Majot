# Majot

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Project stucjture
```src/
├── lib/
│   ├── core/                      # Core modules
│   │   ├── config/                # แยกเป็น folder เฉพาะสำหรับ config
│   │   │   ├── theme/             # Theme config
│   │   │   └── localization/      # Localization config
│   │   ├── permissions/           # RBAC
│   │   │   └── role_manager.dart
│   │   ├── utils/                 # Utilities
│   │   └── widgets/               # Common widgets
│   ├── feature/                   # Features
│   │   ├── hotel_booking/
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   ├── shopping/
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   ├── profile/
│   │   │   ├── data/
│   │   │   │   └── repositories/
│   │   │   │       └── auth_repository.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   └── profile.dart
│   │   │   │   └── usecases/
│   │   │   └── presentation/
│   │   │       ├── blocs/
│   │   │       │   └── auth_bloc.dart
│   │   │       └── pages/
│   │   │           ├── login.dart
│   │   │           ├── register.dart
│   │   │           └── settings_screen.dart
│   │   └── admin_dashboard/
│   │       ├── data/
│   │       ├── domain/
│   │       └── presentation/
│   └── main.dart
```

1. สถาปัตยกรรมซอฟต์แวร์ (Modular + Feature-First)
แยกแต่ละฟีเจอร์เป็นแพ็กเกจย่อย (Dart package) มีโฟลเดอร์ UI, domain, data ภายใน เพื่อให้ build/test/deploy แยกกันได้ง่ายและลด dependency conflict Medium Medium
ใช้เลเยอร์ Domain (Entities, UseCases), Data (Repositories, API), Presentation (Widgets, ViewModels) แต่รวมไฟล์ของแต่ละฟีเจอร์ไว้ในโฟลเดอร์เดียว (feature-first) เพื่อ readability ลด ceremony ของ Clean Architecture ดั้งเดิม Code With Andrea DEV Community
2. การควบคุมสิทธิ์ (RBAC)
จัดการบทบาท 3 แบบ (admin, user, staff) โดยกำหนด permissions per module/action ใน central RoleManager class แล้วเชื่อมกับ GoRouter middleware เพื่อ guard routes Medium tula.co
แต่ละ widget ที่ต้องการสิทธิ์เฉพาะ ให้ตรวจสอบผ่าน RoleManager.hasPermission(…) ก่อน render ลด if-else กระจัดกระจายในโค้ด DEV Community
3. โมดูลหลัก (Modules)
3.1 Hotel Booking
โครงสร้าง: feature/hotel_booking/{data,domain,presentation}
ฟีเจอร์: ค้นหาห้อง, จอง, ดูสถานะการจอง, ปฏิทินราคา WTF Blog GitHub
3.2 Shopping
โครงสร้าง: feature/shopping/{data,domain,presentation}
ฟีเจอร์: สินค้า, ตะกร้า, ชำระเงิน, order history Medium Medium
3.3 Profile
โครงสร้าง: feature/profile/{data,domain,presentation}
ฟีเจอร์: แก้ไขข้อมูลผู้ใช้, เปลี่ยนรหัสผ่าน, ตั้งค่าภาษา/ธีม
3.4 Admin Dashboard
โครงสร้าง: feature/admin_dashboard/{data,domain,presentation}
ฟีเจอร์: สรุปรายงานยอดจอง/ยอดขาย, จัดการผู้ใช้, ตั้งค่าสิทธิ์ Medium GitHub
4. การจัดการสถานะ (State Management)
Riverpod 2.x สำหรับ global & async state (caching, API calls) Medium
Bloc + Freezed สำหรับ flows ที่ซับซ้อนต้อง test ชัดเจน (เช่น การชำระเงิน) DEV Community
Signals สำหรับ local widget state เบาๆ ตอบสนองเร็ว
5. สองภาษา (i18n)
ใช้ flutter_localizations + Dart intl กับ ARB files (intl_en.arb, intl_th.arb) ตั้ง supportedLocales ใน MaterialApp Flutter documentation Medium
สลับภาษาได้แบบไดนามิกโดยเก็บ locale ใน Riverpod/Bloc แล้วรีเฟรช MaterialApp(locale: currentLocale) Medium
6. ธีมไดนามิก (Theming)
กำหนด ThemeData lightTheme และ darkTheme พร้อม themeMode ควบคุมด้วย state Medium
ใช้ Theme Extension เพิ่ม custom properties (colors, paddings) ให้ type-safe และ modular Medium
7. ความปลอดภัย (Security)
เก็บ tokens ด้วย flutter_secure_storage พร้อม fallback error handling Touchlane
ใช้ Biometric (local_auth) พร้อมตรวจ compatibility ก่อนเรียกใช้งาน Touchlane
Obfuscate code ด้วย --obfuscate --split-debug-info ป้องกัน reverse-engineering Medium
เปิด HTTPS + certificate pinning ผ่าน Dio interceptor หรือ native plugin Flutter documentation
8. การทดสอบ (Testing)