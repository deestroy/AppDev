import 'package:calorie_count/main.dart';
import 'package:calorie_count/src/UI/calorieCalc.dart';
import 'package:calorie_count/src/UI/questionPage.dart';
import 'package:flutter/material.dart';

import 'loginPage.dart';
import 'package:calorie_count/auth.dart';

class RootPage extends StatelessWidget {
  final firstCamera = cameras.first;
  CalorieCalc calc = new CalorieCalc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: StreamBuilder(
        stream: authService.user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //signed in
           // if (calc.questionnaireComplete) { need to save in db if q complete
              return new HomePage(camera: firstCamera);
          //  } else {
              // return new QuestionPage();
          //  }
          } else {
            // signed out
           return new LogInPage();
          }
        }));
  }
}