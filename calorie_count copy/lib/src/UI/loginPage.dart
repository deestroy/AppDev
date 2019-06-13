import 'package:calorie_count/auth.dart';
import 'package:calorie_count/main.dart';
import 'package:flutter/material.dart';


class LogInPage extends StatelessWidget {
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
              'CALORIE COUNTER',
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
               authService.signIn();
              },
              child: new Text("Sign In"),
            ),
            Padding (padding: EdgeInsets.all(10.0),),
            RaisedButton(
              onPressed: () {
                 authService.signOut();
              },
              child: new Text("Sign Out"),
            ),
          ],
        ),
      ),
    );
  }
}