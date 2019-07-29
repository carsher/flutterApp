import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/model/home_model.dart';
import 'package:flutter_app/model/seach_model.dart';
import 'package:http/http.dart' as http;
//Shouye
class SearchDao{
  static Future<SearchModel> fetch(String url,String text) async{
    final response = await http.get(url);
    if(response.statusCode == 200){
      Utf8Decoder utf8decoder = Utf8Decoder();//修补中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      SearchModel model =SearchModel.fromJson(result);
      model.keyword = text;
      return model;
    }else{
      throw Exception('Failed to load home_page.json!!!');
    }
  }
}