import 'dart:async';

import 'package:blog_app/core/common/cubits/app_user/app_user_cubit_cubit.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/feature/auth/domain/usecase/current_user.dart';
import 'package:blog_app/feature/auth/domain/usecase/user_login.dart';
import 'package:blog_app/feature/auth/domain/usecase/user_sign_us.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubitCubit;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubitCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }

  FutureOr<void> _isUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());
    res.fold(
        (l) => emit(AuthFailure(l.message)), (r) => _emitAuthSuccess(r, emit));
  }

  //Todo: signUp method bloc
  Future<void> _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final res = await _userSignUp(UserSignUpParameter(
      name: event.name,
      password: event.password,
      email: event.email,
    ));
    res.fold((failure) {
      emit(AuthFailure(failure.message)); // Emit failure state with message
    }, (user) => _emitAuthSuccess(user, emit));
  }

  //Todo: Login method bloc
  Future<void> _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    final res = await _userLogin(
      UserLoginParams(password: event.password, email: event.email),
    );
    res.fold((failure) {
      emit(AuthFailure(failure.message)); // Emit failure state with message
    }, (user) => _emitAuthSuccess(user, emit));
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubitCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
