import 'package:flutter/material.dart';
import 'package:manaspurti_playground/services/firebase_auth.dart';

class SignOutProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isSignedOut = false;
  bool get isSignedOut => _isSignedOut;

  Future<void> signOut() async {
    final isSignedOut = await _authService.signOutUser();
    if (isSignedOut) {
      _isSignedOut = true;
      notifyListeners();
    }
  }
}