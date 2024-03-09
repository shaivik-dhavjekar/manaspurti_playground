import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../../providers/register_account_provider.dart';
import '../../utils/get_scale_value.dart';
import '../../utils/show_snack_bar.dart';
import '../../utils/validators.dart';
import '../../widgets/auth_app_logo.dart';
import '../../widgets/auth_text_field.dart';
import '../../widgets/verified_screen.dart';
import '../loading_screen.dart';

class RegisterAccountScreen extends StatelessWidget {
  const RegisterAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              OrientationBuilder(builder: (context, orientation) {
                return SingleChildScrollView(
                    child: orientation == Orientation.portrait
                        ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const AuthAppLogo(),
                        const SizedBox(height: 40),
                        SizedBox(
                          width: double.infinity,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Text('Register Account',
                                  style: GoogleFonts.roboto(
                                      fontSize:
                                      16 * getScaleValue(context),
                                      fontWeight: FontWeight.w500)),
                              Positioned(
                                left: MediaQuery.of(context).size.width *
                                    0.2,
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
                        const RegisterAccountScreenForm()
                      ],
                    )
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const AuthAppLogo(),
                        Column(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Text('Register Account',
                                    style: GoogleFonts.roboto(
                                        fontSize:
                                        16 * getScaleValue(context),
                                        fontWeight: FontWeight.w500)),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.4),
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
                            const RegisterAccountScreenForm(),
                          ],
                        ),
                      ],
                    ));
              }),
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
        ),
      ),
    );
  }
}

class RegisterAccountScreenForm extends StatefulWidget {
  const RegisterAccountScreenForm({super.key});

  @override
  State<RegisterAccountScreenForm> createState() =>
      _RegisterAccountScreenFormState();
}

class _RegisterAccountScreenFormState extends State<RegisterAccountScreenForm> {
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
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final provider = Provider.of<RegisterAccountProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 10,
        ),
        AuthTextField(
            textEditingController: _nameController,
            labelText: 'Name',
            prefixIcon: Icons.person),
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
          width: mediaQueryData.orientation == Orientation.portrait
              ? mediaQueryData.size.width * 0.83
              : MediaQuery.of(context).size.width * 0.43,
          height: 48,
          child: ElevatedButton(
            onPressed: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              final String? isValidEmail = validEmail(emailController: _emailController);
              if (isValidEmail == null) {
                final String? isValidPassword = validPassword(passwordController: _passwordController);
                if (isValidPassword == null) {
                  await provider.signInWithEmailAndPassword(
                    context: context,
                      email: _emailController.text,
                      password: _passwordController.text);
                  if (provider.isRegistered) {
                    if (_nameController.text.trim().isNotEmpty) {
                      await provider.updateDisplayName(
                          displayName: _nameController.text);
                    }
                    Navigator.pushReplacementNamed(
                        context, '/email_verification');
                  }
                } else {
                  showSnackBar(context: context, errorMessage: isValidPassword);
                }
              } else {
                showSnackBar(context: context, errorMessage: isValidEmail);
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(42)),
              backgroundColor: const Color(0xFF674FA3),
              foregroundColor: Colors.white,
            ),
            child: Text(
              'Register Account',
              style: TextStyle(fontSize: 16 * getScaleValue(context), fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/forgot_password'),
          child: Text(
            'Forgot Password',
            style: TextStyle(color: Color(0xFF909891), fontSize: 14 * getScaleValue(context)),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamedAndRemoveUntil(
              context, '/sign_in_with_phone', (Route<dynamic> route) => false),
          child: Text(
            'Already a member? Sign in here.',
            style: TextStyle(color: Color(0xFF909891), fontSize: 14 * getScaleValue(context)),
          ),
        ),
      ],
    );
  }
}

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Navigator.pushReplacementNamed(context, '/email_verified');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return const VerifiedScreen(title: 'Email registered successfully', icon: Icons.mark_email_unread, extraContent: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'We have sent a verification link to the registered email address.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFF6A736B)),
        ),
        SizedBox(height: 20),
        Text(
          'Please verify email to continue.',
          textAlign: TextAlign.center,
          style: (TextStyle(color: Color(0xFF6A736B))),
        ),
      ],
    ),);
  }
}

class EmailVerifiedScreen extends StatefulWidget {
  const EmailVerifiedScreen({super.key});

  @override
  State<EmailVerifiedScreen> createState() =>
      _EmailVerifiedScreenState();
}

class _EmailVerifiedScreenState extends State<EmailVerifiedScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      setState(() {
        Navigator.pushReplacementNamed(context, '/welcome');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const VerifiedScreen(title: 'Email verified successfully', icon: Icons.mark_email_read);
  }
}

