import 'package:calorie_count/main.dart';
import 'package:flutter/material.dart';

import 'loginPage.dart';
import 'package:calorie_count/auth.dart';

class RootPage extends StatelessWidget {
  var cameras;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: StreamBuilder(
        stream: authService.user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //signed in
            return new HomePage(camera: this.cameras);
          } else {
            // signed out
           return new LogInPage();
          }
        }));
  }
}