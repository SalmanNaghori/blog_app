import 'package:blog_app/core/common/cubits/app_user/app_user_cubit_cubit.dart';
import 'package:blog_app/core/common/widget/loader.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/core/utils/logger_util.dart';
import 'package:blog_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/feature/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/feature/blog/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'core/navigation/global_key.dart';
import 'feature/auth/presentation/screen/login_screen.dart';
import 'init_dependencies.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: "./.env");
  } catch (e) {
    logger.e("Could not load .env file: $e");
  }

  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<BlogBloc>(),
      )
    ],
    child: const MyApp(),
  ));
  Loader.instance.init();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: GlobalVariable.navigatorKey,
        theme: AppTheme.darkThemeMood,
        builder: EasyLoading.init(
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
        ),
        home: BlocSelector<AppUserCubit, AppUserCubitState, bool>(
          selector: (state) {
            return state is AppUserLoggedIn;
          },
          builder: (context, isLoggedIn) {
            if (isLoggedIn) {
              EasyLoading.dismiss();
              return const BlogPage();
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
