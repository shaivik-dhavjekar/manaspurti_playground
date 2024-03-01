import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:manaspurti_playground/providers/register_account_provider.dart';
import 'package:manaspurti_playground/screens/loading_screen.dart';
import 'package:manaspurti_playground/services/firebase_auth.dart';
import 'package:manaspurti_playground/utils/validators.dart';
import 'package:manaspurti_playground/widgets/auth_text_field.dart';
import 'package:provider/provider.dart';

class RegisterAccountScreen extends StatefulWidget {
  const RegisterAccountScreen({super.key});

  @override
  State<RegisterAccountScreen> createState() => _RegisterAccountScreenState();
}

class _RegisterAccountScreenState extends State<RegisterAccountScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegisterAccountProvider>(context);
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SingleChildScrollView(
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
                  SizedBox(
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text('Register Account',
                            style: GoogleFonts.roboto(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        Positioned(
                          left: MediaQuery.of(context).size.width * 0.2,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              Icons.arrow_back,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AuthTextField(textEditingController: _nameController, labelText: 'Name', prefixIcon: Icons.person),
                      const SizedBox(
                        height: 20,
                      ),
                      AuthTextField(
                          textEditingController: _emailController,
                          labelText: 'Email',
                          prefixIcon: Icons.email),
                      const SizedBox(
                        height: 20,
                      ),
                      AuthTextField(
                          textEditingController: _passwordController,
                          labelText: 'Password',
                          prefixIcon: Icons.key,
                          obscureText: true),
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
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (validEmail(emailController: _emailController)) {
                              if (validPassword(
                                  passwordController: _passwordController)) {
                                await provider.signInWithEmailAndPassword(
                                    email: _emailController.text,
                                    password: _passwordController.text);
                                if (provider.isRegistered) {
                                  if (_nameController != null && _nameController.text.trim().isNotEmpty) {
                                    await provider.updateDisplayName(displayName: _nameController.text);
                                  }
                                  Navigator.pushReplacementNamed(context, '/email_verification');
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please enter a valid password.'),
                                    backgroundColor: Color(0xFFEFA39F),
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please enter a valid email.'),
                                  backgroundColor: Color(0xFFEFA39F),
                                ),
                              );
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
                            Navigator.pushNamedAndRemoveUntil(context, '/sign_in_with_phone', (Route<dynamic> route) => false)
                        ,
                        child: const Text('Already a member? Sign in here.',
                          style: TextStyle(color: Color(0xFF909891)),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Consumer<RegisterAccountProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const LoadingScreen();
                }
                return Container();
              },
            )
          ],
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
          stream: AuthService().authStateChanges,
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
            return Text('Not Working'); // Your widget UI
          },
        ),
      ),
    );
  }
}
