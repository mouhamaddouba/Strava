import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDialogWidgets extends StatelessWidget {
  final String title;
  final Widget? contentWidget;
  final String? content;
  final String? cancelActionText;
  final VoidCallback? defaultAction;
  final String defaultActionText;
  final bool isLoading;
  final bool isAndroid;

  const AppDialogWidgets({
    super.key,
    required this.title,
    this.contentWidget,
    this.content,
    this.cancelActionText,
    this.defaultAction,
    required this.defaultActionText,
    this.isLoading = false,
    required this.isAndroid,
  });

  @override
  Widget build(BuildContext context) {
    return isAndroid == true
        ? AlertDialog(
            title: Text(title),
            content: contentWidget == null && content != null
                ? Text(content!)
                : contentWidget,
            actions: <Widget>[
              if (cancelActionText != null)
                TextButton(
                  child: Text(cancelActionText!),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
              TextButton(
                onPressed:
                    defaultAction ?? () => Navigator.of(context).pop(true),
                child: !isLoading
                    ? Text(defaultActionText)
                    : const CircularProgressIndicator(),
              ),
            ],
          )
        : CupertinoAlertDialog(
            title: Text(title),
            content: contentWidget == null && content != null
                ? Text(content!)
                : contentWidget,
            actions: <Widget>[
              if (cancelActionText != null)
                CupertinoDialogAction(
                  child: Text(cancelActionText!),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
              CupertinoDialogAction(
                onPressed:
                    defaultAction ?? () => Navigator.of(context).pop(true),
                child: !isLoading
                    ? Text(defaultActionText)
                    : const CircularProgressIndicator(),
              ),
            ],
          );
  }
}
