import 'package:flutter_qunar/model/search_entity.dart';
import 'package:flutter_qunar/model/home_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "SearchEntity") {
      return SearchEntity.fromJson(json) as T;
    } else if (T.toString() == "HomeEntity") {
      return HomeEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}