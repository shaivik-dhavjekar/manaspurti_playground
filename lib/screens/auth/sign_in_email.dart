import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manaspurti_playground/application/firebase_auth.dart';
import 'package:manaspurti_playground/screens/auth/register_account.dart';
import 'package:manaspurti_playground/screens/welcome.dart';

class SignInWithEmailScreen extends StatefulWidget {
  const SignInWithEmailScreen({super.key});

  @override
  State<SignInWithEmailScreen> createState() => _SignInWithEmailScreenState();
}

class _SignInWithEmailScreenState extends State<SignInWithEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/poker360Logo.png',
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.4,
                height: MediaQuery
                    .of(context)
                    .size
                    .width * 0.4,
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back),
                  ),
                  SizedBox(width: 10),
                  Text('Sign in with email', style: GoogleFonts.roboto()),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.93,
                      decoration: BoxDecoration(
                          color: const Color(0xFFD0C8E2),
                          borderRadius: BorderRadius.circular(42)),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email)),
                        validator: (value) =>
                        value == null || value.isEmpty
                            ? 'Please enter your email'
                            : null,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.93,
                      decoration: BoxDecoration(
                          color: const Color(0xFFD0C8E2),
                          borderRadius: BorderRadius.circular(42)),
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.key),
                        ),
                        obscureText: true,
                        obscuringCharacter: '*',
                        validator: (value) =>
                        value == null || value.isEmpty
                            ? 'Please enter your password'
                            : null,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.83,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final isSignedIn = await _authService.signInWithEmailAndPassword(email: _emailController.text.toString(), password: _passwordController.text.toString());
                            if (isSignedIn) {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const WelcomeScreen()));
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(42)
                          ),
                          backgroundColor: const Color(0xFF674FA3),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Sign in'),
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    GestureDetector(
                      onTap: () =>
                          // Navigator.pushNamed(context, '/forgot_password')
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const EmailVerificationScreen()))
                      ,
                      child: const Text('Forgot Password',
                        style: TextStyle(color: Color(0xFF909891)),),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, '/register_account')
                      ,
                      child: const Text('Don’t have an account? Register here.',
                        style: TextStyle(color: Color(0xFF909891)),),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),);
  }
}
