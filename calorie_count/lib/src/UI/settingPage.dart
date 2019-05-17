import 'package:calorie_count/main.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            //back button
            BackButton(
              color: AppColours().offBlack,
            ),
            // IconButton(
            //   padding: EdgeInsets.only(top:8.0, bottom: 8.0),
            //     icon: Icon(
            //       Icons.arrow_back,
            //       color: Colors.black,
            //     ),
            //     onPressed: () {
            //       Navigator.pushNamed(context, '/questionnaire');
            //     }),
            Padding(padding: EdgeInsets.only(bottom: 16.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                profilePic(),
                Text(
                  "Username",
                  style: TextStyle(color: AppColours().offBlack),
                )
              ],
            ),
            BottomAppBar(

            )

          ],
        ),
      ),
    );
  }

Widget profilePic (){
  return new Padding(
    padding: EdgeInsets.only(left: 16.0
    ),
    child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                 Container(
                    width: 100.0,
                    height: 100.0,
                    decoration:  BoxDecoration(
                        shape: BoxShape.circle,
                        image:  DecorationImage(
                            fit: BoxFit.fill,
                            image:  NetworkImage(
                                "https://i.imgur.com/BoN9kdC.png")
                        )
                    )),
                 FlatButton(
                  color: Colors.pink,
                  child: Text(
                    "Edit",
                    style: TextStyle(color: AppColours().offBlack),
                    textScaleFactor: 1.25)
                 
                ),
              ],
            ));
}




}//settingPage
