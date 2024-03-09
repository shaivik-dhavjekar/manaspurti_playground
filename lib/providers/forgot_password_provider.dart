import 'package:flutter/material.dart';

import '../services/firebase_auth.dart';
import '../utils/generate_exception_message.dart';
import '../utils/show_snack_bar.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isResetEmailSent = false;
  bool _isLoading = false;

  bool get isResetEmailSent => _isResetEmailSent;
  bool get isLoading => _isLoading;

  Future<void> resetPassword({required BuildContext context, required String email}) async {
    _isLoading = true;
    notifyListeners();
    try {
      final isResetEmailSent = await _authService.sendPasswordResetEmail(email: email);
      if (isResetEmailSent) {
        _isResetEmailSent = true;
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
}