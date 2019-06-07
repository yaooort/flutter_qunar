import 'dart:convert';
import 'package:flutter_qunar/entity_factory.dart';
import 'package:flutter_qunar/model/search_entity.dart';
import 'package:http/http.dart' as http;


///搜索接口
class SearchDao {
  static Future<SearchEntity> fetch(String url,String keyword) async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonObj = json.decode(utf8.decode(response.bodyBytes));
      SearchEntity entity = EntityFactory.generateOBJ<SearchEntity>(jsonObj);
      entity.keyword = keyword;
      return entity;
    } else {
      throw Exception('请求失败');
    }
  }
}
