import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Screens/splash_screen.dart';
import '../Screens/reset_password_screen.dart';
import '../Screens/login_callback_screen.dart';
import 'MainScreens/main_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

bool isWaitingForAccountConfirmation = false;
bool isWaitingForGoogleLogin = false;

// 🔥 Normal login click cheythu ennu track cheyyan oru global flag
bool isNormalLoginAttempting = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ttdobhmgppobzbefnwtl.supabase.co',
    publishableKey: 'sb_publishable_zmOjAJDZyVDVEjDFVlSmuA_JsLQfagq',
  );

  runApp(const FitNovaXApp());
}

class FitNovaXApp extends StatefulWidget {
  const FitNovaXApp({super.key});

  @override
  State<FitNovaXApp> createState() => _FitNovaXAppState();
}

class _FitNovaXAppState extends State<FitNovaXApp> {
  StreamSubscription<AuthState>? _authSubscription;

  @override
  void initState() {
    super.initState();
    _listenToAuthChanges();
  }

  void _listenToAuthChanges() {
    _authSubscription = Supabase.instance.client.auth.onAuthStateChange.listen(
      (data) {
        debugPrint('AUTH EVENT: ${data.event}');

        // --------------------------------------------------
        // 1. PASSWORD RECOVERY FLOW
        // --------------------------------------------------
        if (data.event == AuthChangeEvent.passwordRecovery) {
          isWaitingForAccountConfirmation = false;
          isWaitingForGoogleLogin = false;
          isNormalLoginAttempting = false;

          navigatorKey.currentState?.pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const ResetPasswordScreen()),
            (route) => false,
          );
          return;
        }

        // --------------------------------------------------
        // 2. SIGNED IN FLOW
        // --------------------------------------------------
        if (data.event == AuthChangeEvent.signedIn) {
          final session = Supabase.instance.client.auth.currentSession;
          final user = session?.user;

          // Check if Google Login
          final identities = user?.identities;
          bool isGoogleLogin = false;

          if (identities != null && identities.isNotEmpty) {
            isGoogleLogin = identities.any(
              (identity) => identity.provider == 'google',
            );
          }

          // Email already confirmed aano ennariyuka
          final bool isEmailConfirmed = user?.emailConfirmedAt != null;

          // 🔥 Google Login, Normal Login Button click, allel Email already confirmed aanengil -> MainScreen
          if (isGoogleLogin ||
              user?.appMetadata['provider'] == 'google' ||
              isNormalLoginAttempting ||
              isEmailConfirmed) {
            isWaitingForGoogleLogin = false;
            isWaitingForAccountConfirmation = false;
            isNormalLoginAttempting = false; // Reset flag

            navigatorKey.currentState?.pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const MainScreen()),
              (route) => false,
            );
          } else {
            // Puthiya user sign-up cheythu, email innum confirm cheyyathavar aanengil mathram LoginCallbackScreen
            navigatorKey.currentState?.pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const LoginCallbackScreen()),
              (route) => false,
            );
          }
          return;
        }
      },
      onError: (error, stackTrace) {
        debugPrint('AUTH ERROR: $error');
      },
    );
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
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
