import 'package:blog_app/core/secrects/app_secrets.dart';
import 'package:blog_app/feature/domain/repository/auth_repository.dart';
import 'package:blog_app/feature/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'feature/data/data_sources/auth_remote_data_source.dart';
import 'feature/data/repositories/auth_repository_impl.dart';
import 'feature/domain/usecase/user_sign_us.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _authInit();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _authInit() {
  serviceLocator.registerFactory<AuthRemoteDataSources>(
    () => AuthRemoteDataSourcesImpl(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserSignUp(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
     () => AuthBloc(
      userSignUp: serviceLocator(),
    ),
  );
}
