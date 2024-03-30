import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:injectable/injectable.dart';
import 'package:steps_tracker/source/common/translations/l10n.dart';
import 'package:steps_tracker/source/core/usecase/use_case.dart';
import 'package:steps_tracker/source/features/data/models/exchange_history_model.dart';
import 'package:steps_tracker/source/features/design/cubits/exchanges/exchanges_history_state.dart';
import 'package:steps_tracker/source/features/domain/usecases/exchange/get_exchange_history_use_case.dart';

@injectable
class ExchangesHistoryCubit extends Cubit<ExchangesHistoryState> {
  final GetExchangeHistoryUseCase _getExchangesHistoryUseCase;
  late Stream<List<ExchangeHistoryModel>> _exchangesStream;

  ExchangesHistoryCubit(
    this._getExchangesHistoryUseCase,
  ) : super(const ExchangesHistoryState.initial());

  Future<void> getExchangesHistory() async {
    emit(const ExchangesHistoryState.loading());
    final result = await _getExchangesHistoryUseCase(NoParams());
    result.fold(
        (_) => emit(
            ExchangesHistoryState.error(message: S.current.somethingWentWrong)),
        (exchangesStream) {
      _exchangesStream = exchangesStream;
      _exchangesStream.listen(onExchangesReceived).onError(onExchangesError);
    });
  }

  void onExchangesReceived(List<ExchangeHistoryModel> exchanges) {
    debugPrint('Exchanges Length: ${exchanges.length}');
    emit(ExchangesHistoryState.loaded(exchanges: exchanges));
  }

  void onExchangesError(error) {
    debugPrint('onExchangesError: $error');
    emit(
      ExchangesHistoryState.error(message: S.current.somethingWentWrong),
    );
  }
}
