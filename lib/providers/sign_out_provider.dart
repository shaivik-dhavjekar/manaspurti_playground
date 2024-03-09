import 'package:flutter/material.dart';

import '../services/firebase_auth.dart';
import '../utils/generate_exception_message.dart';
import '../utils/show_snack_bar.dart';

class SignOutProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isSignedOut = false;
  bool get isSignedOut => _isSignedOut;

  Future<void> signOut({required BuildContext context}) async {
    try {
      final isSignedOut = await _authService.signOutUser();
      if (isSignedOut) {
        _isSignedOut = true;
        notifyListeners();
      }
    } catch (err) {
      if (context.mounted) {
        showSnackBar(context: context, errorMessage: generateExceptionMessage(err));
      }
    }
  }
}