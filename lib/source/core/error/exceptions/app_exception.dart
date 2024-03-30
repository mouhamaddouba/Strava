import 'package:firebase_auth/firebase_auth.dart';
import 'package:steps_tracker/source/core/error/exceptions/firebase_auth_exception_app.dart';

abstract class AppException implements Exception {}

class GenericAppException extends AppException {
  final String message;

  GenericAppException({
    required this.message,
  });
}

void firebaseErrorDecoder(FirebaseException e) {
  if (e is FirebaseAuthException) {
  } else {
    throw GenericAppException(
      message: 'Something went wrong!',
    );
  }
}

void decodeAuthException(FirebaseAuthException e) {
  if (e.code == 'auth/operation-not-allowed') {
    throw FirebaseAuthExceptionApp.operationNotAllowed(
      message: 'Something went wrong, please contact the support!',
    );
  } else {
    throw GenericAppException(message: 'Something went wrong!');
  }
}
