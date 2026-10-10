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

bool isNormalLoginAttempting = false;

// ============================================
// PASSWORD RESET DEEP LINK
// ============================================

final AppLinks _appLinks = AppLinks();

StreamSubscription<Uri>? _deepLinkSubscription;

bool isPasswordResetFlow = false;

String? _pendingResetToken;
String? _lastHandledUri;

// ============================================
// HANDLE DEEP LINK
// ============================================

void _handleDeepLink(Uri uri) {
  debugPrint('DEEP LINK RECEIVED: $uri');

  if (uri.scheme != 'fitnovax') {
    return;
  }

  // Avoid processing the same URI twice.
  if (_lastHandledUri == uri.toString()) {
    return;
  }

  if (uri.host != 'reset-password') {
    // Other deep links, such as login-callback,
    // are not handled by this password-reset handler.
    return;
  }

  final String? token = uri.queryParameters['token'];

  if (token == null || token.trim().isEmpty) {
    debugPrint('PASSWORD RESET TOKEN NOT FOUND');
    return;
  }

  _lastHandledUri = uri.toString();
  _pendingResetToken = token;
  isPasswordResetFlow = true;

  _openResetScreenWhenReady();
}

// ============================================
// OPEN RESET SCREEN
// ============================================

void _openResetScreenWhenReady() {
  final String? token = _pendingResetToken;

  if (token == null || token.isEmpty) {
    return;
  }

  final navigator = navigatorKey.currentState;

  if (navigator == null) {
    // Keep the token pending until MaterialApp is ready.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _openResetScreenWhenReady();
    });
    return;
  }

  // Consume the pending token before navigation to avoid
  // opening the same reset screen more than once.
  _pendingResetToken = null;

  navigator.pushAndRemoveUntil(
    MaterialPageRoute<void>(
      builder: (context) => ResetPasswordScreen(token: token),
    ),
    (route) => false,
  );
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
    onError: (Object error) {
      debugPrint('DEEP LINK STREAM ERROR: $error');
    },
  );
}

// ============================================
// MAIN
// ============================================

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Start listening for incoming links.
  _listenForDeepLinks();

  // Check whether the app was launched through a link.
  await _handleInitialDeepLink();

  // Test backend connectivity.
  // Do not block app startup if this request fails.
  unawaited(_testBackendConnection());

  runApp(const FitNovaXApp());
}

Future<void> _testBackendConnection() async {
  try {
    await ApiService.testConnection();
  } catch (error) {
    debugPrint('BACKEND CONNECTION ERROR: $error');
  }
}

// ============================================
// FITNOVAX APP
// ============================================

class FitNovaXApp extends StatefulWidget {
  const FitNovaXApp({super.key});

  @override
  State<FitNovaXApp> createState() => _FitNovaXAppState();
}

class _FitNovaXAppState extends State<FitNovaXApp> {
  @override
  void initState() {
    super.initState();

    // The first frame ensures MaterialApp's Navigator exists.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _openResetScreenWhenReady();
    });
  }

  @override
  void dispose() {
    _deepLinkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
