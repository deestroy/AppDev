import 'dart:math';
import 'package:calorie_count/auth.dart';
import 'package:calorie_count/main.dart';
import 'package:flutter/material.dart';

class LogInPage extends StatelessWidget {
  //creates a Page containing the app name and sign in button
  var randomNum = Random().nextInt(4);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/pic3.JPG"),
                fit: BoxFit.cover)),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //colouredText(),
            Text(
              'CALORIE COUNT',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.all(140.0),
            ),
            Container(
              margin: EdgeInsets.all(32.0),
              child: RaisedButton(
                onPressed: () {
                  authService.signIn();
                },
                child: new Text("Sign In"),
              ),
            ),
          ],
        ),
      ),
    );
  }
   Widget colouredText () {
   if (randomNum == 0) {
     return Text(
              'CALORIE COUNT',
              style: TextStyle(
                  color: AppColours().offBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0),
              textAlign: TextAlign.center,
            );
   } else {
     return Text(
              'CALORIE COUNT',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0),
              textAlign: TextAlign.center,
            );
   }
 }
}
