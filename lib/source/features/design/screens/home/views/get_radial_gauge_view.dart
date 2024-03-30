import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_tracker/source/common/translations/l10n.dart';
import 'package:steps_tracker/source/core/di/injection_container.dart';
import 'package:steps_tracker/source/features/design/cubits/home/home_cubit.dart';
import 'package:steps_tracker/source/features/design/cubits/home/home_state.dart';
import 'package:steps_tracker/source/features/design/screens/home/views/radial_guage_view.dart';

class GetRadialGaugeView extends StatefulWidget {
  const GetRadialGaugeView({super.key});

  @override
  State<GetRadialGaugeView> createState() => _GetRadialGaugeViewState();
}

class _GetRadialGaugeViewState extends State<GetRadialGaugeView> {
  late HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();
    _homeCubit = getIt<HomeCubit>();
    _homeCubit.initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      bloc: _homeCubit,
      listener: (context, state) {
        state.maybeWhen(
          feedbackGain: (steps) {
            final snackBar = SnackBar(
              content: Text(S.of(context).gainMorePoints),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (steps) => RadialGuageView(steps: steps),
          feedbackGain: (steps) => RadialGuageView(steps: steps),
          orElse: () => const RadialGuageView(),
        );
      },
    );
  }
}
