import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/utils/logger_util.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/error/exceptions.dart';

abstract interface class AuthRemoteDataSources {
  Future<String> signUpWithEmailOrPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<String> loginWithEmailOrPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourcesImpl implements AuthRemoteDataSources {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourcesImpl(this.supabaseClient);

  @override
  Future<String> loginWithEmailOrPassword(
      {required String email, required String password}) {
    // TODO: implement loginWithEmailOrPassword
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailOrPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
  final response=await    supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {"name": name},
      );
  if(response.user==null){
    throw const ServerExceptions('User is null');
  }
   return response.user!.id;
    } catch (e) {
      logger.f("Server Exception ${e.toString()}");
      throw ServerExceptions(e.toString());
    }
  }
}
