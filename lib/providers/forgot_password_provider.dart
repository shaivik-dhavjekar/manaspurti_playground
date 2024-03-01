import 'package:flutter/material.dart';
import 'package:manaspurti_playground/services/firebase_auth.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isResetEmailSent = false;
  bool _isLoading = false;

  bool get isResetEmailSent => _isResetEmailSent;
  bool get isLoading => _isLoading;

  Future<void> resetPassword({required String email}) async {
    _isLoading = true;
    notifyListeners();
    final isResetEmailSent = await _authService.sendPasswordResetEmail(email: email);
    if (isResetEmailSent) {
      _isResetEmailSent = true;
      _isLoading = false;
      notifyListeners();
    }
  }
}