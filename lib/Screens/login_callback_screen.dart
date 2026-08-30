import 'package:flutter/material.dart';

import '../Screens/login_screen.dart';

class LoginCallbackScreen extends StatelessWidget {
  const LoginCallbackScreen({super.key});

  static const Color primaryColor = Color.fromARGB(255, 34, 174, 239);
  static const Color subtitleColor = Color.fromARGB(255, 198, 197, 197);

  void _goToSignIn(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              // LOGO
              Image.asset(
                'assets/Images/logoNoBack.png',
                height: 90,
                width: 90,
              ),

              const SizedBox(height: 45),

              // SUCCESS ICON
              Container(
                height: 90,
                width: 90,

                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),

                child: const Icon(
                  Icons.check_rounded,
                  color: primaryColor,
                  size: 52,
                ),
              ),

              const SizedBox(height: 30),

              // TITLE
              const Text(
                'Account Confirmed',
                textAlign: TextAlign.center,

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 12),

              // MESSAGE
              const Text(
                'Your email has been verified successfully.\n'
                'You can now sign in to your FitNovaX account.',
                textAlign: TextAlign.center,

                style: TextStyle(
                  color: subtitleColor,
                  fontSize: 14,
                  height: 1.6,
                ),
              ),

              const SizedBox(height: 40),

              // GO TO SIGN IN
              SizedBox(
                width: double.infinity,
                height: 52,

                child: ElevatedButton(
                  onPressed: () => _goToSignIn(context),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),

                  child: const Text(
                    'Go to Sign In',

                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
