import 'package:flutter/material.dart';
import 'package:flutter_app/dao/home_dao.dart';
import 'package:flutter_app/model/home_model.dart';
import 'dart:convert';

class MyPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage>{
  final PageController _controller = PageController(
    initialPage: 0,
  );
  String resultString;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("----${resultString}");

   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: RaisedButton.icon(onPressed: (){
          Navigator.pushNamed(context, "test");
        }, icon:Icon(Icons.settings), label: Text('跳转${resultString}')),
      )
    );
  }

}