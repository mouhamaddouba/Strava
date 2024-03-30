import 'package:intl/intl.dart';
import 'package:injectable/injectable.dart';
import 'package:steps_tracker/source/features/data/models/user_model.dart';
import 'package:steps_tracker/source/common/values/constants/app_urls.dart';
import 'package:steps_tracker/source/features/data/models/reward_model.dart';
import 'package:steps_tracker/source/features/data/models/exchange_history_model.dart';
import 'package:steps_tracker/source/features/data/models/steps_and_points_model.dart';
import 'package:steps_tracker/source/core/services/firestore_services.dart';

abstract class Database {
  // with Params
  Future<void> setDailySteps(
    StepsAndPointsModel stepsAndPoints,
    String uid,
  );

  Future<void> setRewardOrder(
    RewardModel reward,
    String uid,
  );

  Future<void> setExchangeHistory(
    ExchangeHistoryModel history,
    String uid,
  );

  Stream<List<StepsAndPointsModel>> dailyPointsStream(
    String uid,
    String currentId,
  );

  Future<void> setUserData(
    UserModel user,
  );

  Stream<UserModel> getUserStream(
    String uid,
  );

  Stream<List<RewardModel>> myRewardsStream(
    String uid,
  );

  Stream<List<ExchangeHistoryModel>> exchangeHistoryStream(
    String uid,
  );

  // Without Params
  Stream<List<UserModel>> usersStream();

  Stream<List<RewardModel>> rewardsStream();
}

String documentIdFromLocalGenerator() => DateTime.now().toIso8601String();

String documentIdForDailyUse() => DateFormat.yMMMMd().format(DateTime.now());

@Singleton(as: Database)
class FireStoreDatabase implements Database {
  final _service = FirestoreService.instance;

  @override
  Future<void> setUserData(UserModel user) async {
    await _service.setData(
      path: AppUrls.user(user.uid),
      data: user.toMap(),
    );
  }

  @override
  Future<void> setExchangeHistory(
    ExchangeHistoryModel history,
    String uid,
  ) async {
    await _service.setData(
      path: AppUrls.exchangeHistory(uid, history.id),
      data: history.toMap(),
    );
  }

  @override
  Stream<List<RewardModel>> rewardsStream() {
    return _service.collectionStream(
      path: AppUrls.rewards(),
      builder: (data, documentId) {
        return RewardModel.fromMap(data, documentId);
      },
    );
  }

  @override
  Stream<List<ExchangeHistoryModel>> exchangeHistoryStream(String uid) {
    return _service.collectionStream(
      path: AppUrls.exchangesHistory(uid),
      builder: (data, documentId) {
        return ExchangeHistoryModel.fromMap(data, documentId);
      },
    );
  }

  @override
  Stream<List<StepsAndPointsModel>> dailyPointsStream(
    String uid,
    String currentId,
  ) {
    return _service.collectionStream(
      path: AppUrls.dailyStepsAndPointsStream(uid),
      builder: (data, documentId) {
        return StepsAndPointsModel.fromMap(data, documentId);
      },
      queryBuilder: (query) {
        return query.where(
          'id',
          isNotEqualTo: currentId,
        );
      },
    );
  }

  @override
  Future<void> setDailySteps(
    StepsAndPointsModel stepsAndPoints,
    String uid,
  ) async {
    return _service.setData(
      data: stepsAndPoints.toMap(),
      path: AppUrls.setDailyStepsAndPoints(
        uid,
        stepsAndPoints.id,
      ),
    );
  }

  @override
  Future<void> setRewardOrder(
    RewardModel reward,
    String uid,
  ) async {
    return _service.setData(
      data: reward.toMap(),
      path: AppUrls.setMyReward(
        uid,
        reward.id ?? "",
      ),
    );
  }

  @override
  Stream<List<RewardModel>> myRewardsStream(String uid) {
    return _service.collectionStream(
      path: AppUrls.myRewards(uid),
      builder: (data, documentId) {
        return RewardModel.fromMap(
          data,
          documentId,
        );
      },
    );
  }

  @override
  Stream<List<UserModel>> usersStream() {
    return _service.collectionStream(
      path: AppUrls.users(),
      builder: (data, documentId) {
        return UserModel.fromMap(
          data,
          documentId,
        );
      },
    );
  }

  @override
  Stream<UserModel> getUserStream(String uid) {
    return _service.documentStream(
      path: AppUrls.user(uid),
      builder: (data, documentId) {
        return UserModel.fromMap(
          data,
          documentId,
        );
      },
    );
  }
}
