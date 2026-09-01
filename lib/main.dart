import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Screens/splash_screen.dart';
import '../Screens/reset_password_screen.dart';
import '../Screens/login_callback_screen.dart';
import '../Screens/login_screen.dart';
import 'MainScreens/main_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

bool isWaitingForAccountConfirmation = false;
bool isWaitingForGoogleLogin = false;

// Normal login button click track cheyyan
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
      (data) async {
        debugPrint('AUTH EVENT: ${data.event}');

        // ==================================================
        // 1. PASSWORD RECOVERY
        // ==================================================

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

        // ==================================================
        // 2. SIGNED IN
        // ==================================================

        if (data.event == AuthChangeEvent.signedIn) {
          final session = Supabase.instance.client.auth.currentSession;

          final user = session?.user;

          if (user == null) {
            return;
          }

          // ==================================================
          // EMAIL CONFIRMATION
          // ==================================================

          if (isWaitingForAccountConfirmation) {
            isWaitingForAccountConfirmation = false;
            isWaitingForGoogleLogin = false;
            isNormalLoginAttempting = false;

            navigatorKey.currentState?.pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const LoginCallbackScreen()),
              (route) => false,
            );

            return;
          }

          // ==================================================
          // GOOGLE LOGIN CHECK
          // ==================================================

          final identities = user.identities;

          final bool isGoogleLogin =
              identities != null &&
              identities.any((identity) => identity.provider == 'google');

          final bool isGoogleProvider =
              user.appMetadata['provider'] == 'google';

          // ==================================================
          // GOOGLE LOGIN
          // ==================================================

          if (isGoogleLogin || isGoogleProvider) {
            debugPrint('GOOGLE LOGIN DETECTED');

            try {
              // ----------------------------------------------
              // CHECK FITNOVAX PROFILE
              // ----------------------------------------------

              final profile = await Supabase.instance.client
                  .from('profiles')
                  .select('id')
                  .eq('id', user.id)
                  .maybeSingle();

              // ----------------------------------------------
              // PROFILE DOES NOT EXIST
              // ----------------------------------------------

              if (profile == null) {
                debugPrint('GOOGLE USER NOT REGISTERED IN FITNOVAX');

                isWaitingForGoogleLogin = false;
                isWaitingForAccountConfirmation = false;
                isNormalLoginAttempting = false;

                await Supabase.instance.client.auth.signOut();

                navigatorKey.currentState?.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );

                ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'No FitNovaX account found. Please sign up first.',
                    ),
                  ),
                );

                return;
              }

              // ----------------------------------------------
              // PROFILE EXISTS
              // ----------------------------------------------

              debugPrint('GOOGLE USER REGISTERED - CONTINUING');

              isWaitingForGoogleLogin = false;
              isWaitingForAccountConfirmation = false;
              isNormalLoginAttempting = false;

              navigatorKey.currentState?.pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const MainScreen()),
                (route) => false,
              );
            } on PostgrestException catch (error) {
              debugPrint('GOOGLE PROFILE CHECK ERROR: ${error.message}');

              isWaitingForGoogleLogin = false;

              await Supabase.instance.client.auth.signOut();

              navigatorKey.currentState?.pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );

              ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
                SnackBar(
                  content: Text(
                    'Could not verify your FitNovaX account: ${error.message}',
                  ),
                ),
              );
            }

            return;
          }

          // ==================================================
          // NORMAL EMAIL / PASSWORD LOGIN
          // ==================================================

          if (isNormalLoginAttempting) {
            isNormalLoginAttempting = false;
            isWaitingForAccountConfirmation = false;
            isWaitingForGoogleLogin = false;

            navigatorKey.currentState?.pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const MainScreen()),
              (route) => false,
            );

            return;
          }
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
