import 'package:firebase_auth/firebase_auth.dart';

import 'package:injectable/injectable.dart';
import 'package:steps_tracker/source/features/data/data_source/data_sources_body.dart';
import 'package:steps_tracker/source/core/services/auth_services.dart';

abstract class AuthRemoteDataSource {
  Future<User?> signInAnonymously();
}

@Singleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final AuthServices authBase;

  AuthRemoteDataSourceImpl({
    required this.authBase,
  });

  @override
  Future<User?> signInAnonymously() async {
    return returnOrThrow(
      () => authBase.signInAnonymously(),
    );
  }
}
