import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manaspurti_playground/providers/sign_in_with_email_provider.dart';
import 'package:manaspurti_playground/screens/loading_screen.dart';
import 'package:manaspurti_playground/utils/validators.dart';
import 'package:manaspurti_playground/widgets/auth_app_logo.dart';
import 'package:manaspurti_playground/widgets/auth_text_field.dart';
import 'package:provider/provider.dart';

class SignInWithEmailScreen extends StatelessWidget {
  const SignInWithEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            OrientationBuilder(
                builder: (context, orientation) {
                  return SingleChildScrollView(
                    child: orientation == Orientation.portrait ? Column(
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
                        SignInWithEmailScreenForm()
                      ],
                    ) : const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AuthAppLogo(),
                        SignInWithEmailScreenForm(),
                      ],
                    ),
                  );
                }
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

class SignInWithEmailScreenForm extends StatefulWidget {
  const SignInWithEmailScreenForm({super.key});

  @override
  State<SignInWithEmailScreenForm> createState() => _SignInWithEmailScreenFormState();
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
          width: mediaQueryData.orientation == Orientation.portrait ? mediaQueryData.size.width * 0.83 : MediaQuery.of(context).size.width * 0.43,
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
    );
  }
}
