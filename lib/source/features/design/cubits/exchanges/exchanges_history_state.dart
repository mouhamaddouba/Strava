import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:steps_tracker/source/features/data/models/exchange_history_model.dart';

part 'exchanges_history_state.freezed.dart';

@freezed
abstract class ExchangesHistoryState with _$ExchangesHistoryState {
  const factory ExchangesHistoryState.initial() = Initial;

  const factory ExchangesHistoryState.loading() = Loading;

  const factory ExchangesHistoryState.loaded({
    required List<ExchangeHistoryModel> exchanges,
  }) = Loaded;

  const factory ExchangesHistoryState.error({
    required String message,
  }) = Error;
}
