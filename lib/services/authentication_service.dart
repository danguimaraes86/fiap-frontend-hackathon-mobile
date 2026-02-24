import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend_hackathon_mobile/models/authentication_model.dart';
import 'package:frontend_hackathon_mobile/models/user_model.dart';
import 'package:frontend_hackathon_mobile/services/exceptions/authentication_exception.dart';
import 'package:frontend_hackathon_mobile/services/utils/firebase_errors_util.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String getLoggedUserId() {
    return _auth.currentUser!.uid;
  }

  Stream<UserModel?> get authStateChanges {
    return _auth.authStateChanges().map((firebaseUser) {
      if (firebaseUser == null) return null;
      return UserModel(
        uid: firebaseUser.uid,
        name: firebaseUser.displayName ?? 'Nome do usuário',
        email: firebaseUser.email ?? 'Email do usuário',
      );
    });
  }

  Future<UserModel> signupUser(SignupRequest request) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );
      await _auth.currentUser?.updateDisplayName(request.name);

      UserModel user = UserModel(
        uid: credential.user!.uid,
        name: request.name,
        email: request.email,
      );
      return user;
    } on FirebaseAuthException catch (exception) {
      throw SignUpException(getFirebaseErrorMessage(exception));
    }
  }

  Future<UserModel> loginUser(LoginRequest request) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );

      return UserModel(
        uid: credential.user!.uid,
        name: credential.user!.displayName ?? 'Nome do usuário',
        email: credential.user!.email ?? 'Email do usuário',
      );
    } on FirebaseAuthException catch (exception) {
      throw LoginException(getFirebaseErrorMessage(exception));
    }
  }

  void logout() async {
    await _auth.signOut();
  }
}
