import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_app/pages/my_page.dart';
import 'package:flutter_app/pages/search_page.dart';
import 'package:flutter_app/pages/travel_page.dart';

class TabNavigator extends StatefulWidget{
  Map arguments;
  TabNavigator({Key key,this.arguments}):super(key : key);
  @override
  State<StatefulWidget> createState() => _TabNavigatorPages(arguments:this.arguments);
}

class _TabNavigatorPages extends State<TabNavigator>{
  final Map arguments;
  _TabNavigatorPages({this.arguments});
  final PageController _controller = PageController(
    initialPage: 0,
  );
  final _defaultColor = Colors.grey;
  final _actionColor = Colors.blue;
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
      controller: _controller,
      onPageChanged: (index){
        setState(() {
          _currentIndex = index;
        });
      },
      children: <Widget>[
        HomePage(),
        SearchPage(hideLeft:true),
        TravelPage(),
        MyPage(),
      ],
    ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index){
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
        BottomNavigationBarItem(
          icon: Icon(
              Icons.home,
              color: _defaultColor,),
          activeIcon: Icon( Icons.home,
            color: _actionColor,),
          title: Text('首页',style: TextStyle(
            color: _currentIndex != 0 ? _defaultColor : _actionColor
          ),)
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: _defaultColor,),
            activeIcon: Icon( Icons.search,
              color: _actionColor,),
            title: Text('搜索',style: TextStyle(
                color: _currentIndex != 1 ? _defaultColor : _actionColor
            ),)
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.camera_alt,
              color: _defaultColor,),
            activeIcon: Icon( Icons.camera_alt,
              color: _actionColor,),
            title: Text('旅拍',style: TextStyle(
                color: _currentIndex != 2 ? _defaultColor : _actionColor
            ),)
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: _defaultColor,),
            activeIcon: Icon( Icons.account_circle,
              color: _actionColor,),
            title: Text('我的',style: TextStyle(
                color: _currentIndex != 3 ? _defaultColor : _actionColor
            ),)
        )
      ]),
    );
  }

}