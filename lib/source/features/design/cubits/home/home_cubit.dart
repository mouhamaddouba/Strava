import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pedometer/pedometer.dart';
import 'package:steps_tracker/source/common/storage/database.dart';
import 'package:steps_tracker/source/common/translations/l10n.dart';
import 'package:steps_tracker/source/common/values/enums/enums.dart';
import 'package:steps_tracker/source/core/usecase/use_case.dart';
import 'package:steps_tracker/source/features/data/models/exchange_history_model.dart';
import 'package:steps_tracker/source/features/design/cubits/home/home_state.dart';
import 'package:steps_tracker/source/features/domain/usecases/board/get_user_data_use_case.dart';
import 'package:steps_tracker/source/features/domain/usecases/exchange/set_exchange_history_use_case.dart';
import 'package:steps_tracker/source/features/domain/usecases/home/set_steps_and_points_use_case.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final SetExchangeHistoryUseCase _setExchangeHistoryUseCase;
  final SetStepsAndPointsUseCase _setStepsAndPointsUseCase;
  final GetUserDataUseCase _getUserDataUseCase;
  late Stream<StepCount> _stepCountStream;
  String _steps = '?';

  HomeCubit(
    this._setExchangeHistoryUseCase,
    this._setStepsAndPointsUseCase,
    this._getUserDataUseCase,
  ) : super(
          const HomeState.initial(),
        );

  Future<void> getUserData() async {
    emit(const HomeState.stepsAndPointsLoading());
    final result = await _getUserDataUseCase(NoParams());
    result.fold(
      (failure) => emit(
        HomeState.stepsError(message: S.current.somethingWentWrong),
      ),
      (userData) => userData.listen(
        (event) {
          debugPrint("User Steps here: ${event.totalSteps}");
          emit(
            HomeState.stepsAndPointsLoaded(
              steps: event.totalSteps,
              healthPoints: event.healthPoints,
            ),
          );
        },
      ),
    );
  }

  void initPlatformState() {
    emit(const HomeState.loading());
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
  }

  void onStepCount(StepCount event) async {
    debugPrint(event.toString());
    var oldSteps = int.tryParse(_steps) ?? 0;
    _steps = event.steps.toString();
    debugPrint("Steps in Cubit: $_steps");
    emit(HomeState.loaded(steps: _steps));
    await _setStepsAndPointsUseCase(event.steps);
    await onFeedbackState(oldSteps, event.steps);
  }

  Future<void> onFeedbackState(int oldSteps, int newSteps) async {
    if ((oldSteps % 100) > (newSteps % 100)) {
      emit(HomeState.feedbackGain(steps: _steps));
      await _setExchangeHistoryUseCase(
        ExchangeHistoryModel(
          id: documentIdFromLocalGenerator(),
          title: ExchangeHistoryTitle.exchange.title,
          date: DateTime.now().toIso8601String(),
          points: 5,
        ),
      );
    }
  }

  void onStepCountError(error) {
    debugPrint('onStepCountError: $error');
    _steps = '?';
    emit(HomeState.error(message: _steps));
  }
}
