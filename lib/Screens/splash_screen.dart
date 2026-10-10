import 'package:flutter/material.dart';

import 'package:fit_nova_x/Screens/login_screen.dart';
import 'package:fit_nova_x/MainScreens/main_screen.dart';

import 'package:fit_nova_x/services/api_service.dart';
import 'package:fit_nova_x/services/session_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _checkLoginSession();
  }

  Future<void> _checkLoginSession() async {
    // Keep splash screen visible for 3 seconds.
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    // ----------------------------------------------------------
    // CHECK LOCAL LOGIN SESSION
    // ----------------------------------------------------------

    final bool isLoggedIn = await SessionService.isLoggedIn();

    if (!mounted) return;

    // ----------------------------------------------------------
    // NO SESSION
    // → LOGIN SCREEN
    // ----------------------------------------------------------

    if (!isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );

      return;
    }

    // ----------------------------------------------------------
    // GET SAVED USER ID
    // ----------------------------------------------------------

    final String? userId = await SessionService.getUserId();

    if (!mounted) return;

    // If session exists but user ID is missing,
    // clear the invalid session.
    if (userId == null || userId.isEmpty) {
      await SessionService.clearSession();

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );

      return;
    }

    // ----------------------------------------------------------
    // CHECK USER PROFILE FROM BACKEND
    // ----------------------------------------------------------

    try {
      final profileResult = await ApiService.getUserProfile(userId: userId);

      if (!mounted) return;

      final bool profileExists = profileResult['exists'] == true;

      // --------------------------------------------------------
      // PROFILE EXISTS
      // → MAIN SCREEN
      // --------------------------------------------------------

      if (profileExists) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );

        return;
      }

      // --------------------------------------------------------
      // PROFILE DOES NOT EXIST
      // --------------------------------------------------------
      //
      // Session is still valid, but profile is incomplete.
      // For now, send user back to LoginScreen.
      // --------------------------------------------------------

      await SessionService.clearSession();

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } catch (error) {
      // --------------------------------------------------------
      // BACKEND CONNECTION FAILED
      // --------------------------------------------------------

      if (!mounted) return;

      debugPrint('Session check error: $error');

      // If backend cannot be reached,
      // don't blindly open MainScreen.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/Images/logoNoBack.png',
              width: 180,
              height: 180,
            ),
          ),

          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'FitNovaX',
                  style: TextStyle(color: Colors.white, fontSize: 33),
                ),

                const SizedBox(height: 0),

                const Text(
                  'Train. Level Up. Conquer',
                  style: TextStyle(
                    color: Color.fromARGB(255, 198, 197, 197),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
