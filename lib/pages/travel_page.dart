import 'package:flutter/material.dart';

class TravelPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage>{
  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Text('旅拍'),
      )
    );
  }

}