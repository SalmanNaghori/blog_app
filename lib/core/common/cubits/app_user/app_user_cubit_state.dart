part of 'app_user_cubit_cubit.dart';

@immutable
sealed class AppUserCubitState {}

final class AppUserCubitInitial extends AppUserCubitState {}

final class AppUserLoggedIn extends AppUserCubitState {
  final User user;
  AppUserLoggedIn(this.user);
}
