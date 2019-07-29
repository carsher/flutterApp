import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
const CATCH_URLS = ['m.ctrip.com/','m.ctrip.com/html5/','m.ctrip.com/html5'];
class WedView extends StatefulWidget{
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;
   WedView({Key key, this.url, this.statusBarColor, this.title, this.hideAppBar, this.backForbid=false, arguments,}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WedViewState();
  }
}

class WedViewState extends State<WedView>{
  final wedviewReference = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError>  _onHttpError;
  bool exiting = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wedviewReference.close();
    _onUrlChanged = wedviewReference.onUrlChanged.listen((String url){
      print("-----${url}");
      if(url.contains("ctrip://")) {
        print("++++${url}");
        wedviewReference.stopLoading();
      }
    });
    _onStateChanged = wedviewReference.onStateChanged.listen((WebViewStateChanged state){
      switch(state.type){
        case WebViewState.shouldStart:
          // TODO: Handle this case.
          break;
        case WebViewState.startLoad:
          // TODO: Handle this case.
        if(_isToMain(state.url)&&!exiting){
          if(widget.backForbid){
            wedviewReference.launch(widget.url);
          }else{
            Navigator.pop(context);
            exiting = true;
          }
        }
          break;
        case WebViewState.finishLoad:
          // TODO: Handle this case.
          break;
        case WebViewState.abortLoad:
          // TODO: Handle this case.
          break;
      }
    });
    _onHttpError = wedviewReference.onHttpError.listen((WebViewHttpError error){
      print(error);
    });
  }

  _isToMain(String url){
    bool contain = false;
    for(final value in CATCH_URLS){
      if(url?.endsWith(value)??false){
        contain = true;
        break;
      }
    }
    return contain;
  }
  @override
  void dispose() {
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    wedviewReference.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonClor;
    if(statusBarColorStr == 'ffffff'){
      backButtonClor = Colors.black;
    }else{
      backButtonClor = Colors.white;
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(Color(int.parse('0xff'+statusBarColorStr)),backButtonClor),
          Expanded(
            child: WebviewScaffold(
              url:widget.url,
              withZoom: true,
              withLocalStorage: true,
              hidden: true,
              initialChild: Container(
                color: Colors.white,
                child: Center(
                  child: Text('Waiting...'),
                ),
              ),
            ),
          )

      ],
      ),
    );
  }

  _appBar(Color backgroundColor,Color backButtonColor){
    if(widget.hideAppBar??false){
      return Container(
        color: backgroundColor,
        height: 20,
      );
    }
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
     child: FractionallySizedBox(
       widthFactor: 1,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 26,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Text(widget.title??'',
                    style: TextStyle(
                      color: backButtonColor,
                      fontSize: 20
                    ),),
              ),
            )
          ],
        ),
     ),
    );
  }
}