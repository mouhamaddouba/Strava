import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steps_tracker/source/common/translations/l10n.dart';
import 'package:steps_tracker/source/common/values/constants/app_assets.dart';
import 'package:steps_tracker/source/common/values/constants/app_color.dart';
import 'package:steps_tracker/source/features/design/cubits/auth_actions/auth_cubit.dart';

class AuthBodyView extends StatelessWidget {
  final bool isLoading;

  const AuthBodyView({
    super.key,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();

    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Logo
            SvgPicture.asset(
              height: 180,
              AppAssets.logo,
              fit: BoxFit.cover,
              color: AppColors.kLogoColor,
            ),

            // Your all-in one activity
            Text(
              S.of(context).allInOneTrack,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColors.kBackgroundColor,
                    fontSize: 20,
                  ),
            ),

            // Space
            const SizedBox(
              height: 150,
            ),

            // Filed for enter user
            TextFormField(
              autocorrect: false,
              controller: nameController,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.kGreyColor,
              ),
              decoration: InputDecoration(
                hintText: S.of(context).enterYourName,
              ),
              validator: (val) {
                return val!.isEmpty ? S.of(context).enterYourName : null;
              },
            ),

            // Space
            const SizedBox(
              height: 16.0,
            ),

            // Button to login
            InkWell(
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  await BlocProvider.of<AuthCubit>(context).signInAnonymously(
                    name: nameController.text,
                  );
                }
              },
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
                child: Center(
                  child: !isLoading
                      ? Text(
                          S.of(context).startUsingSteps,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: AppColors.kBackgroundColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                        )
                      : const CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
