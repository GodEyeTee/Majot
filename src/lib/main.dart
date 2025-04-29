import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:majot/feature/profile/presentation/blocs/auth_bloc.dart';
import 'package:majot/feature/profile/data/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../core/config/localization/l10n/app_localizations.dart';
import 'firebase_options.dart';
import 'package:majot/pages/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:majot/core/config/localization/localization.dart';
import 'package:majot/core/config/theme/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  // Create auth instances
  final firebaseAuth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  // Create auth repository
  final authRepository = AuthRepository(
    firebaseAuth: firebaseAuth,
    googleSignIn: googleSignIn,
  );

  // Create localization service
  final localizationService = LocalizationService(prefs);

  // Create theme service
  final themeService = ThemeService(prefs);

  // Run app with ProviderScope for Riverpod
  runApp(
    ProviderScope(
      overrides: [
        // Override providers with actual implementations
        localizationServiceProvider.overrideWithValue(localizationService),
        themeServiceProvider.overrideWithValue(themeService),
      ],
      child: MyApp(
        authRepository: authRepository,
        firebaseAuth: firebaseAuth,
        googleSignIn: googleSignIn,
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
    required this.authRepository,
    required this.firebaseAuth,
    required this.googleSignIn,
  });
  final AuthRepository authRepository;
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch locale and theme changes
    final currentLocale = ref.watch(localeProvider);
    final currentThemeMode = ref.watch(themeModeProvider);

    // Convert AppThemeMode to Flutter's ThemeMode
    final themeMode = (() {
      switch (currentThemeMode) {
        case AppThemeMode.light:
          return ThemeMode.light;
        case AppThemeMode.dark:
          return ThemeMode.dark;
        case AppThemeMode.system:
          return ThemeMode.system;
      }
    })();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepository),
      ],
      child: BlocProvider(
        create: (context) => AuthBloc(
          firebaseAuth: firebaseAuth,
          googleSignIn: googleSignIn,
        ),
        child: MaterialApp(
          title: 'Majot',
          debugShowCheckedModeBanner: false,

          // Localization setup
          locale: currentLocale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: LocalizationService.supportedLocales,

          // Theme setup
          theme: getLightTheme(),
          darkTheme: getDarkTheme(),
          themeMode: themeMode,

          home: const HomePage(),
        ),
      ),
    );
  }
}
