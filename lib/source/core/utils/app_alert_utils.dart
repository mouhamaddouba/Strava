import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:steps_tracker/source/common/layouts/app_dialog_widget.dart';
import 'package:steps_tracker/source/features/design/cubits/rewards/rewards_cubit.dart';
import 'package:steps_tracker/source/features/design/cubits/rewards/rewards_state.dart';

class AppAlertUtils {
  Future showAlertDialog(
    BuildContext context, {
    required String title,
    String? content,
    Widget? contentWidget,
    String? cancelActionText,
    required String defaultActionText,
    VoidCallback? defaultAction,
    RewardsCubit? cubit,
  }) {
    if (!Platform.isIOS) {
      return showDialog(
        context: context,
        builder: (context) => cubit == null
            ? AppDialogWidgets(
                isAndroid: false,
                title: title,
                defaultActionText: defaultActionText,
                content: content,
                contentWidget: contentWidget,
                cancelActionText: cancelActionText,
                defaultAction: defaultAction,
              )
            : BlocConsumer<RewardsCubit, RewardsState>(
                bloc: cubit,
                listener: (context, state) {
                  state.maybeWhen(
                    earnLoaded: () {
                      Navigator.of(context).pop();
                    },
                    orElse: () {},
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    earnLoading: () => AppDialogWidgets(
                      isAndroid: false,
                      title: title,
                      defaultActionText: defaultActionText,
                      content: content,
                      contentWidget: contentWidget,
                      cancelActionText: cancelActionText,
                      defaultAction: defaultAction,
                      isLoading: true,
                    ),
                    orElse: () => AppDialogWidgets(
                      isAndroid: false,
                      title: title,
                      defaultActionText: defaultActionText,
                      content: content,
                      contentWidget: contentWidget,
                      cancelActionText: cancelActionText,
                      defaultAction: defaultAction,
                    ),
                  );
                },
              ),
      );
    }
    return showCupertinoDialog(
      context: context,
      builder: (context) => cubit == null
          ? AppDialogWidgets(
              isAndroid: false,
              title: title,
              defaultActionText: defaultActionText,
              content: content,
              contentWidget: contentWidget,
              cancelActionText: cancelActionText,
              defaultAction: defaultAction,
            )
          : BlocConsumer<RewardsCubit, RewardsState>(
              bloc: cubit,
              listener: (context, state) {
                state.maybeWhen(
                  earnLoaded: () {
                    Navigator.of(context).pop();
                  },
                  orElse: () {},
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  earnLoading: () => AppDialogWidgets(
                    isAndroid: false,
                    title: title,
                    defaultActionText: defaultActionText,
                    content: content,
                    contentWidget: contentWidget,
                    cancelActionText: cancelActionText,
                    defaultAction: defaultAction,
                    isLoading: true,
                  ),
                  orElse: () => AppDialogWidgets(
                    isAndroid: false,
                    title: title,
                    defaultActionText: defaultActionText,
                    content: content,
                    contentWidget: contentWidget,
                    cancelActionText: cancelActionText,
                    defaultAction: defaultAction,
                  ),
                );
              },
            ),
    );
  }
}
