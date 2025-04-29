import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthGoogleSignInRequested extends AuthEvent {}

class AuthSignOutRequested extends AuthEvent {}

// States
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  const AuthSuccess(this.user);
  final User user;

  @override
  List<Object?> get props => [user];
}

class AuthFailure extends AuthState {
  const AuthFailure(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn(),
        super(AuthInitial()) {
    on<AuthGoogleSignInRequested>(_onGoogleSignIn);
    on<AuthSignOutRequested>(_onSignOut);
  }
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  Future<void> _onGoogleSignIn(
    AuthGoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());

      // Trigger Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        emit(const AuthFailure('Google sign in was cancelled by user'));
        return;
      }

      // Get authentication details from the Google account
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a credential with the Google tokens
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      emit(AuthSuccess(userCredential.user!));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onSignOut(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
