import '../Screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://ttdobhmgppobzbefnwtl.supabase.co',
    publishableKey: 'sb_publishable_zmOjAJDZyVDVEjDFVlSmuA_JsLQfagq',
  );
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen()));
}
