import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:steps_tracker/source/common/values/constants/app_key_locale.dart';
import 'package:steps_tracker/source/common/values/constants/app_settings.dart';
import 'package:steps_tracker/source/core/di/injection_container.dart';
import 'package:steps_tracker/source/core/helper/cache_helper.dart';
import 'package:steps_tracker/source/features/design/cubits/utility/utility_state.dart';

@injectable
class UtilityCubit extends Cubit<UtilityState> {
  UtilityCubit() : super(const UtilityState.initial());

  bool isDark = false;
  Locale locale = AppKeyLocale.englishLocale;

  ThemeMode currentTheme() => isDark ? ThemeMode.dark : ThemeMode.light;

  Future<void> getCurrentTheme() async {
    await getIt<CacheHelper>().has(AppSettings.theme).then((hasToken) async {
      if (hasToken) {
        await getIt<CacheHelper>().get(AppSettings.theme).then((value) async {
          isDark = value as bool;
        });
      } else {
        isDark = false;
      }
    });

    emit(const UtilityState.changeState());
  }

  Future<void> switchTheme() async {
    isDark = !isDark;
    await getIt<CacheHelper>().put(AppSettings.theme, isDark);
    emit(UtilityState.reloadingTheme(isDark));
  }

  Future<void> getCurrentLocale() async {
    await getIt<CacheHelper>()
        .has(AppSettings.localeKey)
        .then((hasToken) async {
      if (hasToken) {
        await getIt<CacheHelper>().get(AppSettings.localeKey).then(
          (value) async {
            locale = Locale.fromSubtags(
                languageCode: value.split('_').first,
                countryCode: value.split('_').last);
          },
        );
      } else {
        locale = AppKeyLocale.englishLocale;
      }
    });
    emit(const UtilityState.changeState());
  }

  Future<void> changeLocale(Locale lc) async {
    locale = lc;
    await getIt<CacheHelper>().put(AppSettings.localeKey, locale.toString());
    debugPrint('changedLocale');
    emit(UtilityState.reloadingLocale(locale));
  }
}
