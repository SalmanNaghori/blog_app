import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/utils/logger_util.dart';
import 'package:blog_app/feature/data/data_sources/auth_remote_data_source.dart';
import 'package:blog_app/feature/domain/entities/user.dart';
import 'package:blog_app/feature/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSources remoteDataSources;

  AuthRepositoryImpl(this.remoteDataSources);

  @override
  Future<Either<Failure, User>> loginWithEmailOrPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement loginWithEmailOrPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailOrPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSources.signUpWithEmailOrPassword(
        name: name,
        email: email,
        password: password,
      );

      logger.d("Success:-${right(user.toString())}");

      return right(user);
    } on ServerExceptions catch (e) {
      logger.e("Exception:-${e.toString()}");

      return left(Failure(e.message));
    }
  }
}
