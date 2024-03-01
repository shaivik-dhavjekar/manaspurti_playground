import 'package:flutter/material.dart';
import 'package:manaspurti_playground/services/firebase_auth.dart';

class RegisterAccountProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isRegistered = false;
  bool _isLoading = false;

  bool get isRegistered => _isRegistered;
  bool get isLoading => _isLoading;

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    _isLoading = true;
    notifyListeners();
    final bool isRegistered = await _authService.signUpWithEmailAndPassword(email: email, password: password);
    if (isRegistered) {
      _isRegistered = true;
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateDisplayName({required String displayName}) async {
    await _authService.updateDisplayName(displayName: displayName);
    return;
  }
}
