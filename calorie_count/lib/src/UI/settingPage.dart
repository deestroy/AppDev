import 'package:calorie_count/auth.dart';
import 'package:calorie_count/main.dart';
import 'package:calorie_count/src/UI/rootPage.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: Container(
        child: Column(
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
                  child: profilePic(),
                ),
                Expanded(
                  child: Text(
                    //"hi",
                    AuthService().getName(),
                    style:
                        TextStyle(color: AppColours().offBlack, fontSize: 18.0),
                    textAlign: TextAlign.start,
                  ),
                )
              ],
            ),
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(top: 50.0, bottom: 16.0, left: 25.0),
              child: FlatButton(
                onPressed: () {},
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
                      authService.signOut();
                      Navigator.push(context, new MaterialPageRoute(builder: (context) =>new RootPage()));
                    },
                    child: Text(
                      "Logout",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profilePic() {
    return Column(
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
                    image: NetworkImage("https://i.imgur.com/BoN9kdC.png")))),
       
      ],
    );
  }
} //settingPage
