import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:manaspurti_playground/application/firebase_auth.dart';

class RegisterAccountScreen extends StatefulWidget {
  const RegisterAccountScreen({super.key});

  @override
  State<RegisterAccountScreen> createState() => _RegisterAccountScreenState();
}

class _RegisterAccountScreenState extends State<RegisterAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _nameController.dispose();
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
                  Text('Register Account', style: GoogleFonts.roboto()),
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
                        controller: _nameController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Name',
                            prefixIcon: Icon(Icons.person)),
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
                            final isRegistered = await _authService.signUpWithEmailAndPassword(email: _emailController.text.toString(), password: _passwordController.text.toString());
                            if (isRegistered) {
                              Navigator.pushReplacementNamed(context, '/email_verification');
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
                          Navigator.pushNamed(context, '/forgot_password')
                      ,
                      child: const Text('Forgot Password',
                        style: TextStyle(color: Color(0xFF909891)),),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamedAndRemoveUntil(context, '/sign_in_phone', (Route<dynamic> route) => false)
                      ,
                      child: const Text('Already a member? Sign in here.',
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

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final user = snapshot.data;
              if (user!.emailVerified) {
                Future<void> navigateToNextPage() async {
                  await Future.delayed(const Duration(seconds: 3));
                  Navigator.pushReplacementNamed(context, '/home');
                }
                navigateToNextPage();
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Email verified successfully', textAlign: TextAlign.center, style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.11, color: const Color(0xFF6A736B)),),
                    const SizedBox(height: 30),
                    Icon(Icons.mark_email_read, size: MediaQuery.of(context).size.width*0.25),
                  ],
                );
              } else {
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Email registered successfully', textAlign: TextAlign.center, style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.11, color: const Color(0xFF6A736B)),),
                    const SizedBox(height: 30),
                    Icon(Icons.mark_email_unread, size: MediaQuery.of(context).size.width*0.25),
                    const SizedBox(height: 30),
                    const Text('We have sent a verification link to the registered email address.', textAlign: TextAlign.center, style: TextStyle(color: const Color(0xFF6A736B)),),
                    const SizedBox(height: 20),
                    const Text('Please verify email to continue.', textAlign: TextAlign.center, style: (TextStyle(color: const Color(0xFF6A736B))),),
                  ],
                );
              }
            }
            return Container(); // Your widget UI
          },
        ),
      ),

    );
  }
}
