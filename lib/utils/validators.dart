import 'package:flutter/material.dart';

bool validPhone({required TextEditingController phoneController}) {
  if (phoneController == null || phoneController.text.isEmpty) {
    return false;
  } else if (phoneController.text.trim().length != 10 || double.tryParse(phoneController.text.trim()) == null) {
    return false;
  }
  return true;
}

bool validOTP({required TextEditingController otpController}) {
  if (otpController == null || otpController.text.isEmpty) {
    return false;
  } else if (otpController.text.trim().length != 6 || double.tryParse(otpController.text.trim()) == null) {
    return false;
  }
  return true;
}

bool validEmail({required TextEditingController emailController}) {
  if (emailController == null || emailController.text.isEmpty) {
    return false;
  }
  return true;
}

bool validPassword({required TextEditingController passwordController}) {
  if (passwordController == null || passwordController.text.isEmpty) {
    return false;
  }
  return true;
}