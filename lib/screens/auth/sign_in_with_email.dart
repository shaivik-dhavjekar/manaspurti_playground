import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/sign_in_with_email_provider.dart';
import '../../utils/get_scale_value.dart';
import '../../utils/show_snack_bar.dart';
import '../../utils/validators.dart';
import '../../widgets/auth_app_logo.dart';
import '../../widgets/auth_text_field.dart';
import '../loading_screen.dart';

class SignInWithEmailScreen extends StatelessWidget {
  const SignInWithEmailScreen({super.key});

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
                            Text('Sign in with email',
                                style: GoogleFonts.roboto(
                                    fontSize: 16 * getScaleValue(context),
                                    fontWeight: FontWeight.w500)),
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
                      const SignInWithEmailScreenForm()
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
                              Text('Sign in with email',
                                  style: GoogleFonts.roboto(
                                      fontSize: 16 * getScaleValue(context),
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
                          const SignInWithEmailScreenForm(),
                        ],
                      ),
                    ],
                  ),
                );
              }),
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
      ),
    );
  }
}

class SignInWithEmailScreenForm extends StatefulWidget {
  const SignInWithEmailScreenForm({super.key});

  @override
  State<SignInWithEmailScreenForm> createState() =>
      _SignInWithEmailScreenFormState();
}

class _SignInWithEmailScreenFormState extends State<SignInWithEmailScreenForm> {
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
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final provider = Provider.of<SignInWithEmailProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 10,
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
                    if (provider.isSignedIn && context.mounted) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/welcome', (Route<dynamic> route) => false);
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
            child: Text('Sign in', style: TextStyle(fontSize: 16 * getScaleValue(context), fontWeight: FontWeight.bold),),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/forgot_password'),
          child: Text(
            'Forgot Password',
            style: TextStyle(
                color: const Color(0xFF909891),
                fontSize: 14 * getScaleValue(context)),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/register_account'),
          child: Text(
            'Don’t have an account? Register here.',
            style: TextStyle(
                color: const Color(0xFF909891),
                fontSize: 14 * getScaleValue(context)),
          ),
        ),
      ],
    );
  }
}
