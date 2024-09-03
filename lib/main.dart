import 'package:blog_app/core/secrects/app_secrets.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/feature/data/data_sources/auth_remote_data_source.dart';
import 'package:blog_app/feature/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/feature/domain/usecase/user_sign_us.dart';
import 'package:blog_app/feature/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/navigation/global_key.dart';
import 'feature/presentation/screen/login_screen.dart';
import 'feature/presentation/screen/sign_up_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => AuthBloc(
          userSignUp: UserSignUp(
            AuthRepositoryImpl(
              AuthRemoteDataSourcesImpl(supabase.client),
            ),
          ),
        ),
      )
    ],
    child: const MyApp(),
  ));
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
