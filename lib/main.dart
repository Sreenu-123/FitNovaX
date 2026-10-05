import 'package:flutter/material.dart';

import 'services/api_service.dart';

import '../Screens/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// ============================================
// AUTH FLOW FLAGS
// ============================================

bool isWaitingForAccountConfirmation = false;
bool isWaitingForGoogleLogin = false;

// Normal login button click track cheyyan
bool isNormalLoginAttempting = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ============================================
  // FITNOVAX FASTAPI BACKEND CONNECTION TEST
  // ============================================

  ApiService.testConnection();

  runApp(const FitNovaXApp());
}

class FitNovaXApp extends StatelessWidget {
  const FitNovaXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
