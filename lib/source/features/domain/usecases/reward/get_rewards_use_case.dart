import 'package:injectable/injectable.dart';
import 'package:steps_tracker/source/core/usecase/use_case.dart';
import 'package:steps_tracker/source/features/data/models/reward_model.dart';
import 'package:steps_tracker/source/features/domain/repositories/bottom_navbar_repository.dart';

@injectable
class GetRewardsUseCase
    extends UseCaseWithoutParams<Stream<List<RewardModel>>, NoParams> {
  final BottomNavbarRepository _bottomNavbarRepository;

  GetRewardsUseCase(
    this._bottomNavbarRepository,
  );

  @override
  Stream<List<RewardModel>> call(NoParams params) {
    return _bottomNavbarRepository.rewardsStream();
  }
}
