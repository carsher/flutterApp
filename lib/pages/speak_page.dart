import 'package:flutter/material.dart';
import 'package:flutter_app/pages/search_page.dart';
import 'package:flutter_app/plugin/asr_manager.dart';
const double MIC_SIZE = 80;
class SpeakPage extends StatefulWidget{
  @override
  _SpeakPageState createState() {
    // TODO: implement createState
    return _SpeakPageState();
  }
}

class _SpeakPageState extends State<SpeakPage> with SingleTickerProviderStateMixin{
   String SPEAKTIPS = '长按说话';
   String SPEAKRESULT = '';
   Animation<double> animation;
   AnimationController controller;
   @override
  void initState() {
     super.initState();
     controller = AnimationController(vsync: this,duration: Duration(milliseconds: 1000));
     animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
       ..addStatusListener((status){
         if(status == AnimationStatus.completed){
           controller.reverse();
         }else if(status == AnimationStatus.dismissed){
           controller.forward();
         }
       });

  }
  @override
  void dispose() {
     controller.dispose();
     super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _topItem(),
              _bottomItem()
            ],
          ),
        ),
      ),
    );
  }
   _topItem(){
     return Column(
       children: <Widget>[
         Padding(
           padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
           child: Text('你可以这样说',style: TextStyle(
             fontSize: 16,
             color: Colors.black54
           ),)),
         Text('故宫门票\n北京一日游\n迪士尼乐园',style: TextStyle(
             fontSize: 15,
             color: Colors.grey
         ),),
         Padding(
           padding: EdgeInsets.all(20),
           child: Text(
             SPEAKRESULT,
             style: TextStyle(
                 fontSize: 15,
                 color: Colors.blue
             ),
           ),
         )
       ],
     );
   }
  _bottomItem(){
    return FractionallySizedBox(
      widthFactor: 1,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTapDown: (e){
              _speakStart();
            },
            onTapUp: (e){
              _speakStop();
            },
            onTapCancel: (){
              _speakStop();
            },
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(SPEAKTIPS,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 12
                    ),),
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                        height: MIC_SIZE,
                        width: MIC_SIZE,
                      ),
                      Center(
                        child: Animated(animation: animation,),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 20,
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.close,
                  size: 30,
                  color: Colors.grey,),
            ),
          )
        ],
      ),
    );
  }

  _speakStart(){
     controller.forward();
     setState(() {
       SPEAKTIPS = '-识别中-';
     });
     AsrManager.start().then((text){
       if(text!=null&&text.length!=0){
         print('----${text}');
         setState(() {
           SPEAKRESULT = text;
         });
         Navigator.pop(context);
         Navigator.push(context, MaterialPageRoute(builder: (context){
           SearchPage(keyword: SPEAKRESULT,);
         }));
       }
     }).catchError((e){
       print('err:${e.toString()}');
     });
  }
  _speakStop(){
    setState(() {
      SPEAKTIPS = '长按说话';
    });
     controller.reset();
     controller.stop();
     AsrManager.stop();
  }
  _speakCancle(){

  }
}

class Animated extends AnimatedWidget{
  static final _opactionTween = Tween<double>(begin: 1,end: 0.5);
  static final _sizeTween = Tween<double>(begin: MIC_SIZE,end: MIC_SIZE-20);
  Animated({Key key,Animation<double> animation}):super(key:key,listenable:animation);
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Opacity(
      opacity: _opactionTween.evaluate(animation),
      child: Container(
        height: _sizeTween.evaluate(animation),
        width: _sizeTween.evaluate(animation),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(MIC_SIZE/2)
        ),
        child: Icon(
          Icons.mic,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

}