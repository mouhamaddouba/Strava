import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steps_tracker/source/common/translations/l10n.dart';
import 'package:steps_tracker/source/common/values/constants/app_assets.dart';
import 'package:steps_tracker/source/core/di/injection_container.dart';
import 'package:steps_tracker/source/features/design/cubits/rewards/rewards_cubit.dart';
import 'package:steps_tracker/source/features/design/cubits/rewards/rewards_state.dart';
import 'package:steps_tracker/source/features/design/screens/rewards/views/rewards_list_view.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RewardsCubit>(
      create: (_) {
        final cubit = getIt<RewardsCubit>();
        cubit.getRewards();
        return cubit;
      },
      child: Builder(builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 8.0,
            ),
            child: Column(
              children: [
                // Image
                SvgPicture.asset(
                  AppAssets.kRewards,
                  height: 250,
                  fit: BoxFit.contain,
                ),

                // Space
                const SizedBox(
                  height: 16.0,
                ),

                // Available Rewards
                Text(
                  S.of(context).availableRewards,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),

                // Space
                const SizedBox(
                  height: 12.0,
                ),

                // Bloc Rewards List
                BlocBuilder<RewardsCubit, RewardsState>(
                  bloc: BlocProvider.of<RewardsCubit>(context),
                  builder: (_, state) {
                    return state.maybeWhen(
                      loaded: (rewards) => RewardsListView(rewards: rewards),
                      loading: () => const RewardsListView(isLoading: true),
                      orElse: () => const RewardsListView(),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
