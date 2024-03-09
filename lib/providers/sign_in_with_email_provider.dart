import 'package:flutter/material.dart';

import '../services/firebase_auth.dart';
import '../utils/generate_exception_message.dart';
import '../utils/show_snack_bar.dart';

class SignInWithEmailProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isSignedIn = false;
  bool _isLoading = false;

  bool get isSignedIn => _isSignedIn;
  bool get isLoading => _isLoading;

  Future<void> signInWithEmailAndPassword(
      {required BuildContext context, required String email, required String password}) async {
    _isLoading = true;
    notifyListeners();
    try {
      final bool isSignedIn = await _authService.signInWithEmailAndPassword(
          email: email, password: password);
      if (isSignedIn) {
        _isSignedIn = true;
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
