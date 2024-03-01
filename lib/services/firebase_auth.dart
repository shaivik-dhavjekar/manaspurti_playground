import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:manaspurti_playground/providers/sign_in_with_phone_provider.dart';
import 'package:provider/provider.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<bool> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      await userCredential.user!.sendEmailVerification();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      } else {
        debugPrint(e.toString());
      }
    }
    return false;
  }

  Future<void> updateDisplayName({required String displayName}) async {
    try {
      User? currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        await currentUser.updateProfile(displayName: displayName.trim());
      }
    } catch (e) {
      debugPrint(e.toString());
    }

  }

  Future<bool> verifyEmail() async {
    User? currentUser = _firebaseAuth.currentUser;
    await currentUser!.reload();
    currentUser = _firebaseAuth.currentUser;
    return currentUser?.emailVerified ?? false;
  }

  Future<String?> fetchUserDisplayName() async {
    User? currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      return currentUser!.displayName;
    }
    return null;
  }

  Future<bool> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
              email: email.trim(), password: password.trim());
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      } else {
        debugPrint(e.toString());
      }
    }
    return false;
  }

  Future<void> verifyPhoneNumber(BuildContext context,
      {required String phoneNumber}) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: '+91$phoneNumber',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          debugPrint('Verification failed: ${e.message}');
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          Provider.of<SignInWithPhoneProvider>(context, listen: false)
              .setVerificationId(verificationId);
          return;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      debugPrint('Verification code could not be sent : $e');
    }
  }

  Future<bool> signInWithVerificationCode({required String verificationId, required String verificationCode}) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: verificationCode,
      );
      await _firebaseAuth.signInWithCredential(credential);
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  Future<bool> sendPasswordResetEmail({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email.trim());
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  Future<void> signOutUser() async {
    final User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      await _firebaseAuth.signOut();
    }
  }
}
