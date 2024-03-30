import 'package:flutter/material.dart';
import 'package:steps_tracker/source/common/translations/l10n.dart';
import 'package:steps_tracker/source/features/data/models/reward_model.dart';
import 'package:steps_tracker/source/features/design/screens/rewards/widgets/rewards_item_widget.dart';

class RewardsListView extends StatelessWidget {
  final bool isLoading;
  final List<RewardModel>? rewards;

  const RewardsListView({
    super.key,
    this.isLoading = false,
    this.rewards,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    debugPrint('Rewards from the fun: ${rewards?.length}');
    return rewards != null && rewards!.isNotEmpty
        ? Column(
            children: rewards!
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                    ),
                    child: RewardsItemWidget(reward: e),
                  ),
                )
                .toList(),
          )
        : Center(
            child: Text(
              S.current.emptyState,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).primaryColorDark,
                  ),
            ),
          );
  }
}
