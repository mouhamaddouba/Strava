import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:steps_tracker/source/common/translations/l10n.dart';
import 'package:steps_tracker/source/core/error/failures/firebase_auth_failure.dart';
import 'package:steps_tracker/source/features/design/cubits/auth_actions/auth_state.dart';
import 'package:steps_tracker/source/features/domain/usecases/sign_in/sign_in_use_case.dart';

@singleton
class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase _signInAnonymouslyUseCase;

  AuthCubit(
    this._signInAnonymouslyUseCase,
  ) : super(const AuthState.initial());

  Future<void> signInAnonymously({
    required String name,
  }) async {
    emit(
      const AuthState.loading(),
    );
    final result = await _signInAnonymouslyUseCase(name);
    emit(
      result.fold(
        (failure) {
          if (failure is FirebaseAuthFailure) {
            failure.maybeWhen(
              orElse: () {
                return AuthState.error(message: S.current.somethingWentWrong);
              },
              operationNotAllowed: (message) {
                return AuthState.error(message: message);
              },
            );
          }
          return AuthState.error(message: S.current.somethingWentWrong);
        },
        (_) => const AuthState.loggedIn(),
      ),
    );
  }
}
