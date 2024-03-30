import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_tracker/source/core/di/injection_container.dart';
import 'package:steps_tracker/source/features/design/cubits/board/leaderboard_cubit.dart';
import 'package:steps_tracker/source/features/design/cubits/board/leaderboard_state.dart';

import 'package:steps_tracker/source/features/design/screens/board/views/board_body_view.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LeaderboardCubit>(
      create: (context) {
        final cubit = getIt<LeaderboardCubit>();
        cubit.getUsers();
        return cubit;
      },
      child: Builder(
        builder: (context) {
          return SafeArea(
            child: BlocBuilder<LeaderboardCubit, LeaderboardState>(
              bloc: BlocProvider.of<LeaderboardCubit>(context),
              builder: (context, state) {
                return state.maybeWhen(
                  loading: () => const BoardBodyView(
                    isLoading: true,
                  ),
                  loaded: (users) => BoardBodyView(
                    users: users,
                  ),
                  orElse: () => const BoardBodyView(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
