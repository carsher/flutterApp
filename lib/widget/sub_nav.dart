import 'package:flutter/material.dart';
import 'package:flutter_app/model/common_model.dart';
import 'package:flutter_app/model/grid_nav_model.dart';
import 'package:flutter_app/widget/wedview.dart';

class SubNav extends StatelessWidget{
  final List<CommonModel> SubNavList;
  final String name;
  const SubNav({Key key, @required this.SubNavList,this.name='xiaoxiao'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(padding: EdgeInsets.all(7),
          child: _items(context)
    ),
    );
  }

  _items(BuildContext context){
    if(SubNavList == null) return null;
    List<Widget> items = [];
    SubNavList.forEach((model){
      items.add(_item(context,model));
    });
    //计算出第一行显示的数量
    int separate = (SubNavList.length/2+0.5).toInt();
    return Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(0,separate),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: items.sublist(separate,SubNavList.length),
            ),
          )
        ],
    );
  }
  Widget _item(BuildContext context,CommonModel model){
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: (){
          Navigator.push(context,MaterialPageRoute(builder: (context){
            print(model.url);
            return WedView(url:model.url,statusBarColor:model.statusBarColor,hideAppBar:model.hideAppBar);
          }));
        },
        child: Column(
          children: <Widget>[
            Image.network(model.icon,
              width:18,
              height: 18,),
            Padding(
              padding: EdgeInsets.only(top: 3),
              child: Text(
                model.title,
                style: TextStyle(
                    fontSize: 12
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}