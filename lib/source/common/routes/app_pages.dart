import 'package:flutter/cupertino.dart';
import 'package:steps_tracker/source/common/routes/app_routes.dart';
import 'package:steps_tracker/source/features/design/screens/dashboard/dashboard_screen.dart';
import 'package:steps_tracker/source/features/design/screens/steper_tracker/step_tracker_view.dart';

class AppPages {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      // NavBar
      case AppRoutes.dashboard:
        {
          return CupertinoPageRoute(
            builder: (_) => DashboardScreen(),
            settings: settings,
          );
        }
      case AppRoutes.stepTrackerView:

      // check if user is Authentication
      default:
        {
          return CupertinoPageRoute(
            builder: (_) => const StepTrackerView(),
            settings: settings,
          );
        }
    }
  }
}
