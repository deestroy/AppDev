import 'package:calorie_count/auth.dart';
import 'package:calorie_count/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/src/observables/observable.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingPageState();
  }
}

class SettingPageState extends State<SettingPage>{

  String _userName = "";
  String _displayPicture ="";

  getUserDetails() {
    FirebaseAuth.instance.currentUser().then((user){
      setState(() {
        this._userName = user.displayName;
        this._displayPicture = user.photoUrl;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    getUserDetails();
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
                    _userName,
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
                      AuthService().signOut();
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
                    image: NetworkImage(_displayPicture)))),
      ],
    );
  }
} //settingPage

    // Scaffold(
    // body: StreamBuilder(
    //    stream: authService.user,
    //     builder: (context, snapshot) {
        
    //     if (snapshot.hasData) {
    //       Future firebaseuser = FirebaseAuth.instance.currentUser();
    //       firebaseuser.then((data) {
    //         String userid = data.uid;
    //         print(userid);
    //       }, onError: (e) {
    //         print(e);
    //       });

          // getUser() async {
          //   FirebaseAuth.instance.currentUser().then((user) {
            //  set
         // });
          //    uid = u.uid;
          //   return uid;
          // }


// class SettingPage extends StatelessWidget{
//  // Future<String> displayName = getName();

//   final String name, dp;

//   SettingPage({
//     Key key,
//     this.name, this.dp
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: Container(
//         child: Column(
//           children: <Widget>[
//             //back button
//             Padding(
//               padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
//               child: Align(
//                 alignment: Alignment.topLeft,
//                 child: BackButton(
//                   color: AppColours().offBlack,
//                 ),
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Expanded(
//                   child: profilePic(),
//                 ),
//                 Expanded(
//                   child: Text(
//                     AuthService().getName(),
//                     style:
//                         TextStyle(color: AppColours().offBlack, fontSize: 18.0),
//                     textAlign: TextAlign.start,
//                   ),
//                 )
//               ],
//             ),
//             Container(
//               alignment: Alignment.bottomLeft,
//               padding: EdgeInsets.only(top: 50.0, bottom: 16.0, left: 25.0),
//               child: FlatButton(
//                 onPressed: () {},
//                 child: Text("Edit Goals",
//                     style: TextStyle(
//                         color: AppColours().offBlack, fontSize: 20.0)),
//               ),
//             ),
//             Expanded(
//               child: Align(
//                 alignment: FractionalOffset.bottomCenter,
//                 child: Container(
//                   height: 125.0,
//                   width: screenWidth,
//                   child: FlatButton(
//                     color: AppColours().offBlack,
//                     onPressed: () {
//                       AuthService().signOut();
//                     },
//                     child: Text(
//                       "Logout",
//                       style: TextStyle(color: Colors.white, fontSize: 18.0),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget profilePic() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Container(
//             width: 90.0,
//             height: 90.0,
//             decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 image: DecorationImage(
//                     fit: BoxFit.fill,
//                     image: NetworkImage("https://lh6.googleusercontent.com/-ZEWybEXg0aE/AAAAAAAAAAI/AAAAAAAAAAA/ACHi3re7upo8oakPR3NAesXp7ipyG4mWlw/s96-c/photo.jpg")))),
//       ],
//     );
//   }
// } //settingPage
