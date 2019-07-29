import 'package:flutter/material.dart';
import 'package:flutter_app/dao/home_dao.dart';
import 'package:flutter_app/model/common_model.dart';
import 'package:flutter_app/model/grid_nav_model.dart';
import 'package:flutter_app/model/home_model.dart';
import 'package:flutter_app/model/sales_box_model.dart';
import 'package:flutter_app/pages/search_page.dart';
import 'package:flutter_app/pages/speak_page.dart';
import 'package:flutter_app/widget/grid_nav.dart';
import 'package:flutter_app/widget/loading_container.dart';
import 'package:flutter_app/widget/local_nav.dart';
import 'package:flutter_app/widget/sales_nav.dart';
import 'package:flutter_app/widget/search_bar.dart';
import 'package:flutter_app/widget/sub_nav.dart';
import 'package:flutter_app/widget/wedview.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
//tunypng压缩图片
const APPBAR_SCROLL_OFFSET = 100;
const SEARCH_BAR_DEFAULA_TEXT="搜索";
class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  List _imgeUrls = [
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1563190657379&di=e7c73d50b245d26fc742f751b231d392&imgtype=0&src=http%3A%2F%2Fpic37.nipic.com%2F20140113%2F8800276_184927469000_2.png',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1563190822718&di=103626c3157dec58dac45b0df8af46e7&imgtype=0&src=http%3A%2F%2Fpic25.nipic.com%2F20121205%2F10197997_003647426000_2.jpg',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1563190822718&di=103626c3157dec58dac45b0df8af46e7&imgtype=0&src=http%3A%2F%2Fpic25.nipic.com%2F20121205%2F10197997_003647426000_2.jpg'
  ];
  double appBarAlpha =0;
  String resultString;
  List<CommonModel> localNavList = [];
  List<CommonModel> subNavList = [];
  List<CommonModel> bannerNavList=[];
  GridNavModel gridNavList;
  SalesBoxModel salesNavList;
  bool _loading = true;

  void _onScroll(double pixels) {
    double alpha = pixels/APPBAR_SCROLL_OFFSET;
    if(alpha<0){
      alpha = 0;
    }else if (alpha>1){
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }

  @override
  void initState() {
    super.initState();
    _handleRefest();

  }
//  loadData(){
//    var na = 1;
//    HomeDao.fetch().then((result){
//      na = na+1;
//      setState(() {
//        resultString = json.encode(result);
//        print("11=${resultString}");
//      });
//    }).catchError((e){
//      na=na+10;
//      setState(() {
//        resultString = e.toString();
//        print("222=${resultString}");
//
//      });
//    });
//    return na;
//  }


  //第二种方法获取
 Future<Null> _handleRefest() async{
  try{
    HomeModel model = await HomeDao.fetch();
   setState((){
     localNavList = model.localNavList;
     gridNavList = model.gridNav;
     subNavList = model.subNavList;
     salesNavList = model.salsBox;
     bannerNavList = model.bannerList;
     _loading = false;

   });
   }catch(e){
   setState(() {
         resultString = e.toString();
          print('加载数据失败:${e}');
         _loading = false;
   });
   }
   return null;
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: LoadingContainer(isLoading:_loading,
      chile: Stack(
      children: <Widget>[
      MediaQuery.removePadding(context: context,
      removeTop: true,
      child:RefreshIndicator(
        onRefresh: _handleRefest,
        child:  NotificationListener(
        onNotification: (scrollNotification){
          if(scrollNotification is ScrollUpdateNotification && scrollNotification.depth==0){//滚动&是列表滚动的时候&是Listview滚动
            _onScroll(scrollNotification.metrics.pixels);
          }
        },
        child:  ListView(
          children: <Widget>[
            Container(
              height: 160,
              child: _Swipter,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
              child:LocalNav(localNavList:this.localNavList),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
              child:GridNav(gridNavModel:gridNavList),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
              child:SubNav(SubNavList:subNavList),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
              child: SalesBox_Nav(salesNavList:salesNavList),
            ),

          ],
        ),
      ),
      )
    ),
      _appbar
    ],
    )),
    );
  }
  Widget get _Swipter{
    return new Swiper(
      itemCount: bannerNavList.length,
      autoplay: true,
      itemBuilder: (BuildContext context,int index){
        return GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              CommonModel model = bannerNavList[index];
              return WedView(
                url: model.url,
                title: model.title,
                hideAppBar: model.hideAppBar,
              );
            }));
          },
          child: Image.network(
            bannerNavList[index].icon,
            fit: BoxFit.fill,
          ),
        );
      },
      pagination: new SwiperPagination(),//轮播点
    );
  }
  Widget get _appbar{
//    return Opacity(
//      opacity: appBarAlpha,
//      child: Container(
//        height: 80,
//        decoration: BoxDecoration(
//          color: Colors.white,
//        ),
//        child: Center(
//          child: Padding(
//            padding: EdgeInsets.only(top: 20),
//            child: Text('首页'),),
//        ),
//      ),
//    );
  return Column(
    children: <Widget>[
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors:
          [Color(0x66000000),Colors.transparent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter)
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          height: 80.0,
          decoration: BoxDecoration(
            color: Color.fromARGB((appBarAlpha*255).toInt(), 255, 255, 255),
          ),
          child:  SearchBar(
            searchBarType: appBarAlpha>0.2?SearchBarType.homeLight:SearchBarType.home,
            inputButtonClick: _jumpToSearch,
            speakButtonClick: _jumpToSpeak,
            defaultText: SEARCH_BAR_DEFAULA_TEXT,
            leftButtonClick: (){

            },
          ),
        ),
      ),
      Container(
        height: appBarAlpha>0.2?0.5:0,
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 0.5)],
        ),
      )
    ],
  );
  }
  _jumpToSearch(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>
        SearchPage(hint: SEARCH_BAR_DEFAULA_TEXT,)));

  }
  _jumpToSpeak(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>
        SpeakPage()));

  }
}