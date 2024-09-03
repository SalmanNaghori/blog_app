import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/feature/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<String, UserSignupParameter> {
  final AuthRepository authRepository;

  UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, String>> call(UserSignupParameter params) async {
   return await authRepository.signUpWithEmailOrPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignupParameter {
  final String name;
  final String password;
  final String email;

  UserSignupParameter({
    required this.name,
    required this.password,
    required this.email,
  });
}
