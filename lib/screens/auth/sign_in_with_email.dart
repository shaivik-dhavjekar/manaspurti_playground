import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manaspurti_playground/providers/sign_in_with_email_provider.dart';
import 'package:manaspurti_playground/screens/loading_screen.dart';
import 'package:manaspurti_playground/utils/validators.dart';
import 'package:manaspurti_playground/widgets/auth_text_field.dart';
import 'package:provider/provider.dart';

class SignInWithEmailScreen extends StatefulWidget {
  const SignInWithEmailScreen({super.key});

  @override
  State<SignInWithEmailScreen> createState() => _SignInWithEmailScreenState();
}

class _SignInWithEmailScreenState extends State<SignInWithEmailScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignInWithEmailProvider>(context);
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
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.width * 0.4,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text('Sign in with email',
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
                        width: MediaQuery.of(context).size.width * 0.83,
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
                                if (provider.isSignedIn) {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/welcome', (Route<dynamic> route) => false);
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please enter a valid password.'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please enter a valid email.'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(42)),
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
                            Navigator.pushNamed(context, '/forgot_password'),
                        child: const Text(
                          'Forgot Password',
                          style: TextStyle(color: Color(0xFF909891)),
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, '/register_account'),
                        child: const Text(
                          'Don’t have an account? Register here.',
                          style: TextStyle(color: Color(0xFF909891)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Consumer<SignInWithEmailProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const LoadingScreen();
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
