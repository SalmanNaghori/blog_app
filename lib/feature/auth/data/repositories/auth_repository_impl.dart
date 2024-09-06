import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/utils/logger_util.dart';
import 'package:blog_app/feature/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:blog_app/feature/auth/domain/entities/user.dart';
import 'package:blog_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSources remoteDataSources;

  AuthRepositoryImpl(this.remoteDataSources);

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final user = await remoteDataSources.getCurrentUserData();
      if (user == null) {
        logger.e("Exception:-User not logged in!");
        return left(Failure("User not logged in!"));
      }
      return right(user);
    } on ServerExceptions catch (e) {
      logger.e("Exception:-${e.message}");
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithEmailOrPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
        () async => await remoteDataSources.loginWithEmailOrPassword(
              email: email,
              password: password,
            ));
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailOrPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
        () async => await remoteDataSources.signUpWithEmailOrPassword(
              name: name,
              email: email,
              password: password,
            ));
  }
}

Future<Either<Failure, User>> _getUser(
  Future<User> Function() fn,
) async {
  try {
    final user = await fn();
    logger.d("Success:-${right(user.toString())}");
    return right(user);
  } on sb.AuthException catch (e) {
    logger.e("AuthException:-${e.toString()}");
    return left(Failure(e.message));
  } on ServerExceptions catch (e) {
    logger.e("Exception:-${e.message}");
    return left(Failure(e.message));
  }
}
