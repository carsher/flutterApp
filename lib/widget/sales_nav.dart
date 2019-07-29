import 'package:flutter/material.dart';
import 'package:flutter_app/model/common_model.dart';
import 'package:flutter_app/model/grid_nav_model.dart';
import 'package:flutter_app/model/sales_box_model.dart';
import 'package:flutter_app/widget/wedview.dart';

class SalesBox_Nav extends StatelessWidget{
  final SalesBoxModel salesNavList;
  final String name;
  const SalesBox_Nav({Key key, @required this.salesNavList,this.name='xiaoxiao'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
        child: _items(context)
    );
  }

  _items(BuildContext context){
    if(salesNavList == null) return null;
    List<Widget> items = [];
    items.add(_doubleItem(context,salesNavList.bigCart1,salesNavList.bigCart2,true,false));
    items.add(_doubleItem(context,salesNavList.smallCart1,salesNavList.smallCart2,false,false));
    items.add(_doubleItem(context,salesNavList.smallCart3,salesNavList.smallCart4,false,true));
    return Column(
        children: <Widget>[
         Container(
           height: 44,
           margin: EdgeInsets.only(left: 10),
           child:  Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: <Widget>[
               Image.network(
                 salesNavList.icon,
                 height: 15,
                 fit: BoxFit.fill,
               ),
               Container(
                 padding: EdgeInsets.fromLTRB(10, 1, 8, 1),
                 margin: EdgeInsets.only(right: 7),
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(12),
                     gradient: LinearGradient(colors: [
                       Color(0xffff4e63,),Color(0xffff6cc9)
                     ],begin: Alignment.centerLeft,end: Alignment.centerRight),
                 ),
                 child: GestureDetector(
                   onTap: (){
                     Navigator.push(context,MaterialPageRoute(builder: (context){
                       return WedView(url:salesNavList.moreUrl,title: '更多活动',);
                     }));},
                   child: Text(
                     '获取更多福利',
                     style: TextStyle(
                       color: Colors.white,fontSize: 12
                     ),
                   ),
                 ),
               ),
             ],
           ),
           decoration: BoxDecoration(
             border: Border(bottom: BorderSide(width: 1,color: Color(0xfff2f2f2))),
           ),
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: items.sublist(0,1),
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: items.sublist(1,2),
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: items.sublist(2,3),
         )
        ],
    );
  }
  Widget _doubleItem(BuildContext context,CommonModel leftmodel,CommonModel rightmodel,bool big,bool last){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _item(context,leftmodel,big,true,last),
        _item(context,rightmodel,big,false,last),
      ],
    );
  }

  Widget _item(BuildContext context,CommonModel model,bool big,bool left,bool last){
    BorderSide borderSize = BorderSide(width: 0.8,color: Color(0xfff2f2f2));
    return GestureDetector(
        onTap: (){
          Navigator.push(context,MaterialPageRoute(builder: (context){
            print(model.url);
            return WedView(url:model.url,statusBarColor:model.statusBarColor,hideAppBar:model.hideAppBar);
          }));
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(right: left? borderSize:BorderSide.none,
                bottom: last?BorderSide.none:borderSize)
          ),
          child: Image.network(model.icon,
            fit: BoxFit.fill,
            width:MediaQuery.of(context).size.width/2-10,
            height: big?129:80,
          ),
        )
      );
  }
}