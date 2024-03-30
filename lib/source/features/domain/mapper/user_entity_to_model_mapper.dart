import 'package:steps_tracker/source/common/storage/database.dart';
import 'package:steps_tracker/source/features/data/models/user_model.dart';
import 'package:steps_tracker/source/features/domain/entities/user_entity.dart';

// convert entity to model mapper
extension UserEntityToModelMapper on UserEntity {
  UserModel toModel() {
    return UserModel(
      uid: uid ?? documentIdFromLocalGenerator(),
      name: name,
    );
  }
}
