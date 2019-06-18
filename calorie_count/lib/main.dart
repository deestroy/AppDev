import 'dart:async';
import 'package:calorie_count/src/UI/calorieCalc.dart';
import 'package:calorie_count/src/UI/editQuesitonPage.dart';
import 'package:calorie_count/src/UI/loginPage.dart';
import 'package:calorie_count/src/UI/manualEntryPage.dart';
import 'package:calorie_count/src/UI/rootPage.dart';
import 'package:calorie_count/src/UI/settingPage.dart';
import 'package:flutter/material.dart';
import './src/UI/questionPage.dart';
import './src/UI/dashboardPage.dart';
import './src/UI/cameraPage.dart';
import './src/UI/progressPage.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final firstCamera = cameras.first;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (context) => RootPage(),
          '/login': (context) => LogInPage(),
          '/home': (context) => HomePage(camera: firstCamera),
          '/questionnaire': (context) => QuestionPage(),
          '/results': (context) => CalorieCalc(),
          '/dashboard': (context) => DashboardPage(),
          '/setting': (context) => SettingPage(),
          '/edit': (context) => EditQuestionnaire(),
          '/manual': (context) => ManualEntry(),
        },
        onUnknownRoute: (RouteSettings setting) {
          print("Unknown route");
          return new MaterialPageRoute(
              builder: (context) => LogInPage());
        });
  } //build
}

class HomePage extends StatefulWidget {
  final CameraDescription camera;

  const HomePage({
    Key key,
    @required this.camera
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: new Scaffold(
            body: PageView(
      children: <Widget>[
        CameraPage(camera: widget.camera),
        DashboardPage(),
      //  ProgressPage(),
      ],
    )));
  }
}

class AppColours {
  final offBlack = const Color(0xFF4C4B4B);
  final coral = const Color(0xFFEA7773);
}

class Food {
  String foodName, unit;
  int calories, servingSize;

  Food({this.foodName, this.calories, this.servingSize, this.unit});
}

