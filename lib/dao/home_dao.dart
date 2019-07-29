import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/model/home_model.dart';
import 'package:http/http.dart' as http;
const HOME_URL = 'http://www.devio.org/io/flutter_app/json/home_page.json';
//Shouye
class HomeDao{
  static Future<HomeModel> fetch() async{
    final response = await http.get(HOME_URL);
    if(response.statusCode == 200){
      Utf8Decoder utf8decoder = Utf8Decoder();//修补中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    }else{
      throw Exception('Failed to load home_page.json!');
    }
  }
}