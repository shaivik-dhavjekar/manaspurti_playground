import 'package:flutter/material.dart';

String? validPhone({required TextEditingController phoneController}) {
  if (phoneController == null || phoneController.text.isEmpty) {
    return 'Please enter a phone number';
  } else if (phoneController.text.trim().length != 10 || double.tryParse(phoneController.text.trim()) == null) {
    return 'Phone number should be numeric with only 10 digits';
  }
  return null;
}

String? validOTP({required TextEditingController otpController}) {
  if (otpController == null || otpController.text.isEmpty) {
    return 'Please enter an OTP';
  } else if (otpController.text.trim().length != 6 || double.tryParse(otpController.text.trim()) == null) {
    return 'OTP should be numeric with only 6 digits';
  }
  return null;
}

String? validEmail({required TextEditingController emailController}) {
  final RegExp emailRegEx = RegExp(r'\w+@\w+\.\w+$');
  if (emailController == null || emailController.text.isEmpty) {
    return 'Please enter an email';
  } else if (!emailRegEx.hasMatch(emailController.text.trim())) {
    return 'The email address you entered is invalid. Please try again.';
  }
  return null;
}

String? validPassword({required TextEditingController passwordController}) {
  final RegExp passwordRegex = RegExp(r'^(?=.*[0-9])(?=.*[a-z]).{6,}$'); //(?=.*[A-Z])(?:.*[_#@$!*])
  if (passwordController == null || passwordController.text.isEmpty) {
    return 'Please enter a password';
  } else if (!passwordRegex.hasMatch(passwordController.text.trim())) {
    return "Password should meet the following requirements:\n* At least 6 characters long\n* Includes at least one letter\n* Includes at least one number";
    // return "To create a strong password, please ensure it meets the following requirements:\n* At least 6 characters long\n* Includes at least one lowercase letter (a-z)\n* Includes at least one uppercase letter (A-Z)\n* Includes at least one number (0-9)\n* Special characters (_#@\$!*) are optional.";
  }
  return null;
}