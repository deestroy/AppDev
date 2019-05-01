import 'package:calorie_count/src/UI/calorieCalc.dart';
import 'package:flutter/material.dart';
import './src/UI/questionPage.dart';
import './src/UI/dashboardPage.dart';
import './src/UI/cameraPage.dart';
import './src/UI/settingsPage.dart';
import './src/UI/progressPage.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

main() {
  //required; Don't change name
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => LogInScreen(),
        '/home': (context) => HomeScreen(),
        '/questionnaire': (context) => QuestionPage(),
        '/results': (context) => CalorieCalc(),
        '/dashboard': (context) => DashboardPage(),
      },
    );
    
  }
}

//Creates a Google Sign In Account
class LogInScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn() async {
    //signs user into Google
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn(); 
    GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    //signs user into Firebase
    final FirebaseUser user = await _auth.signInWithCredential(credential);

    print("Username: ${user.displayName}");
    return user;
  } // sign in method

  //Signs user out of Google
  void _signOut() {
    googleSignIn.signOut();
    print("User Signed out");
  }

  //creates a Page containing the app name and sign in button
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: AppColours().offBlack,
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'APP NAME',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.all(100.0),
            ),
            RaisedButton(
              onPressed: () {
                _signIn()
                  .then((FirebaseUser user) => print(user)) //prints user information
                  .catchError((e) => print(e));
                Navigator.pushNamed(context, '/questionnaire');
              },
              child: new Text("Sign In"),
            ),
            Padding (padding: EdgeInsets.all(10.0),),
            RaisedButton(
              onPressed: () {
                 _signOut();
              },
              child: new Text("Sign Out"),
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
  // List<Widget> myPage = [
  //   CameraPage(),
  //   DashboardPage(),
  //   ProgressPage(),
  //   SettingsPage(),
  //   QuestionPage()
  // ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: new Scaffold(
            body: PageView(
      children: <Widget>[
        CameraPage(),
        DashboardPage(),
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