import 'package:flutter/material.dart';

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