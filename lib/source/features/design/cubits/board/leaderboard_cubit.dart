import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:injectable/injectable.dart';
import 'package:steps_tracker/source/common/translations/l10n.dart';
import 'package:steps_tracker/source/core/usecase/use_case.dart';
import 'package:steps_tracker/source/features/design/cubits/board/leaderboard_state.dart';
import 'package:steps_tracker/source/features/domain/entities/leaderboard_item_entity.dart';
import 'package:steps_tracker/source/features/domain/usecases/board/get_users_use_case.dart';

@injectable
class LeaderboardCubit extends Cubit<LeaderboardState> {
  final GetUsersUseCase _getUsersUseCase;
  late Stream<List<LeaderboardItemEntity>> usersStream;

  LeaderboardCubit(
    this._getUsersUseCase,
  ) : super(const LeaderboardState.initial());

  Future<void> getUsers() async {
    emit(const LeaderboardState.loading());
    final result = await _getUsersUseCase(NoParams());
    result.fold(
      (failure) => emit(
        LeaderboardState.error(
          message: S.current.somethingWentWrong,
        ),
      ),
      (stream) => stream.listen((users) {
        users.sort((a, b) => b.totalSteps.compareTo(a.totalSteps));
        emit(LeaderboardState.loaded(users: users));
      }).onError(
        (error) => emit(
          LeaderboardState.error(
            message: S.current.somethingWentWrong,
          ),
        ),
      ),
    );
  }
}
