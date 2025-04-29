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
"""src/
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
│   └── main.dart"""