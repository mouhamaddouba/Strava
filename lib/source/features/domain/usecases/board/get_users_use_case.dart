import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:steps_tracker/source/core/error/failures/app_failure.dart';
import 'package:steps_tracker/source/core/usecase/use_case.dart';
import 'package:steps_tracker/source/features/data/models/user_model.dart';
import 'package:steps_tracker/source/features/domain/repositories/bottom_navbar_repository.dart';

@injectable
class GetUsersUseCase extends UseCase<Stream<List<UserModel>>, NoParams> {
  final BottomNavbarRepository _bottomNavbarRepository;

  GetUsersUseCase(this._bottomNavbarRepository);

  @override
  Future<Either<Failure, Stream<List<UserModel>>>> call(NoParams params) async {
    return await _bottomNavbarRepository.usersStream();
  }
}
