import 'package:dartz/dartz.dart';
import 'package:steps_tracker/source/common/values/enums/enums.dart';
import 'package:steps_tracker/source/core/error/failures/app_failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> signInAnonymously(String name);

  Future<AuthStatus> hasAnAccount();
}
