import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignInWithPhoneScreen extends StatefulWidget {
  const SignInWithPhoneScreen({super.key});

  @override
  State<SignInWithPhoneScreen> createState() =>
      _SignInWithPhoneScreenState();
}

class _SignInWithPhoneScreenState extends State<SignInWithPhoneScreen> {
  final _phoneNumberController = TextEditingController();
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/poker360Logo.png',
              width: MediaQuery.of(context).size.width*0.4,
              height: MediaQuery.of(context).size.width*0.4,
            ),
            const SizedBox(height: 40),
            Text('Sign in with phone', style: GoogleFonts.roboto()),
            const SizedBox(
              height: 10,
            ),
            Consumer<SignInWithPhoneState>(
                builder: (context, phoneState, _) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (!phoneState.isVerificationSent) ...[
                        Container(
                          width: MediaQuery.of(context).size.width*0.93,
                          decoration: BoxDecoration(
                              color: const Color(0xFFD0C8E2),
                              borderRadius: BorderRadius.circular(42)),
                          child: TextFormField(
                            controller: _phoneNumberController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Phone number',
                                prefixIcon: Icon(Icons.phone)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.83,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () async {
                              phoneState.sendVerificationCode(_phoneNumberController.text.toString());
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(42)
                              ),
                              backgroundColor: const Color(0xFF674FA3),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Request OTP'),
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/sign_in_email');
                          },
                          child: const Text('Don’t have a phone? Use email instead.', style: TextStyle(color: Color(0xFF909891)),),
                        )
                      ],
                      if (phoneState.isVerificationSent) ...[
                        Container(
                          width: MediaQuery.of(context).size.width*0.93,
                          decoration: BoxDecoration(
                              color: const Color(0xFFD0C8E2),
                              borderRadius: BorderRadius.circular(42)),
                          child: TextFormField(
                            controller: _otpController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: 'OTP',
                                prefixIcon: Icon(Icons.key)),
                          ),
                        ),
                        SizedBox(height: 20,),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.83,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () async {
                              phoneState.signInWithOTP(_otpController.text.toString());
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(42)
                              ),
                              backgroundColor: const Color(0xFF674FA3),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Verify OTP'),
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        GestureDetector(
                          onTap: () {
                            phoneState.cancelOTPVerification();
                          },
                          child: const Text('Cancel', style: TextStyle(color: Color(0xFF909891)),),
                        )
                      ],
                    ],
                  );
                },)
          ],
        ),
      ),
    );
  }
}

class SignInWithPhoneState extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _verificationId;
  bool _isVerificationSent = false;

  bool get isVerificationSent => _isVerificationSent;

  void setIsVerificationSent(bool sent) {
    _isVerificationSent = sent;
  }

  Future<void> sendVerificationCode(String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+91$phoneNumber',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          notifyListeners();
        },
        verificationFailed: (FirebaseAuthException e) {
          debugPrint('Verification failed: ${e.message}');
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          _verificationId = verificationId;
          setIsVerificationSent(true);
          notifyListeners();
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      debugPrint('Verification code could not be sent : $e');
    }
  }

  Future<void> signInWithOTP(String verificationCode) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: verificationCode,
      );
      await _auth.signInWithCredential(credential);
      setIsVerificationSent(false);
      notifyListeners();
    } catch (e) {
      debugPrint('Sign-in failed: $e');
    }
  }

  Future<void> cancelOTPVerification() async {
    setIsVerificationSent(false);
    notifyListeners();
  }
}
