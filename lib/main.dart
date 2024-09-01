import 'package:blog_app/core/secrects/app_secrets.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/navigation/global_key.dart';
import 'feature/presentation/screen/login_screen.dart';
import 'feature/presentation/screen/sign_up_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase= await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  runApp(const MyApp());


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: GlobalVariable.navigatorKey,
      theme: AppTheme.darkThemeMood,
      home: const LoginScreen(),
    );
  }
}
