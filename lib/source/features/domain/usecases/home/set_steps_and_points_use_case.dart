import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:steps_tracker/source/core/error/failures/app_failure.dart';
import 'package:steps_tracker/source/core/usecase/use_case.dart';
import 'package:steps_tracker/source/features/domain/repositories/bottom_navbar_repository.dart';

@injectable
class SetStepsAndPointsUseCase extends UseCase<bool, int> {
  final BottomNavbarRepository _bottomNavbarRepository;

  SetStepsAndPointsUseCase(
    this._bottomNavbarRepository,
  );

  @override
  Future<Either<Failure, bool>> call(int params) async {
    return await _bottomNavbarRepository.setStepsAndPoints(params);
  }
}
