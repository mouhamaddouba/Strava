import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:steps_tracker/source/common/storage/database.dart';
import 'package:steps_tracker/source/core/error/exceptions/app_exception.dart';
import 'package:steps_tracker/source/core/error/failures/app_failure.dart';
import 'package:steps_tracker/source/features/data/data_source/local_data_sources/auth_local_data_source.dart';
import 'package:steps_tracker/source/features/data/models/exchange_history_model.dart';
import 'package:steps_tracker/source/features/data/models/reward_model.dart';
import 'package:steps_tracker/source/features/data/models/steps_and_points_model.dart';
import 'package:steps_tracker/source/features/data/models/user_model.dart';
import 'package:steps_tracker/source/features/domain/repositories/bottom_navbar_repository.dart';

@Singleton(as: BottomNavbarRepository)
class BottomNavbarRepositoryImpl implements BottomNavbarRepository {
  final Database _database;
  final AuthLocalDataSource _authLocalDataSource;

  BottomNavbarRepositoryImpl(
    this._database,
    this._authLocalDataSource,
  );

  @override
  Stream<List<RewardModel>> rewardsStream() {
    return _database.rewardsStream();
  }

  @override
  Future<Either<Failure, bool>> setExchangeHistory(
    ExchangeHistoryModel exchangeHistory,
  ) async {
    try {
      final user = await _authLocalDataSource.currentUser();
      await _database.setExchangeHistory(
        exchangeHistory,
        user!.uid,
      );
      return const Right(true);
    } on AppException catch (e) {
      return Left(
        firebaseExceptionsDecoder(e),
      );
    }
  }

  @override
  Future<Either<Failure, Stream<List<ExchangeHistoryModel>>>>
      exchangesHistoryStream() async {
    try {
      final user = await _authLocalDataSource.currentUser();
      return Right(
        _database.exchangeHistoryStream(user!.uid),
      );
    } on AppException catch (e) {
      return Left(
        firebaseExceptionsDecoder(e),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> setStepsAndPoints(int steps) async {
    try {
      final user = await _authLocalDataSource.currentUser();
      var totalHealthPoints = 0;
      int healthPoints = (steps ~/ 100) * 5;
      await _database.setDailySteps(
        StepsAndPointsModel(
          id: documentIdForDailyUse(),
          steps: steps,
          points: healthPoints,
        ),
        user!.uid,
      );
      var myRewardsList = await _database.myRewardsStream(user.uid).first;
      int deletedPoints = 0;
      for (var reward in myRewardsList) {
        deletedPoints += reward.points ?? 0;
      }
      totalHealthPoints = healthPoints - deletedPoints;
      final newUser = UserModel(
        uid: user.uid,
        name: user.name,
        totalSteps: steps,
        healthPoints: totalHealthPoints,
      );
      await _database.setUserData(newUser);
      await _authLocalDataSource.persistAuth(newUser);
      return const Right(true);
    } on AppException catch (e) {
      return Left(
        firebaseExceptionsDecoder(e),
      );
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserData() async {
    try {
      final user = await _authLocalDataSource.currentUser();
      return Right(user!);
    } on AppException catch (e) {
      return Left(
        firebaseExceptionsDecoder(e),
      );
    }
  }

  @override
  Future<Either<Failure, Stream<UserModel>>> getRealTimeUserData() async {
    try {
      final user = await _authLocalDataSource.currentUser();
      return Right(_database.getUserStream(user!.uid));
    } on AppException catch (e) {
      return Left(
        firebaseExceptionsDecoder(e),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> earnAReward(RewardModel reward) async {
    try {
      final user = await _authLocalDataSource.currentUser();
      await _database.setRewardOrder(
        reward.copyWith(
          id: documentIdFromLocalGenerator(),
        ),
        user!.uid,
      );
      var realUserData = await _database.getUserStream(user.uid).first;
      await _database.setUserData(
        realUserData.copyWith(
          healthPoints: realUserData.healthPoints - (reward.points ?? 0),
        ),
      );
      return const Right(true);
    } on AppException catch (e) {
      return Left(
        firebaseExceptionsDecoder(e),
      );
    }
  }

  @override
  Future<Either<Failure, Stream<List<UserModel>>>> usersStream() async {
    try {
      return Right(_database.usersStream());
    } on AppException catch (e) {
      return Left(
        firebaseExceptionsDecoder(e),
      );
    }
  }
}
