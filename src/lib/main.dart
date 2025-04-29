import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majot/blocs/auth/auth_bloc.dart';
import 'package:majot/repositories/auth_repository.dart';
import 'firebase_options.dart';
import 'package:majot/pages/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Create shared instances
  final firebaseAuth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  // Create auth repository
  final authRepository = AuthRepository(
    firebaseAuth: firebaseAuth,
    googleSignIn: googleSignIn,
  );

  runApp(MyApp(
    authRepository: authRepository,
    firebaseAuth: firebaseAuth,
    googleSignIn: googleSignIn,
  ));
}

class MyApp extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomePage(),
        ),
      ),
    );
  }
}
