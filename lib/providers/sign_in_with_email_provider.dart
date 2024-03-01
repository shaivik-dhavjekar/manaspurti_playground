import 'package:flutter/material.dart';
import 'package:manaspurti_playground/services/firebase_auth.dart';

class SignInWithEmailProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isSignedIn = false;
  bool _isLoading = false;

  bool get isSignedIn => _isSignedIn;
  bool get isLoading => _isLoading;

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    _isLoading = true;
    notifyListeners();
    final bool isSignedIn = await _authService.signInWithEmailAndPassword(
        email: email, password: password);
    if (isSignedIn) {
      _isSignedIn = true;
      _isLoading = false;
      notifyListeners();
    }
  }
}
