import 'package:calorie_count/auth.dart';
import 'package:calorie_count/main.dart';
import 'package:calorie_count/src/UI/questionPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'loginPage.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RootPageState();
  }
}

class RootPageState extends State<RootPage> {
  final firstCamera = cameras.first;
  final Firestore _db = Firestore.instance;
  bool complete = false;

  Future<DocumentSnapshot>_checkQuestionnaireComplete() async {
    FirebaseUser _user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot ds = await _db.collection('questionnaire').document(_user.uid).get();

    if (ds.exists) {
      print("Document found");
      return ds;
    } else {
        print("Document not found");
        return null;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: authService.user,
          builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
            if (snapshot.hasData) {
              print("${snapshot.data.uid}");
              return Container(
                child: FutureBuilder(
                  future: _checkQuestionnaireComplete(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> document) {
                    if (document.hasData) {
                      print("Q Document found"); 
                      return HomePage(camera: firstCamera);
                    } else {
                      print("No document found");
                      return QuestionPage();
                    }
                  },
                )
              ); 
            } else {
              // signed out. Navigate to login page
              return new LogInPage();
            }
          }),
    );
  }
}
