import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:steps_tracker/source/core/error/exceptions/app_exception.dart';

part 'firebase_auth_exception_app.freezed.dart';

@freezed
@Implements()
abstract class FirebaseAuthExceptionApp extends AppException
    with _$FirebaseAuthExceptionApp {
  factory FirebaseAuthExceptionApp.operationNotAllowed({
    required String message,
  }) = OperationNotAllowed;
}
