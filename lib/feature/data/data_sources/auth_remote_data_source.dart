import 'dart:convert';

import 'package:blog_app/core/utils/logger_util.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/error/exceptions.dart';
import '../model/user_model.dart';

abstract interface class AuthRemoteDataSources {
  Future<UserModel> signUpWithEmailOrPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailOrPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourcesImpl implements AuthRemoteDataSources {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourcesImpl(this.supabaseClient);

  @override
  Future<UserModel> loginWithEmailOrPassword(
      {required String email, required String password}) {
    // TODO: implement loginWithEmailOrPassword
    throw UnimplementedError();
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
      logger.f(json.encode(response.user?.userMetadata));

      if (response.user == null) {
        throw const ServerExceptions('User is null');
      }
      return UserModel.from(response.user?.userMetadata ?? {});
    } catch (e) {
      logger.e("Server Exception ${e.toString()}");

      throw ServerExceptions(e.toString());
    }
  }
}
