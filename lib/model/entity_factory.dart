import 'package:flutter_qunar/model/home_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    switch (T.toString()) {
      case 'HomeEntity':
        return HomeEntity.fromJson(json) as T;
      default:
        return null;
    }
  }
}
