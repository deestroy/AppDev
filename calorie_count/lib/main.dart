import 'package:calorie_count/src/UI/calorieCalc.dart';
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
      initialRoute: '/',
      routes: <String, WidgetBuilder> {
        '/': (context) => LogInScreen(),
        '/home': (context) => HomeScreen(),
        '/questionnaire' : (context) => QuestionPage(),
        'results': (context) => CalorieCalc(),
        '/dashboard': (context) => DashboardPage(),
        
      },
    );
  }
}

class LogInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold (
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new RaisedButton(
              onPressed: () {Navigator.pushNamed(context, '/questionnaire');},
              child: new Text("Sign In"),
              color: Colors.green,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              
              child: new Text("Sign out"),
              color: Colors.red,
            ),
          ],
        ),
      ),
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
            CameraPage(),
            DashboardPage(), 
            ProgressPage(), 
            SettingsPage(),
        ],
        )
      )
    );
  }
}
