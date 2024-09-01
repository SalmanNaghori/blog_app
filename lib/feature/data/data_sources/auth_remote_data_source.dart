import 'package:supabase_flutter/supabase_flutter.dart';

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

class AuthRemoteDataSourcesImpl implements AuthRemoteDataSources{
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourcesImpl(this.supabaseClient);

  @override
  Future<String> loginWithEmailOrPassword({required String email, required String password}) {
    // TODO: implement loginWithEmailOrPassword
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailOrPassword({required String name, required String email, required String password}) {
    // TODO: implement signUpWithEmailOrPassword
    throw UnimplementedError();
  }
  
}