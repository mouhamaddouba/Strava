import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:steps_tracker/source/common/storage/database.dart';
import 'package:steps_tracker/source/common/values/enums/enums.dart';
import 'package:steps_tracker/source/core/error/exceptions/app_exception.dart';
import 'package:steps_tracker/source/core/error/failures/app_failure.dart';
import 'package:steps_tracker/source/features/data/data_source/local_data_sources/auth_local_data_source.dart';
import 'package:steps_tracker/source/features/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:steps_tracker/source/features/domain/entities/user_entity.dart';
import 'package:steps_tracker/source/features/domain/mapper/user_entity_to_model_mapper.dart';
import 'package:steps_tracker/source/features/domain/repositories/auth_repository.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;
  final Database _database;

  AuthRepositoryImpl(
    this._authRemoteDataSource,
    this._authLocalDataSource,
    this._database,
  );

  @override
  Future<Either<Failure, bool>> signInAnonymously(String name) async {
    try {
      final user = await _authRemoteDataSource.signInAnonymously();
      final newUser = UserEntity(
        name: name,
        uid: user?.uid,
      );
      await _authLocalDataSource.persistAuth(
        newUser.toModel(),
      );
      await _database.setUserData(
        newUser.toModel(),
      );
      return const Right(true);
    } on AppException catch (e) {
      return Left(
        firebaseExceptionsDecoder(e),
      );
    }
  }

  @override
  Future<AuthStatus> hasAnAccount() async {
    final currentUser = await _authLocalDataSource.currentUser();
    if (currentUser != null) {
      return AuthStatus.authenticated;
    }
    return AuthStatus.unAuthenticated;
  }
}
