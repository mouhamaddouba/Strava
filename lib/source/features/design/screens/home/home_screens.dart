import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_tracker/source/core/di/injection_container.dart';
import 'package:steps_tracker/source/features/design/cubits/home/home_cubit.dart';
import 'package:steps_tracker/source/features/design/screens/home/views/points_and_steps_view.dart';
import 'package:steps_tracker/source/features/design/screens/home/views/ready_card_view.dart';
import 'package:steps_tracker/source/features/design/screens/home/views/get_radial_gauge_view.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) {
        final cubit = getIt<HomeCubit>();
        cubit.getUserData();
        return cubit;
      },
      child: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Space
              SizedBox(
                height: 30.0,
              ),

              // Health point & Total steps
              PointsAndStepsView(),

              // Space
              SizedBox(
                height: 40.0,
              ),

              // Pedometer
              GetRadialGaugeView(),

              // Space
              SizedBox(
                height: 20.0,
              ),

              // Card Ready
              ReadyCardView(),
            ],
          ),
        ),
      ),
    );
  }
}
