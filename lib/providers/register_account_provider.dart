import 'package:flutter/material.dart';

import '../services/firebase_auth.dart';
import '../utils/generate_exception_message.dart';
import '../utils/show_snack_bar.dart';

class RegisterAccountProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isRegistered = false;
  bool _isLoading = false;

  bool get isRegistered => _isRegistered;
  bool get isLoading => _isLoading;

  Future<void> signInWithEmailAndPassword(
      {required BuildContext context, required String email, required String password}) async {
    _isLoading = true;
    notifyListeners();
    try {
      final bool isRegistered = await _authService.signUpWithEmailAndPassword(email: email, password: password);
      if (isRegistered) {
        _isRegistered = true;
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

  Future<void> updateDisplayName({required String displayName}) async {
    await _authService.updateDisplayName(displayName: displayName);
    return;
  }
}

