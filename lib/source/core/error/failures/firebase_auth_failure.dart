import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:steps_tracker/source/core/error/failures/app_failure.dart';

part 'firebase_auth_failure.freezed.dart';

@freezed
@Implements()
abstract class FirebaseAuthFailure extends Failure with _$FirebaseAuthFailure {
  const factory FirebaseAuthFailure.operationNotAllowed({
    required String message,
  }) = OperationNotAllowed;
}
