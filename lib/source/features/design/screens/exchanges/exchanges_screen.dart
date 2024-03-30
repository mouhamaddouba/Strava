import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_tracker/source/core/di/injection_container.dart';
import 'package:steps_tracker/source/features/design/cubits/exchanges/exchanges_history_cubit.dart';
import 'package:steps_tracker/source/features/design/cubits/exchanges/exchanges_history_state.dart';
import 'package:steps_tracker/source/features/design/screens/exchanges/views/exchanges_body_view.dart';

class ExchangesScreen extends StatelessWidget {
  const ExchangesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExchangesHistoryCubit>(
      create: (context) {
        final cubit = getIt<ExchangesHistoryCubit>();
        cubit.getExchangesHistory();
        return cubit;
      },
      child: Builder(
        builder: (context) {
          return BlocBuilder<ExchangesHistoryCubit, ExchangesHistoryState>(
            bloc: BlocProvider.of<ExchangesHistoryCubit>(context),
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => const ExchangeBodyView(isLoading: false),
                loaded: (exchanges) => ExchangeBodyView(
                  exchanges: exchanges,
                ),
                orElse: () => const ExchangeBodyView(),
              );
            },
          );
        },
      ),
    );
  }
}
