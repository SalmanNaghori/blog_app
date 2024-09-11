import 'package:blog_app/core/common/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_user_cubit_state.dart';

class AppUserCubit extends Cubit<AppUserCubitState> {
  AppUserCubit() : super(AppUserCubitInitial());

  void updateUser(User? user) {
    if (user == null) {
      emit(AppUserCubitInitial());
    } else {
      emit(AppUserLoggedIn(user));
    }
  }
}
