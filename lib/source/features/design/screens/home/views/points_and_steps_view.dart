import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_tracker/source/common/translations/l10n.dart';
import 'package:steps_tracker/source/common/values/constants/app_color.dart';
import 'package:steps_tracker/source/features/design/cubits/home/home_cubit.dart';
import 'package:steps_tracker/source/features/design/cubits/home/home_state.dart';
import 'package:steps_tracker/source/features/design/screens/home/widgets/points_card_widget.dart';

class PointsAndStepsView extends StatelessWidget {
  const PointsAndStepsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: BlocProvider.of<HomeCubit>(context),
      builder: (context, state) {
        return state.maybeWhen(
          stepsAndPointsLoading: () {
            return _buildHealthRow(
              context,
              isLoading: true,
            );
          },
          stepsAndPointsLoaded: (steps, healthPoints) {
            return _buildHealthRow(
              context,
              steps: steps,
              healthPoints: healthPoints,
            );
          },
          orElse: () => _buildHealthRow(context),
        );
      },
    );
  }

  Widget _buildHealthRow(
    BuildContext context, {
    bool isLoading = false,
    int steps = 0,
    int? healthPoints,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Health point
        Expanded(
          child: PointsCardWidgets(
            mainTitle: S.of(context).healthPoints,
            number: isLoading ? '-' : healthPoints.toString(),
            iconData: Icons.shopping_bag,
            color: Theme.of(context).primaryColor,
            unit: '',
          ),
        ),

        // Space
        const SizedBox(
          width: 16.0,
        ),

        // Total Steps
        Expanded(
          child: PointsCardWidgets(
            mainTitle: S.of(context).totalSteps,
            number: isLoading ? '-' : steps.toString(),
            iconData: Icons.bubble_chart_rounded,
            color: AppColors.kTotalStepsColor,
          ),
        ),
      ],
    );
  }
}
