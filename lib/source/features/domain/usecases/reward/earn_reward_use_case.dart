import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:steps_tracker/source/core/error/failures/app_failure.dart';
import 'package:steps_tracker/source/core/usecase/use_case.dart';
import 'package:steps_tracker/source/features/data/models/reward_model.dart';
import 'package:steps_tracker/source/features/domain/repositories/bottom_navbar_repository.dart';

@injectable
class EarnRewardUseCase extends UseCase<bool, RewardModel> {
  final BottomNavbarRepository _bottomNavbarRepository;

  EarnRewardUseCase(
    this._bottomNavbarRepository,
  );

  @override
  Future<Either<Failure, bool>> call(RewardModel params) async {
    return await _bottomNavbarRepository.earnAReward(params);
  }
}
