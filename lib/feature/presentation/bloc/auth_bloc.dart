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
      final res = await _userSignUp(UserSignupParameter(
        name: event.name,
        password: event.password,
        email: event.email,
      ));
      res.fold((l)=>emit(AuthFailure(l.message)), (user)=>emit(AuthSuccess(user)));
    });
  }
}
