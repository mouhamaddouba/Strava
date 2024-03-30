import 'package:injectable/injectable.dart';
import 'package:steps_tracker/source/common/values/enums/enums.dart';
import 'package:steps_tracker/source/core/usecase/use_case.dart';
import 'package:steps_tracker/source/features/domain/repositories/auth_repository.dart';

@injectable
class AuthStatusUseCase
    extends UseCaseWithoutParams<Future<AuthStatus>, NoParams> {
  final AuthRepository _authRepository;

  AuthStatusUseCase(this._authRepository);

  @override
  Future<AuthStatus> call(NoParams params) async {
    return await _authRepository.hasAnAccount();
  }
}
