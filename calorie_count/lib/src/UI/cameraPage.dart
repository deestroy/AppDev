import 'package:calorie_count/auth.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
        body: Container(
          child: Column(
            
            children: <Widget>[
              Padding(padding: EdgeInsets.all(16.0),),
              Center(
                child: Text("camera"),
              ),
              RaisedButton(
              onPressed: () {
                 authService.signOut();
              },
              child: new Text("Sign Out"),
            ),



            ],
          ),
           
        )
           );
  }
}
