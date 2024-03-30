import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:steps_tracker/source/common/routes/app_pages.dart';
import 'package:steps_tracker/source/common/routes/app_routes.dart';
import 'package:steps_tracker/source/common/themes/app_themes.dart';
import 'package:steps_tracker/source/common/translations/l10n.dart';
import 'package:steps_tracker/source/core/di/injection_container.dart';
import 'package:steps_tracker/source/features/design/cubits/auth_status/auth_status_cubit.dart';
import 'package:steps_tracker/source/features/design/cubits/utility/utility_cubit.dart';
import 'package:steps_tracker/source/features/design/cubits/utility/utility_state.dart';

class App extends StatefulWidget {
  const App({
    super.key,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  PermissionStatus permissionStatus = PermissionStatus.denied;

  @override
  void initState() {
    requestPermission();
    super.initState();
  }

  Future<void> requestPermission() async {
    final status = await Permission.activityRecognition.request();
    setState(() {
      permissionStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UtilityCubit>(
          lazy: false,
          create: (BuildContext context) {
            final cubit = getIt<UtilityCubit>();
            cubit.getCurrentTheme();
            cubit.getCurrentLocale();
            return cubit;
          },
        ),
        BlocProvider<AuthStatusCubit>(
          lazy: false,
          create: (context) {
            final cubit = getIt<AuthStatusCubit>();
            cubit.checkAuthStatus();
            return cubit;
          },
        ),
      ],
      child: GestureDetector(
        onTap: () {
          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
        },
        child: Builder(builder: (context) {
          final utility = BlocProvider.of<UtilityCubit>(context);
          return BlocBuilder<UtilityCubit, UtilityState>(
            bloc: utility,
            builder: (context, state) {
              return MaterialApp(
                /// Cancel check marker
                debugShowCheckedModeBanner: false,

                /// App name
                title: 'Flutter Steps Tracker',

                /// Theme
                themeMode: utility.currentTheme(),
                theme: AppThemes.lightTheme(context),
                darkTheme: AppThemes.darkTheme(context),

                /// Routing
                onGenerateRoute: AppPages.generateRoutes,
                initialRoute: AppRoutes.stepTrackerView,

                /// Locale
                locale: utility.locale,
                supportedLocales: S.delegate.supportedLocales,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],

                /// Response
                builder: (context, child) {
                  return ResponsiveBreakpoints.builder(
                    child: child!,
                    breakpoints: [
                      const Breakpoint(start: 0, end: 450, name: MOBILE),
                      const Breakpoint(start: 451, end: 800, name: TABLET),
                      const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                    ],
                  );
                },
              );
            },
          );
        }),
      ),
    );
  }
}
