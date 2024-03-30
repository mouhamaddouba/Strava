import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:steps_tracker/source/features/data/models/user_model.dart';

part 'leaderboard_state.freezed.dart';

@freezed
abstract class LeaderboardState with _$LeaderboardState {
  const factory LeaderboardState.initial() = Initial;

  const factory LeaderboardState.loading() = Loading;

  const factory LeaderboardState.loaded({
    required List<UserModel> users,
  }) = Loaded;

  const factory LeaderboardState.error({
    required String message,
  }) = Error;
}
