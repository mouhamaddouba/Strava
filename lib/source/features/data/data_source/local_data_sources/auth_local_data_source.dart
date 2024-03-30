import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:steps_tracker/source/common/values/constants/app_settings.dart';
import 'package:steps_tracker/source/features/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> persistAuth(
    UserModel user,
  );

  Future<UserModel?> currentUser();
}

@Singleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final SharedPreferences _sharedPreferences;

  AuthLocalDataSourceImpl(
    this._sharedPreferences,
  );

  @override
  Future<UserModel?> currentUser() async {
    if (_sharedPreferences.containsKey(AppSettings.currentUser)) {
      final currentUserAsJSON = json.decode(
        _sharedPreferences.getString(AppSettings.currentUser)!,
      );

      final user = UserModel.fromMap(
        currentUserAsJSON,
        currentUserAsJSON['uid'] ?? '',
      );
      return user;
    }
    return null;
  }

  @override
  Future<void> persistAuth(UserModel user) async {
    final encodedJson = json.encode(user.toMap());

    _sharedPreferences.setString(
      AppSettings.currentUser,
      encodedJson.toString(),
    );
  }
}
