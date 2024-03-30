import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steps_tracker/source/common/translations/l10n.dart';
import 'package:steps_tracker/source/common/values/constants/app_assets.dart';

class ReadyCardView extends StatelessWidget {
  const ReadyCardView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Are you ready
            Text(
              S.of(context).areyouready,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
            ),

            // Space
            const SizedBox(
              width: 8.0,
            ),

            // Image Feet
            SvgPicture.asset(
              AppAssets.kReadyUser,
              fit: BoxFit.cover,
              height: 60,
              color: Theme.of(context).scaffoldBackgroundColor,
              // color: AppColors.kBackgroundColor,
            ),
          ],
        ),
      ),
    );
  }
}
