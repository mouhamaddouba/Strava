import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steps_tracker/source/common/values/constants/app_assets.dart';
import 'package:steps_tracker/source/common/values/constants/app_color.dart';
import 'package:steps_tracker/source/features/data/models/user_model.dart';

class BoardUserRankWidget extends StatelessWidget {
  final UserModel item;
  final int sNumber;

  const BoardUserRankWidget({
    super.key,
    required this.item,
    required this.sNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            // Rank of user
            Text(
              sNumber.toString(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).primaryColorDark,
                  ),
            ),

            // Space
            const SizedBox(
              width: 4.0,
            ),

            // Icon rank
            Icon(
              CupertinoIcons.arrowtriangle_up_fill,
              color: Theme.of(context).primaryColorLight,
              size: 20,
            ),
          ],
        ),

        // Space
        const SizedBox(
          width: 16.0,
        ),

        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Image of user
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.kBackgroundColor,
                child: SvgPicture.asset(
                  AppAssets.kProfileUser,
                ),
              ),

              // Name of user
              Text(
                item.name,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.w400,
                    ),
              ),

              // Space
              const SizedBox(
                width: 0,
              ),

              // Number od steps
              Text(
                item.totalSteps.toString(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).primaryColorLight,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
