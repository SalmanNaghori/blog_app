import 'dart:convert';

import 'package:blog_app/core/utils/logger_util.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/error/exceptions.dart';
import '../model/user_model.dart';

abstract interface class AuthRemoteDataSources {
  Session? get currentUserSession;

  Future<UserModel> signUpWithEmailOrPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailOrPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourcesImpl implements AuthRemoteDataSources {
  final SupabaseClient supabaseClient;

  @override
  // TODO: implement currentUserSession
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  AuthRemoteDataSourcesImpl(this.supabaseClient);

  @override
  Future<UserModel> loginWithEmailOrPassword(
      {required String email, required String password}) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      logger.f("Response===${json.encode(response.user?.userMetadata)}");

      if (response.user == null) {
        throw const ServerExceptions('User is null');
      }
      return UserModel.from(response.user?.userMetadata ?? {})
          .copyWith(email: currentUserSession!.user.email);
    } catch (e) {
      logger.e("Server Exception loginWithEmailOrPassword ${e}");

      throw e;
    }
  }

  @override
  Future<UserModel> signUpWithEmailOrPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {"name": name},
      );
      logger.f("Response===${json.encode(response.user?.userMetadata)}");

      if (response.user == null) {
        throw const ServerExceptions('User is null');
      }
      return UserModel.from(response.user?.userMetadata ?? {});
    } catch (e) {
      logger.e("Server Exception signUpWithEmailOrPassword ${e}");

      throw e;
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', currentUserSession!.user.id);

        if (userData.isNotEmpty) {
          logger.f("Response===${userData.first}");
          return UserModel.from(userData.first)
              .copyWith(email: currentUserSession!.user.email);
        } else {
          logger.w("No user data found for the current session");
          return null; // Return null if no data found
        }
      }
      return null;
    } catch (e) {
      logger.e("Server Exception getCurrentUserData: $e");
      throw e;
    }
  }
}
