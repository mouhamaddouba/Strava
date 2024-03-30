import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:steps_tracker/source/core/error/failures/app_failure.dart';
import 'package:steps_tracker/source/core/usecase/use_case.dart';
import 'package:steps_tracker/source/features/data/models/exchange_history_model.dart';
import 'package:steps_tracker/source/features/domain/repositories/bottom_navbar_repository.dart';

@injectable
class GetExchangeHistoryUseCase
    extends UseCase<Stream<List<ExchangeHistoryModel>>, NoParams> {
  final BottomNavbarRepository _bottomNavbarRepository;

  GetExchangeHistoryUseCase(
    this._bottomNavbarRepository,
  );

  @override
  Future<Either<Failure, Stream<List<ExchangeHistoryModel>>>> call(
      NoParams params) async {
    return await _bottomNavbarRepository.exchangesHistoryStream();
  }
}
