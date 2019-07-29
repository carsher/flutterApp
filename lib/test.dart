import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';




class HttpTestRoute extends StatefulWidget {

  @override

  _HttpTestRouteState createState() => _HttpTestRouteState();

}



class _HttpTestRouteState extends State<HttpTestRoute> {

  bool _loading = false;

  String _text = "";



  @override

  Widget build(BuildContext context) {

    return ConstrainedBox(

      constraints: BoxConstraints.expand(),

      child: SingleChildScrollView(

        child: Column(

          children: <Widget>[

            RaisedButton(

                child: Text("获取慕课网首页"),

                onPressed: _loading

                    ? null

                    : () async {

                  setState(() {

                    _loading = true;

                    _text = "正在请求中，请稍后……";

                  });

                  try {

                    //创建一个HttpClient

                    HttpClient httpClient=new HttpClient();

                    //打开Http连接

                    HttpClientRequest request=await httpClient.getUrl(Uri.parse("http://gank.io/api/data/Android/10/1"));

                    //使用UA:安卓请参考https://www.jianshu.com/p/198777a7feba这篇文章获取user-agent

                    request.headers.add("user-agent", "");

                    //等待连接服务器，会将请求信息发送给服务器

                    HttpClientResponse response=await request.close();

                    //读取响应内容

                    _text=await response.transform(utf8.decoder).join();

                    //输出响应头

                    print(response.headers);



                    //关闭client后，通过该client发起的所有请求都会中止

                    httpClient.close();

                  } catch (e) {

                    _text = "请求失败：$e";

                  } finally {

                    setState(() {

                      _loading = false;

                    });

                  }

                }),

            Container(

              width: MediaQuery.of(context).size.width - 50.0,

              child: Text(_text.replaceAll(new RegExp(r"\s"), "")),

            )

          ],

        ),

      ),

    );

  }

}
