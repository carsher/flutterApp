import 'package:flutter/material.dart';
//加载进度条
class LoadingContainer extends StatelessWidget{
final Widget chile;
final bool isLoading;
final bool cover;

   LoadingContainer({Key key, @required this.chile,@required this.isLoading, this.cover=false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return !cover?!isLoading?chile:_loadView:Stack(
      children: <Widget>[
        chile,
        isLoading?_loadView:null
      ],
    );
  }

  Widget get _loadView{
    return Center(
      child: CircularProgressIndicator(),
    );
  }

}