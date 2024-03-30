import 'package:steps_tracker/source/core/error/exceptions/app_exception.dart';
import 'package:steps_tracker/source/core/error/exceptions/firebase_auth_exception_app.dart';
import 'package:steps_tracker/source/core/error/failures/firebase_auth_failure.dart';

abstract class Failure {}

// Can be used when the list of exceptions is exhausted.

class GenericFailure extends Failure {
  final String message;

  GenericFailure({required this.message});
}

Failure firebaseExceptionsDecoder(AppException e) {
  if (e is FirebaseAuthExceptionApp) {
    return e.when(
      operationNotAllowed: (msg) => FirebaseAuthFailure.operationNotAllowed(
        message: msg,
      ),
    );
  } else {
    return GenericFailure(
      message: 'Something went wrong!',
    );
  }
}
