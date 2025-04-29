import 'package:flutter_test/flutter_test.dart';
import 'package:majot/main.dart';
import 'package:majot/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockFirebaseAuth firebaseAuth;
  late MockGoogleSignIn googleSignIn;
  late MockAuthRepository authRepository;

  setUp(() {
    firebaseAuth = MockFirebaseAuth();
    googleSignIn = MockGoogleSignIn();
    authRepository = MockAuthRepository();
  });

  testWidgets('App initializes properly', (WidgetTester tester) async {
    // Test that verifies app starts without crashing
    await tester.pumpWidget(
      MyApp(
        authRepository: authRepository,
        firebaseAuth: firebaseAuth,
        googleSignIn: googleSignIn,
      ),
    );

    expect(find.text('Majot'), findsOneWidget);
    expect(true, isTrue);
  });
}
