import 'package:blog_app/feature/auth/domain/entities/user.dart';
import 'package:blog_app/feature/auth/domain/usecase/user_login.dart';
import 'package:blog_app/feature/auth/domain/usecase/user_sign_us.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
  }

  //Todo: signUp method bloc
  Future<void> _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
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
  }

  //Todo: Login method bloc
  Future<void> _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userLogin(
      UserLoginParams(password: event.password, email: event.email),
    );
    res.fold((failure) {
      emit(AuthFailure(failure.message)); // Emit failure state with message
    }, (user) {
      emit(AuthSuccess(user));
    });
  }
}
