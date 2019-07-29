import 'package:flutter/material.dart';
import 'package:flutter_app/dao/search_dao.dart';
import 'package:flutter_app/model/seach_model.dart';
import 'package:flutter_app/pages/speak_page.dart';
import 'package:flutter_app/widget/search_bar.dart';
import 'package:flutter_app/widget/wedview.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';

const URL = 'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';
class SearchPage extends StatefulWidget{
  final bool hideLeft;
  final String searchUrl;
  final String keyword;
  final String hint;

  const SearchPage({Key key, this.hideLeft, this.searchUrl=URL, this.keyword, this.hint}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>{
  String keyword;
  SearchModel searchModel;
  @override
  void initState() {
    // TODO: implement initState
    if(widget.keyword!=null){
      _onTextChange(widget.keyword);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: <Widget>[
          _appBar(context),
          MediaQuery.removePadding(
              context: context,
              removeTop:true,
              child: Expanded(
            flex: 1,
            child: ListView.builder(itemCount:searchModel?.data?.length??0,itemBuilder: (BuildContext context,int positon){
              return _item(context,positon);
            }),
          )
          )
        ],
      )
    );
  }
  _onTextChange(String text){
    keyword = text;
    if(text.length==0){
      setState(() {
        searchModel = null;
      });
      return;
    }
    String url = widget.searchUrl+text;
    print(url);
    SearchDao .fetch(url,text).then((SearchModel model){
      if(model.keyword==keyword){
        setState(() {
          searchModel = model;
        });
      }//if
    }).catchError((e){
      print("searchError=${e}");
    });
  }
    _appBar(BuildContext context){
   return Column(
     children: <Widget>[
       Container(
         decoration: BoxDecoration(
           gradient: LinearGradient(colors: [
             Color(0x66000000),Colors.transparent],
           begin: Alignment.topCenter,
           end: Alignment.bottomCenter
           )
         ),
         child: Container(
           padding: EdgeInsets.only(top: 20),
           height: 80,
           decoration: BoxDecoration(
             color: Colors.white),
           child: SearchBar(
             hideLeft: widget.hideLeft,
             defaultText: widget.keyword,
             hint: widget.hint,
             speakButtonClick: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=>
                   SpeakPage()));

             },
             leftButtonClick: (){
              Navigator.of(context).pop();
             },
             onChanged: _onTextChange,
           ),
         ),
       ),
     ],
   );
  }
  _item(BuildContext context,int positon){
    if(searchModel == null||searchModel.data==null){
      return null;
    }
    SearchItem item = searchModel.data[positon];
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
            WedView(url:item.url,title: '详情')));
      },
      child: Container(
        padding:EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.3,color: Colors.grey))
        ),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(1),
              child: Icon(Icons.add,size: 26,),
            ),
            Column(
              children: <Widget>[
                Container(width: 300, child: _title(item)),
                Container(width: 300, margin: EdgeInsets.only(top: 5), child:subTitle(item))
              ],
            )
          ],
        ),
      ),
    );
  }
//Text('${item.word??''} ${item.districtname??''} ${item.zonename??''}'),
  // Text('${item.price??''} ${item.type??''}')
  _title(SearchItem item) {
    if(item ==null){
      return null;
    }
    List<TextSpan> spans =[];
    spans.addAll(keyWordTextSpans(item.word,searchModel.keyword));
    spans.add(TextSpan(text: ' '+(item.districtname??'')+' '+(item.zonename??''),
                style: TextStyle(fontSize: 16,color: Colors.grey)));
    return RichText(text: TextSpan(
      children: spans,
    ),);
  }

  subTitle(SearchItem item) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(text: item.price??'',style: TextStyle(fontSize: 14,color: Colors.orange)),
          TextSpan(text: ' '+(item.star??''),style: TextStyle(fontSize: 12,color: Colors.grey)),
        ]
      ),
    );
  }

   keyWordTextSpans(String word, String keyword) {
    List<TextSpan> spans =[];
    if(keyword==null||keyword.length==0)return null;
    List<String> arr = word.split(keyword);
    TextStyle normalStyle = TextStyle(fontSize: 16,color: Colors.black38);
    TextStyle keyWordStyle = TextStyle(fontSize: 16,color: Colors.orange);
    for(int i=0;i<arr.length;i++){
      if((i+1)%2==0){
        spans.add(TextSpan(text: keyword,style: keyWordStyle));
      }
      String value= arr[i];
      if(value!=null&&value.length>0){
        spans.add(TextSpan(text: keyword,style: normalStyle));
      }
    }
    return spans;
  }

  jumpToSpeak(BuildContext context) {
//    Navigator.push(context, MaterialPageRoute(builder: (context)=>
//        SpeakPage()));

  }
}