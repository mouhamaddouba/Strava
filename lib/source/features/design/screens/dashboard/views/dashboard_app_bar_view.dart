import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:steps_tracker/source/common/translations/l10n.dart';
import 'package:steps_tracker/source/common/values/constants/app_assets.dart';
import 'package:steps_tracker/source/common/values/constants/app_color.dart';
import 'package:steps_tracker/source/common/values/constants/app_key_locale.dart';
import 'package:steps_tracker/source/features/design/cubits/utility/utility_cubit.dart';

class DashboardAppBarView extends StatelessWidget {
  const DashboardAppBarView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final utilityCubit = Provider.of<UtilityCubit>(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 10.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Change languages
            InkWell(
              onTap: () async => await utilityCubit.changeLocale(
                utilityCubit.locale == AppKeyLocale.arabicLocale
                    ? AppKeyLocale.englishLocale
                    : AppKeyLocale.arabicLocale,
              ),
              child: Text(
                utilityCubit.locale == AppKeyLocale.arabicLocale ? 'EN' : 'AR',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            ),

            // Logo with Pedometer
            Row(
              children: [
                // Logo
                SvgPicture.asset(
                  AppAssets.logo,
                  color: AppColors.kTotalStepsColor,
                ),

                // Space
                const SizedBox(
                  width: 8,
                ),

                // Pedometer
                Text(
                  S.of(context).pedometer,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              ],
            ),

            // Change Theme
            InkWell(
              onTap: () async =>
                  await Provider.of<UtilityCubit>(context, listen: false)
                      .switchTheme(),
              child: Icon(
                size: 25,
                utilityCubit.isDark ? Icons.sunny : CupertinoIcons.moon_fill,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
