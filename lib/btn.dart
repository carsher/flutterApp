import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
class btn extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _btnState();
  }

}

class _btnState extends State {
  DateTime nowTime = DateTime.now();
  _DatePickDemo() async{
//    showDatePicker(
//        context: context,
//        initialDate: nowTime,
//        firstDate: DateTime(1980),
//        lastDate: DateTime(2100)).then((value){
//          print(value);
//    });

  var result = await showDatePicker(
        context: context,
        initialDate: nowTime,
        firstDate: DateTime(1980),
        lastDate: DateTime(2100),
        locale: Locale('zh')
  );
  }
  @override
  Widget build(BuildContext context) {
    var nes = DateTime.now();
    print(DateTime.fromMicrosecondsSinceEpoch(nes.millisecondsSinceEpoch));
    print(formatDate(DateTime.now(), [yyyy, '年', mm, '月', dd]));
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("btn"),
      ),
      floatingActionButton: Container(
        height: 100.0,
        width: double.infinity ,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.amberAccent,
        ),
        child: FloatingActionButton(onPressed: (){},child: Icon(Icons.send),
         ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),

            RaisedButton(child: Text("跳转"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: (){
                Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                  return btn();
                }));
              },),
            Row(
              children: <Widget>[
                RaisedButton.icon(onPressed: (){}, icon: Icon(Icons.search),
                    shape:CircleBorder(side: BorderSide(color: Colors.white)),
                    splashColor: Colors.grey,
                    label: Text('图标按钮')),
                SizedBox(width: 5,),
                Divider(
                  color: Colors.grey,
                )

              ],
            )

          ],
        ),
      ),
    );
  }
}
