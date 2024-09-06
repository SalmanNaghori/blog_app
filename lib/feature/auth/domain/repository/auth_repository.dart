import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/feature/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailOrPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> loginWithEmailOrPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> currentUser();
}
