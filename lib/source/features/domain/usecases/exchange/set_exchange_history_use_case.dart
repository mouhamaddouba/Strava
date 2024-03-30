import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:steps_tracker/source/core/error/failures/app_failure.dart';
import 'package:steps_tracker/source/core/usecase/use_case.dart';
import 'package:steps_tracker/source/features/data/models/exchange_history_model.dart';
import 'package:steps_tracker/source/features/domain/repositories/bottom_navbar_repository.dart';

@injectable
class SetExchangeHistoryUseCase extends UseCase<bool, ExchangeHistoryModel> {
  final BottomNavbarRepository _bottomNavbarRepository;

  SetExchangeHistoryUseCase(
    this._bottomNavbarRepository,
  );

  @override
  Future<Either<Failure, bool>> call(ExchangeHistoryModel params) async {
    return await _bottomNavbarRepository.setExchangeHistory(params);
  }
}
