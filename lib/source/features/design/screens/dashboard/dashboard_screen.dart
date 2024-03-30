import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:steps_tracker/source/common/translations/l10n.dart';
import 'package:steps_tracker/source/features/design/screens/board/board_screen.dart';
import 'package:steps_tracker/source/features/design/screens/dashboard/views/dashboard_app_bar_view.dart';
import 'package:steps_tracker/source/features/design/screens/exchanges/exchanges_screen.dart';
import 'package:steps_tracker/source/features/design/screens/home/home_screens.dart';
import 'package:steps_tracker/source/features/design/screens/rewards/rewards_screen.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({
    super.key,
  });

  final PersistentTabController persistentTabController =
      PersistentTabController();

  @override
  Widget build(BuildContext context) {
    List<Widget> pages() {
      return [
        const HomeScreens(),
        const ExchangesScreen(),
        const RewardsScreen(),
        const BoardScreen(),
      ];
    }

    List<PersistentBottomNavBarItem> items() {
      return [
        // Home
        PersistentBottomNavBarItem(
          title: (S.current.home),
          icon: const Icon(CupertinoIcons.home),
          inactiveColorPrimary: CupertinoColors.systemGrey,
          activeColorPrimary: Theme.of(context).primaryColor,
        ),

        // Exchange
        PersistentBottomNavBarItem(
          title: (S.current.exchanges),
          icon: const Icon(Icons.track_changes),
          inactiveColorPrimary: CupertinoColors.systemGrey,
          activeColorPrimary: Theme.of(context).primaryColor,
        ),

        // Rewards
        PersistentBottomNavBarItem(
          title: (S.current.rewards),
          icon: const Icon(Icons.card_giftcard),
          inactiveColorPrimary: CupertinoColors.systemGrey,
          activeColorPrimary: Theme.of(context).primaryColor,
        ),

        // Board
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.developer_board),
          title: (S.current.leaderboard),
          activeColorPrimary: Theme.of(context).primaryColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ];
    }

    final size = MediaQuery.of(context).size;
    return Scaffold(
      // AppBar
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, size.height * 0.5),
        child: const DashboardAppBarView(),
      ),

      // Bottom Bar
      body: SafeArea(
        child: PersistentTabView(
          context,
          items: items(),
          screens: pages(),
          stateManagement: true,
          confineInSafeArea: true,
          resizeToAvoidBottomInset: true,
          handleAndroidBackButtonPress: true,
          popAllScreensOnTapOfSelectedTab: true,
          hideNavigationBarWhenKeyboardShows: true,
          navBarStyle: NavBarStyle.style3,
          controller: persistentTabController,
          popActionScreens: PopActionScreensType.all,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(10.0),
            colorBehindNavBar: Theme.of(context).scaffoldBackgroundColor,
          ),
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 500),
          ),
        ),
      ),
    );
  }
}
