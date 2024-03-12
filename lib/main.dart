import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/forgot_password_provider.dart';
import 'providers/register_account_provider.dart';
import 'providers/sign_in_with_email_provider.dart';
import 'providers/sign_in_with_phone_provider.dart';
import 'providers/sign_out_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/user_profile_provider.dart';
import 'screens/auth/forgot_password.dart';
import 'screens/auth/register_account.dart';
import 'screens/auth/sign_in_with_email.dart';
import 'screens/auth/sign_in_with_phone.dart';
import 'screens/home/home.dart';
import 'screens/splash.dart';
import 'screens/welcome.dart';
import 'utils/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => ThemeProvider()),
            ChangeNotifierProvider(create: (context) => SignInWithPhoneProvider()),
            ChangeNotifierProvider(create: (context) => SignInWithEmailProvider()),
            ChangeNotifierProvider(create: (context) => RegisterAccountProvider()),
            ChangeNotifierProvider(create: (context) => ForgotPasswordProvider()),
            ChangeNotifierProvider(create: (context) => SignOutProvider()),
            ChangeNotifierProvider(create: (context) => UserProfileProvider()),
          ],
      child: const MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, provider, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          themeMode: provider.themeMode == ThemeMode.light ? ThemeMode.light : ThemeMode.dark,
          theme: lightTheme,
          darkTheme: darkTheme,
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
          routes: {
            // '/': (context) => SplashScreen(),
            '/sign_in_with_phone': (context) => const SignInWithPhoneScreen(),
            '/sign_in_with_email': (context) => const SignInWithEmailScreen(),
            '/register_account': (context) => const RegisterAccountScreen(),
            '/email_verification': (context) => const EmailVerificationScreen(),
            '/email_verified': (context) => const EmailVerifiedScreen(),
            '/forgot_password': (context) => const ForgotPasswordScreen(),
            '/welcome': (context) => const WelcomeScreen(),
            '/home': (context) => const NavigatorScreen()
          },
        );
      }
    );
  }
}


