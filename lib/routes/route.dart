import 'package:flutter/material.dart';
import 'package:flutter_app/navigator/tab_navigator.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_app/test.dart';
import 'package:flutter_app/widget/wedview.dart';

//配置路由
final routes = {
  '/': (context,{arguments}) =>TabNavigator(),
  '/home':(context)=>HomePage(),
  'test': (context) => HttpTestRoute(),
  'wedview':(context,{arguments}) => WedView(arguments:arguments),
};

var onGenerateRoute = (RouteSettings settings){
  //统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if(pageContentBuilder !=null){
    if(settings.arguments !=null){
      final Route route = MaterialPageRoute(
          builder: (context)=>
              pageContentBuilder(context,arguments:settings.arguments));
      return route;
    }else{
      final Route route = MaterialPageRoute(
          builder: (context)=>
      pageContentBuilder(context));
      return route;
    }
  }
};
