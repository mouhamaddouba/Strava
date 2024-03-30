import 'package:steps_tracker/source/features/data/models/user_model.dart';
import 'package:steps_tracker/source/features/domain/entities/leaderboard_item_entity.dart';

// convert model to entity mapper
extension UserModelToMapper on List<UserModel> {
  List<LeaderboardItemEntity> toEntity() {
    return map(
      (e) => LeaderboardItemEntity(
        uid: e.uid,
        name: e.name,
        stepsNumber: e.totalSteps,
        order: 0,
        healthPoints: e.healthPoints,
      ),
    ).toList();
  }
}
