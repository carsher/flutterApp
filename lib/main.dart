import 'package:flutter/material.dart';
import 'package:flutter_app/routes/route.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'navigator/tab_navigator.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh',"CH"),
        const Locale('en','US'),
      ],
      title: 'flutter_app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: onGenerateRoute,
      initialRoute: '/'     //初始化路由
    );
  }
}
