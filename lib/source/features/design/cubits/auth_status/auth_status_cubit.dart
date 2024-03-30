import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:steps_tracker/source/common/values/enums/enums.dart';
import 'package:steps_tracker/source/core/usecase/use_case.dart';
import 'package:steps_tracker/source/features/design/cubits/auth_status/auth_status_state.dart';
import 'package:steps_tracker/source/features/domain/usecases/sign_in/auth_status_use_case.dart';

@singleton
class AuthStatusCubit extends Cubit<AuthStatusState> {
  final AuthStatusUseCase _authStatusUseCase;

  AuthStatusCubit(
    this._authStatusUseCase,
  ) : super(const AuthStatusState.unAuthenticated());

  Future<void> checkAuthStatus() async {
    final status = await _authStatusUseCase(NoParams());
    switch (status) {
      case AuthStatus.authenticated:
        emit(
          const AuthStatusState.authenticated(),
        );
        break;
      case AuthStatus.unAuthenticated:
        emit(
          const AuthStatusState.unAuthenticated(),
        );
        break;
    }
  }
}
