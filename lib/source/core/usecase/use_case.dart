import 'package:dartz/dartz.dart';
import 'package:steps_tracker/source/core/error/failures/app_failure.dart';

abstract class UseCase<T, P> {
  Future<Either<Failure, T>> call(P params);
}

abstract class UseCaseWithoutParams<Type, Params> {
  Type call(Params params);
}

class NoParams {}
