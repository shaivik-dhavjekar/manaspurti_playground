import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manaspurti_playground/services/firebase_auth.dart';

class SignInWithPhoneProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  String? _verificationId;
  bool _isVerificationSent = false;
  bool _isVerified = false;
  bool _isLoading = false;

  String? get verificationId => _verificationId;
  bool get isVerificationSent => _isVerificationSent;
  bool get isVerified => _isVerified;
  bool get isLoading => _isLoading;

  void setVerificationId(String? verificationId) {
    _verificationId = verificationId;
    _isVerificationSent=true;
    _isLoading=false;
    notifyListeners();
  }

  Future<void> sendVerificationCode(BuildContext context, {required String phoneNumber}) async {
    _isLoading=true;
    notifyListeners();
    await _authService.verifyPhoneNumber(context, phoneNumber: phoneNumber);
  }

  Future<void> signInWithOTP({required String otp}) async {
    _isLoading=true;
    notifyListeners();

    final bool isVerified = await _authService.signInWithVerificationCode(verificationId: _verificationId!, verificationCode: otp);
    if (isVerified) {
      _isVerified = true;
      _isLoading = false;
      notifyListeners();
    }

    // try {
    //   final PhoneAuthCredential credential = PhoneAuthProvider.credential(
    //     verificationId: _verificationId!,
    //     smsCode: verificationCode,
    //   );
    //   await _auth.signInWithCredential(credential);
    //   _isVerificationSent=false;
    //   _isLoading=false;
    //   notifyListeners();
    // } catch (e) {
    //   debugPrint('Sign-in failed: $e');
    // }
  }

  Future<void> cancelOTPVerification() async {
    _isVerificationSent=false;
    notifyListeners();
  }
}
