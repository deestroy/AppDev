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
              'APP NAME',
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


// //Creates a Google Sign In Account
// class LogInScreen extends StatelessWidget {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn googleSignIn = new GoogleSignIn();

//   Future<FirebaseUser> _signIn() async {
//     //signs user into Google
//     GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
//     GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;

//     final AuthCredential credential = GoogleAuthProvider.getCredential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     //signs user into Firebase
//     final FirebaseUser user = await _auth.signInWithCredential(credential);

//     print("Username: ${user.displayName}");
//     return user;
//   } // sign in method

//   //Signs user out of Google
//   void _signOut() {
//     googleSignIn.signOut();
//     print("User Signed out");
//   }

//   //creates a Page containing the app name and sign in button
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       backgroundColor: AppColours().offBlack,
//       body: new Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: new Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             Text(
//               'APP NAME',
//               style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 30.0),
//               textAlign: TextAlign.center,
//             ),
//             Padding(
//               padding: EdgeInsets.all(100.0),
//             ),
//             RaisedButton(
//               onPressed: () {
//                 _signIn()
//             //      .then((FirebaseUser user) => print(user)) //prints user information
//                   .catchError((e) => print(e));
//                 Navigator.pushNamed(context, '/questionnaire');
//               },
//               child: new Text("Sign In"),
//             ),
//             Padding (padding: EdgeInsets.all(10.0),),
//             RaisedButton(
//               onPressed: () {
//                  _signOut();
//               },
//               child: new Text("Sign Out"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }