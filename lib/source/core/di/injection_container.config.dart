// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i5;

import '../../common/storage/database.dart' as _i4;
import '../../features/data/data_source/local_data_sources/auth_local_data_source.dart'
    as _i7;
import '../../features/data/data_source/remote_data_source/auth_remote_data_source.dart'
    as _i8;
import '../../features/data/repositories/auth_repository_impl.dart' as _i10;
import '../../features/data/repositories/bottom_navbar_repository_impl.dart'
    as _i13;
import '../../features/design/cubits/auth_actions/auth_cubit.dart' as _i25;
import '../../features/design/cubits/auth_status/auth_status_cubit.dart'
    as _i26;
import '../../features/design/cubits/exchanges/exchanges_history_cubit.dart'
    as _i27;
import '../../features/design/cubits/home/home_cubit.dart' as _i28;
import '../../features/design/cubits/board/leaderboard_cubit.dart' as _i20;
import '../../features/design/cubits/rewards/rewards_cubit.dart' as _i21;
import '../../features/design/cubits/utility/utility_cubit.dart' as _i6;
import '../../features/domain/repositories/auth_repository.dart' as _i9;
import '../../features/domain/repositories/bottom_navbar_repository.dart'
    as _i12;
import '../../features/domain/usecases/board/get_user_data_use_case.dart'
    as _i18;
import '../../features/domain/usecases/board/get_users_use_case.dart' as _i19;
import '../../features/domain/usecases/exchange/get_exchange_history_use_case.dart'
    as _i16;
import '../../features/domain/usecases/exchange/set_exchange_history_use_case.dart'
    as _i22;
import '../../features/domain/usecases/home/set_steps_and_points_use_case.dart'
    as _i23;
import '../../features/domain/usecases/reward/earn_reward_use_case.dart'
    as _i15;
import '../../features/domain/usecases/reward/get_rewards_use_case.dart'
    as _i17;
import '../../features/domain/usecases/sign_in/auth_status_use_case.dart'
    as _i11;
import '../../features/domain/usecases/sign_in/sign_in_use_case.dart' as _i24;
import '../helper/cache_helper.dart' as _i14;
import '../services/auth_services.dart' as _i3;
import 'app_module.dart' as _i29;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.singleton<_i3.AuthServices>(() => _i3.Auth());
    gh.singleton<_i4.Database>(() => _i4.FireStoreDatabase());
    await gh.factoryAsync<_i5.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.factory<_i6.UtilityCubit>(() => _i6.UtilityCubit());
    gh.singleton<_i7.AuthLocalDataSource>(
        () => _i7.AuthLocalDataSourceImpl(gh<_i5.SharedPreferences>()));
    gh.singleton<_i8.AuthRemoteDataSource>(
        () => _i8.AuthRemoteDataSourceImpl(authBase: gh<_i3.AuthServices>()));
    gh.singleton<_i9.AuthRepository>(() => _i10.AuthRepositoryImpl(
          gh<_i8.AuthRemoteDataSource>(),
          gh<_i7.AuthLocalDataSource>(),
          gh<_i4.Database>(),
        ));
    gh.factory<_i11.AuthStatusUseCase>(
        () => _i11.AuthStatusUseCase(gh<_i9.AuthRepository>()));
    gh.singleton<_i12.BottomNavbarRepository>(
        () => _i13.BottomNavbarRepositoryImpl(
              gh<_i4.Database>(),
              gh<_i7.AuthLocalDataSource>(),
            ));
    gh.singleton<_i14.CacheHelper>(
        () => _i14.CacheHelperImpl(gh<_i5.SharedPreferences>()));
    gh.factory<_i15.EarnRewardUseCase>(
        () => _i15.EarnRewardUseCase(gh<_i12.BottomNavbarRepository>()));
    gh.factory<_i16.GetExchangeHistoryUseCase>(() =>
        _i16.GetExchangeHistoryUseCase(gh<_i12.BottomNavbarRepository>()));
    gh.factory<_i17.GetRewardsUseCase>(
        () => _i17.GetRewardsUseCase(gh<_i12.BottomNavbarRepository>()));
    gh.factory<_i18.GetUserDataUseCase>(
        () => _i18.GetUserDataUseCase(gh<_i12.BottomNavbarRepository>()));
    gh.factory<_i19.GetUsersUseCase>(
        () => _i19.GetUsersUseCase(gh<_i12.BottomNavbarRepository>()));
    gh.factory<_i20.LeaderboardCubit>(
        () => _i20.LeaderboardCubit(gh<_i19.GetUsersUseCase>()));
    gh.factory<_i21.RewardsCubit>(() => _i21.RewardsCubit(
          gh<_i17.GetRewardsUseCase>(),
          gh<_i18.GetUserDataUseCase>(),
          gh<_i15.EarnRewardUseCase>(),
        ));
    gh.factory<_i22.SetExchangeHistoryUseCase>(() =>
        _i22.SetExchangeHistoryUseCase(gh<_i12.BottomNavbarRepository>()));
    gh.factory<_i23.SetStepsAndPointsUseCase>(
        () => _i23.SetStepsAndPointsUseCase(gh<_i12.BottomNavbarRepository>()));
    gh.factory<_i24.SignInUseCase>(
        () => _i24.SignInUseCase(authRepository: gh<_i9.AuthRepository>()));
    gh.singleton<_i25.AuthCubit>(
        () => _i25.AuthCubit(gh<_i24.SignInUseCase>()));
    gh.singleton<_i26.AuthStatusCubit>(
        () => _i26.AuthStatusCubit(gh<_i11.AuthStatusUseCase>()));
    gh.factory<_i27.ExchangesHistoryCubit>(
        () => _i27.ExchangesHistoryCubit(gh<_i16.GetExchangeHistoryUseCase>()));
    gh.factory<_i28.HomeCubit>(() => _i28.HomeCubit(
          gh<_i22.SetExchangeHistoryUseCase>(),
          gh<_i23.SetStepsAndPointsUseCase>(),
          gh<_i18.GetUserDataUseCase>(),
        ));
    return this;
  }
}

class _$AppModule extends _i29.AppModule {}
