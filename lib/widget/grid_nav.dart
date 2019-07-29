import 'package:flutter/material.dart';
import 'package:flutter_app/model/common_model.dart';
import 'package:flutter_app/model/grid_nav_model.dart';
import 'package:flutter_app/widget/wedview.dart';

class GridNav extends StatelessWidget{
  final GridNavModel gridNavModel;
  final String name;
  const GridNav({Key key, @required this.gridNavModel,this.name='xiaoxiao'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: _gridNavItems(context),
      ),
    );
  }
  _gridNavItems(BuildContext context){
    List<Widget> items = [];
    if(gridNavModel==null)return items;
    if(gridNavModel.hotel!=null){
      items.add(_gridNavItem(context,gridNavModel.hotel,true));
    }
    if(gridNavModel.flight!=null){
      items.add(_gridNavItem(context,gridNavModel.flight,false));
    }
    if(gridNavModel.travel!=null){
      items.add(_gridNavItem(context,gridNavModel.travel,false));
    }
    return items;
  }
  _gridNavItem(BuildContext context,GridNavItem gridnavItem,bool first){
    List<Widget> items = [];
    items.add(_mainItem(context, gridnavItem));
    items.add(_doubleItem(context, gridnavItem.item1,gridnavItem.item2,false));
    items.add(_doubleItem(context, gridnavItem.item3,gridnavItem.item4,false));
    List<Widget> exandItems = [];
    items.forEach((item){
      exandItems.add(Expanded(child: item,flex: 1,));
    });
    Color startColor = Color(int.parse('0xff'+gridnavItem.startColor));
    Color endColor = Color(int.parse('0xff'+gridnavItem.endColor));
    return Container(
      height: 88,
      margin: first?null:EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        //线性渐变
        gradient: LinearGradient(colors: [startColor,endColor])
      ),
      child: Row(
        children: exandItems,
      ),
    );

  }
  _mainItem(BuildContext context,GridNavItem  model){
    return GestureDetector(
       onTap: (){
         Navigator.push(context,MaterialPageRoute(builder: (context){
           print(model.mainItem.title);
           return WedView(url:model.mainItem.url,statusBarColor:model.mainItem.statusBarColor,hideAppBar:false,
              title: model.mainItem.title,
           );
         }));
       },
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Image.network(model.mainItem.icon,
          fit: BoxFit.contain,
          height: 88,
          width: 121,
          alignment: AlignmentDirectional.bottomEnd,
          ),
         Container(
           margin: EdgeInsets.only(top: 12),
           child: Text(
             model.mainItem.title,
             style: TextStyle(
               fontSize: 14,
               color: Colors.white,
             ),
           ),
         )
        ],
      ),
    );
  }
  _doubleItem(BuildContext context,Item topItem,Item bottomItem,bool iscenterItem){
    return Column(
      children: <Widget>[
        Expanded(
          child: _item(context,topItem,true,iscenterItem),
        ),
        Expanded(
          child: _item(context,bottomItem,false,iscenterItem),
        )
      ],
    );
  }
  _item(BuildContext context,Item item,bool first,bool iscenterItem){
    BorderSide borderSide = BorderSide(width: 0.0,color: Colors.white);
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: borderSide,
            bottom: first?borderSide:BorderSide.none,

          )
        ),
        child: Center(
          child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return WedView(url: item.url,
                statusBarColor: item.statusBarColor,
                hideAppBar: false,
                title: item.title,
              );
            }));
          },
            child: Text(item.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white
              ),),
          )
        ),
    ));
  }
  _wrapGesture(BuildContext context,Widget widget,Item model){
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context){
          print(model.title);
          return WedView(url:model.url,statusBarColor:model.statusBarColor,hideAppBar:false,
            title: model.title,
          );
        }));
      },
    );
  }
}