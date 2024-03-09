import 'package:flutter/material.dart';

import '../services/firebase_auth.dart';
import '../utils/generate_exception_message.dart';
import '../utils/show_snack_bar.dart';

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
    _isVerificationSent = true;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> sendVerificationCode({required BuildContext context, required String phoneNumber}) async {
    _isLoading=true;
    notifyListeners();
    try {
      await _authService.verifyPhoneNumber(context, phoneNumber: phoneNumber);
      return;
    } catch (err) {
      _isLoading = false;
      notifyListeners();
      if (context.mounted) {
        showSnackBar(context: context, errorMessage: generateExceptionMessage(err));
      }
    }
  }

  Future<void> signInWithOTP({required BuildContext context, required String otp}) async {
    _isLoading=true;
    notifyListeners();
    try {
      final bool isVerified = await _authService.signInWithVerificationCode(verificationId: _verificationId!, verificationCode: otp);
      if (isVerified) {
        _isVerified = true;
        _isLoading = false;
        notifyListeners();
      }
    } catch (err) {
      _isLoading = false;
      notifyListeners();
      if (context.mounted) {
        showSnackBar(context: context, errorMessage: generateExceptionMessage(err));
      }
    }
  }

  Future<void> cancelOTPVerification() async {
    _isVerificationSent = false;
    notifyListeners();
  }
}
