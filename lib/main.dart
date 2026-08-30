import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Screens/splash_screen.dart';
import '../Screens/reset_password_screen.dart';
import '../Screens/login_callback_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

bool isWaitingForAccountConfirmation = false;

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
  @override
  void initState() {
    super.initState();

    Supabase.instance.client.auth.onAuthStateChange.listen(
      (data) {
        debugPrint('AUTH EVENT: ${data.event}');

        // PASSWORD RECOVERY
        if (data.event == AuthChangeEvent.passwordRecovery) {
          navigatorKey.currentState?.pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const ResetPasswordScreen()),
            (route) => false,
          );

          return;
        }

        // ACCOUNT CONFIRMATION
        if (data.event == AuthChangeEvent.signedIn &&
            isWaitingForAccountConfirmation) {
          isWaitingForAccountConfirmation = false;

          navigatorKey.currentState?.pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const LoginCallbackScreen()),
            (route) => false,
          );
        }
      },
      onError: (error, stackTrace) {
        debugPrint('AUTH ERROR: $error');
      },
    );
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
