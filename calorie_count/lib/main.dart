import 'package:flutter/material.dart';

main() {
  //required; Don't change name
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //imported from the package
  @override
  Widget build(BuildContext context) {
    //build method; context-- contains meta info about app (theme)
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('CalorPic'),
        ),
        body: Card(child: Column(children: <Widget>[
          Image.asset('assets/food.jpg'),
          Text('Food')
        ],),),
      ),
    );
    /* core root widget(constructor). In every flutter project "draws" to the app
    Scaffold = white background*/
  }
}
