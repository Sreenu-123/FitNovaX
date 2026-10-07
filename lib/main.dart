import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';

import 'services/api_service.dart';
import 'Screens/splash_screen.dart';
import 'Screens/reset_password_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// ============================================
// AUTH FLOW FLAGS
// ============================================

bool isWaitingForAccountConfirmation = false;
bool isWaitingForGoogleLogin = false;

// Normal login button click track cheyyan
bool isNormalLoginAttempting = false;

// ============================================
// PASSWORD RESET DEEP LINK
// ============================================

final AppLinks _appLinks = AppLinks();

StreamSubscription<Uri>? _deepLinkSubscription;

bool isPasswordResetFlow = false;

// ============================================
// HANDLE PASSWORD RESET LINK
// ============================================

void _handleDeepLink(Uri uri) {
  debugPrint('DEEP LINK RECEIVED: $uri');

  // Example:
  // fitnovax://reset-password?token=ABC123

  if (uri.scheme != 'fitnovax') {
    return;
  }

  if (uri.host != 'reset-password') {
    return;
  }

  final String? token = uri.queryParameters['token'];

  if (token == null || token.trim().isEmpty) {
    debugPrint('PASSWORD RESET TOKEN NOT FOUND');
    return;
  }

  debugPrint('PASSWORD RESET TOKEN RECEIVED');

  isPasswordResetFlow = true;

  WidgetsBinding.instance.addPostFrameCallback((_) {
    final navigator = navigatorKey.currentState;

    if (navigator == null) {
      debugPrint('Navigator is not ready yet.');
      return;
    }

    navigator.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => ResetPasswordScreen(token: token),
      ),
      (route) => false,
    );
  });
}

// ============================================
// INITIAL DEEP LINK
// ============================================

Future<void> _handleInitialDeepLink() async {
  try {
    final Uri? initialUri = await _appLinks.getInitialLink();

    if (initialUri != null) {
      debugPrint('INITIAL DEEP LINK: $initialUri');

      _handleDeepLink(initialUri);
    }
  } catch (error) {
    debugPrint('INITIAL DEEP LINK ERROR: $error');
  }
}

// ============================================
// LISTEN FOR DEEP LINKS
// ============================================

void _listenForDeepLinks() {
  _deepLinkSubscription = _appLinks.uriLinkStream.listen(
    (Uri uri) {
      _handleDeepLink(uri);
    },
    onError: (error) {
      debugPrint('DEEP LINK STREAM ERROR: $error');
    },
  );
}

// ============================================
// MAIN
// ============================================

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ============================================
  // FITNOVAX FASTAPI BACKEND CONNECTION TEST
  // ============================================

  ApiService.testConnection();

  // ============================================
  // DEEP LINK LISTENER
  // ============================================

  _listenForDeepLinks();

  // Check if app was opened directly
  // through a deep link.
  await _handleInitialDeepLink();

  // ============================================
  // RUN APP
  // ============================================

  runApp(const FitNovaXApp());
}

// ============================================
// FITNOVAX APP
// ============================================

class FitNovaXApp extends StatelessWidget {
  const FitNovaXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,

      // ==========================================
      // DEFAULT APP SCREEN
      // ==========================================
      home: const SplashScreen(),
    );
  }
}
