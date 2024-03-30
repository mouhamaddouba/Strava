import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:steps_tracker/source/common/translations/l10n.dart';
import 'package:steps_tracker/source/common/values/constants/app_assets.dart';
import 'package:steps_tracker/source/core/di/injection_container.dart';
import 'package:steps_tracker/source/core/utils/app_alert_utils.dart';
import 'package:steps_tracker/source/features/data/models/reward_model.dart';
import 'package:steps_tracker/source/features/design/cubits/rewards/rewards_cubit.dart';
import 'package:steps_tracker/source/features/design/cubits/rewards/rewards_state.dart';

class RewardsItemWidget extends StatefulWidget {
  final RewardModel reward;

  const RewardsItemWidget({
    super.key,
    required this.reward,
  });

  @override
  State<RewardsItemWidget> createState() => _RewardsItemWidgetState();
}

class _RewardsItemWidgetState extends State<RewardsItemWidget> {
  late RewardsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<RewardsCubit>();
    _cubit.getUserPoints();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Image Coup coffee
                Image.asset(
                  widget.reward.imageUrl ?? AppAssets.coffee,
                  fit: BoxFit.cover,
                  height: 100,
                ),

                // Space
                const SizedBox(
                  width: 12.0,
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Banana
                      Text(
                        widget.reward.name ?? 'Banana',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),

                      // Space
                      const SizedBox(
                        height: 4.0,
                      ),

                      // Points
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: widget.reward.description,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            TextSpan(
                              text: ' ${widget.reward.points} Points!',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),

                      // Space
                      const SizedBox(
                        height: 6.0,
                      ),

                      // Button Earn
                      BlocBuilder<RewardsCubit, RewardsState>(
                        bloc: _cubit,
                        buildWhen: (prev, current) =>
                            current is UserDataLoading ||
                            current is UserDataLoaded,
                        builder: (context, state) {
                          return state.maybeWhen(
                            userDataLoading: () => _buildEarnButton(
                              context,
                              isLoading: true,
                            ),
                            userDataLoaded: (points) => _buildEarnButton(
                              context,
                              points: points,
                            ),
                            orElse: () => _buildEarnButton(context),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEarnButton(
    BuildContext context, {
    bool isLoading = false,
    int points = 0,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: !isLoading
            ? () {
                if ((widget.reward.points ?? 0) <= points) {
                  AppAlertUtils().showAlertDialog(
                    context,
                    title: S.current.qrCode,
                    contentWidget: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          // Image Qr
                          Lottie.asset(
                            AppAssets.qrCode,
                            width: 200,
                            repeat: true,
                          ),

                          // Space
                          const SizedBox(
                            height: 16.0,
                          ),

                          // Scan Qr
                          Text(
                            S.current.scanQrCode,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                    ),
                    defaultActionText: S.current.dummyDone,
                    cubit: _cubit,
                    defaultAction: () async {
                      await _cubit.earnAReward(widget.reward);
                    },
                  );
                } else {
                  AppAlertUtils().showAlertDialog(
                    context,
                    title: S.current.notice,
                    content: S.current.pointsLessThanItem,
                    defaultActionText: S.current.done,
                  );
                }
              }
            : null,

        // Style button
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),

        // Text button
        child: !isLoading
            ? Text(
                S.current.earn,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
