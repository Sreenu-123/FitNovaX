import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Screens/splash_screen.dart';
import '../Screens/reset_password_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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

    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      debugPrint('AUTH EVENT: ${data.event}');

      if (data.event == AuthChangeEvent.passwordRecovery) {
        navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const ResetPasswordScreen()),
          (route) => false,
        );
      }
    });
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
