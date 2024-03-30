import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_tracker/source/common/values/constants/app_assets.dart';
import 'package:steps_tracker/source/common/values/constants/app_color.dart';
import 'package:steps_tracker/source/core/di/injection_container.dart';
import 'package:steps_tracker/source/features/design/cubits/auth_actions/auth_cubit.dart';
import 'package:steps_tracker/source/features/design/cubits/auth_actions/auth_state.dart';
import 'package:steps_tracker/source/features/design/cubits/auth_status/auth_status_cubit.dart';
import 'package:steps_tracker/source/features/design/screens/auth/views/auth_body_view.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => getIt<AuthCubit>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: Stack(
              children: [
                // Image Man
                Image.asset(
                  AppAssets.kBackgroundIntro,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),

                // Opacity for image
                const SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Opacity(
                    opacity: 0.4,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.kPrimaryColor,
                      ),
                    ),
                  ),
                ),

                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 48.0,
                    ),
                    child: Center(
                      child: BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          state.maybeWhen(
                            loggedIn: () {
                              final cubit =
                                  BlocProvider.of<AuthStatusCubit>(context);
                              cubit.checkAuthStatus();
                            },
                            orElse: () {},
                          );
                        },
                        builder: (context, state) {
                          return state.maybeWhen(
                            loading: () => const AuthBodyView(isLoading: true),
                            orElse: () => const AuthBodyView(isLoading: false),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
