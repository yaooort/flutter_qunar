import 'dart:convert';
import 'package:flutter_qunar/model/entity_factory.dart';
import 'package:flutter_qunar/model/home_entity.dart';
import 'package:http/http.dart' as http;

const HOME_URL = 'http://www.devio.org/io/flutter_app/json/home_page.json';

///首页大接口
class HomeDao {
  static Future<HomeEntity> fetch() async {
    final response = await http.get(HOME_URL);
    if (response.statusCode == 200) {
      var jsonObj = json.decode(utf8.decode(response.bodyBytes));
      return EntityFactory.generateOBJ<HomeEntity>(jsonObj);
    } else {
      throw Exception('请求失败');
    }
  }
}
