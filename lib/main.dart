import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/forgot_password_provider.dart';
import 'providers/register_account_provider.dart';
import 'providers/sign_in_with_email_provider.dart';
import 'providers/sign_in_with_phone_provider.dart';
import 'providers/sign_out_provider.dart';
import 'screens/auth/forgot_password.dart';
import 'screens/auth/register_account.dart';
import 'screens/auth/sign_in_with_email.dart';
import 'screens/auth/sign_in_with_phone.dart';
import 'screens/home/home.dart';
import 'screens/splash.dart';
import 'screens/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => SignInWithPhoneProvider()),
            ChangeNotifierProvider(create: (context) => SignInWithEmailProvider()),
            ChangeNotifierProvider(create: (context) => RegisterAccountProvider()),
            ChangeNotifierProvider(create: (context) => ForgotPasswordProvider()),
            ChangeNotifierProvider(create: (context) => SignOutProvider()),
          ],
      child: const MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFEF7FF),
        textTheme: GoogleFonts.cabinTextTheme(),
        // inputDecorationTheme: InputDecorationTheme(
        //   filled: true,
        //   fillColor: const Color(0xFFD0C8E2),
        //   border: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(42),
        //   ),
        // ),
        // outlinedButtonTheme: OutlinedButtonThemeData(
        //   style: ButtonStyle(
        //     padding: MaterialStateProperty.all<EdgeInsets>(
        //       const EdgeInsets.all(24),
        //     ),
        //     backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF674FA3)),
        //     foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        //   ),
        // ),
        useMaterial3: true,
      ),
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
}


