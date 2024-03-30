import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:steps_tracker/source/core/error/failures/app_failure.dart';
import 'package:steps_tracker/source/core/usecase/use_case.dart';
import 'package:steps_tracker/source/features/domain/repositories/auth_repository.dart';

@injectable
class SignInUseCase extends UseCase<void, String> {
  final AuthRepository authRepository;

  SignInUseCase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await authRepository.signInAnonymously(
      params,
    );
  }
}
