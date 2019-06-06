import 'package:calorie_count/auth.dart';
import 'package:calorie_count/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: FirebaseAuth.instance.currentUser(),
          builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  //back button
                  Padding(
                    padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: BackButton(
                        color: AppColours().offBlack,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                width: 90.0,
                                height: 90.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                            snapshot.data.photoUrl)))),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          snapshot.data.displayName,
                          style: TextStyle(
                              color: AppColours().offBlack,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        ),
                      )
                    ],
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    padding:
                        EdgeInsets.only(top: 50.0, bottom: 16.0, left: 25.0),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/questionnaire');
                      },
                      child: Text("Edit Goals",
                          style: TextStyle(
                              color: AppColours().offBlack, fontSize: 20.0)),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Container(
                        height: 125.0,
                        width: screenWidth,
                        child: FlatButton(
                          color: AppColours().offBlack,
                          onPressed: () {
                            AuthService().signOut();
                          },
                          child: Text(
                            "Logout",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
