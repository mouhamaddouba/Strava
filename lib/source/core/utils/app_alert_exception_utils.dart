import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:steps_tracker/source/core/utils/app_alert_utils.dart';

class AppAlertExceptionUtils {
  Future<void> showExceptionAlertDialog(
    BuildContext context, {
    required String title,
    required Exception exception,
  }) {
    return AppAlertUtils().showAlertDialog(
      context,
      title: title,
      content: _message(exception),
      defaultActionText: 'OK',
    );
  }

  String _message(Exception exception) {
    if (exception is FirebaseException) {
      return exception.message!;
    }
    return exception.toString();
  }
}
