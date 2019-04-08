import 'package:flutter/material.dart';
import './src/UI/questionPage.dart';
import './src/UI/dashboardPage.dart';
import './src/UI/cameraPage.dart';
import './src/UI/settingsPage.dart';
import './src/UI/progressPage.dart';

main() {
  //required; Don't change name
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen()
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  List<Widget> myPage = [CameraPage(),DashboardPage(), ProgressPage(), SettingsPage(),QuestionPage()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      home: new Scaffold(
        body: PageView(
          children: <Widget>[
            QuestionPage(),
            CameraPage(),
            DashboardPage(), 
            ProgressPage(), 
         //   SettingsPage(),
            
        ],
        )
      )
    );
  }
}
