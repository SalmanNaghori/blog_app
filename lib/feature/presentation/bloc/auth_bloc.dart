import 'package:blog_app/feature/domain/entities/user.dart';
import 'package:blog_app/feature/domain/usecase/user_sign_us.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  AuthBloc({
    required UserSignUp userSignUp,
  })  : _userSignUp = userSignUp,
        super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading());
      final res = await _userSignUp(UserSignUpParameter(
        name: event.name,
        password: event.password,
        email: event.email,
      ));
      res.fold((failure) {
        emit(AuthFailure(failure.message)); // Emit failure state with message
      }, (user) {
        emit(AuthSuccess(user));
      });
    });
  }
}
