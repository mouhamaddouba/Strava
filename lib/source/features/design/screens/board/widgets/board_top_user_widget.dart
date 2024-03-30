import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steps_tracker/source/common/values/constants/app_assets.dart';
import 'package:steps_tracker/source/common/values/constants/app_color.dart';
import 'package:steps_tracker/source/features/data/models/user_model.dart';

class BoardTopUserWidget extends StatelessWidget {
  final UserModel item;
  final int sNumber;
  final bool first;

  const BoardTopUserWidget({
    super.key,
    required this.item,
    required this.sNumber,
    this.first = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Ranking user
        Text(
          sNumber.toString(),
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).primaryColorDark,
              ),
        ),

        // Space
        const SizedBox(
          height: 4.0,
        ),

        // Icon arrow
        Icon(
          CupertinoIcons.arrowtriangle_up_fill,
          color: Theme.of(context).primaryColorLight,
        ),

        // Space
        const SizedBox(
          height: 8.0,
        ),

        // Image user
        CircleAvatar(
          radius: first ? 75 : 55,
          backgroundColor: AppColors.kPrimaryColor,
          child: CircleAvatar(
            backgroundColor: AppColors.kBackgroundColor,
            radius: first ? 80 : 60,
            child: SvgPicture.asset(
              AppAssets.kProfileUser,
            ),
          ),
        ),

        // Space
        const SizedBox(
          height: 8.0,
        ),

        // Name of user
        Text(
          item.name,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).primaryColorDark,
                fontWeight: FontWeight.w600,
              ),
        ),

        // Number of steps
        Text(
          item.totalSteps.toString(),
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Theme.of(context).primaryColorLight,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
