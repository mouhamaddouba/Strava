import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_tracker/source/features/design/cubits/auth_status/auth_status_cubit.dart';
import 'package:steps_tracker/source/features/design/cubits/auth_status/auth_status_state.dart';
import 'package:steps_tracker/source/features/design/screens/auth/auth_screen.dart';
import 'package:steps_tracker/source/features/design/screens/dashboard/dashboard_screen.dart';

class StepTrackerView extends StatelessWidget {
  const StepTrackerView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthStatusCubit, AuthStatusState>(
      bloc: BlocProvider.of<AuthStatusCubit>(context),
      listener: (context, state) {
        if (state is Authenticated) {
          DashboardScreen();
        } else {
          const AuthScreen();
        }
      },
      buildWhen: (previousState, currentState) {
        return previousState != currentState;
      },
      builder: (context, state) {
        return state.maybeWhen(
          authenticated: () => DashboardScreen(),
          unAuthenticated: () => const AuthScreen(),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
