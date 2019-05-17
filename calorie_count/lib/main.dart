import 'package:calorie_count/src/UI/calorieCalc.dart';
import 'package:calorie_count/src/UI/loginPage.dart';
import 'package:calorie_count/src/UI/rootPage.dart';
import 'package:calorie_count/src/UI/settingPage.dart';
import 'package:flutter/material.dart';
import './src/UI/questionPage.dart';
import './src/UI/dashboardPage.dart';
import './src/UI/cameraPage.dart';
import './src/UI/settingsPage.dart';
import './src/UI/progressPage.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     initialRoute: '/setting',
      routes: <String, WidgetBuilder>{
        '/': (context) => RootPage(),
        '/login': (context) => LogInPage(),
        '/home': (context) => HomePage(cameras),
        '/questionnaire': (context) => QuestionPage(),
        '/results': (context) => CalorieCalc(),
        '/dashboard': (context) => DashboardPage(),
        '/setting': (context) => SettingPage(),
      },
    );
  }//build
}

class HomePage extends StatefulWidget {
  var cameras;
  HomePage(this.cameras);

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
        DashboardPage(),
        CameraPage(widget.cameras),
        ProgressPage(),
        SettingsPage(),
      ],
    )));
  }
}

//class that defines colours
class AppColours {
  final offBlack = const Color(0xFF4C4B4B);
  final coral = const Color(0xFFEA7773);
}

