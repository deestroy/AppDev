import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final Firestore _db = Firestore.instance;
  String uid, dp, name = "hi";

  Observable<FirebaseUser> user; //Firebase user
  Observable<Map<String, dynamic>> profile; //user data in Firestore
  PublishSubject loading = PublishSubject();
  Observable<bool> signedIn;


  AuthService() {
    //define user observable. Changes when user signs in and out
    user = Observable(auth.onAuthStateChanged); 
    

    profile = user.switchMap((FirebaseUser u) {
      if (u != null) {
        return _db
            .collection('users')
            .document(u.uid)
            .snapshots()
            .map((snap) => snap.data);
      } else {
        return Observable.just({});
      }
    });
  }

  Future<FirebaseUser> signIn() async {
    loading.add(true);
    //signs user into Google
    GoogleSignInAccount googleUser =
        await googleSignIn.signIn().catchError((onError) {
      print("Error $onError");
    });

    GoogleSignInAuthentication googleAuth =
        await googleUser.authentication.catchError((onError) {
      print("Error $onError");
    });

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    //signs user into Firebase
    final FirebaseUser user =
        await auth.signInWithCredential(credential).catchError((onError) {
      print("Error $onError");
    });
  
    updateUserData(user);
    print(user.displayName + " signed in");

  //   UserDetails detail = new UserDetails(user.displayName, user.photoUrl, user.uid);

  //   Future<String> fetchUserData() async {
  //   var document = await Firestore.instance.collection('users').document(user.uid);
  //   document.get() => then ()

  // }

    setName(name);
    setDP(dp);
    setUID(uid);

    loading.add(false);
    return user;
  }

  void updateUserData(FirebaseUser user) async {
    DocumentReference ref = _db.collection('users').document(user.uid);

    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
    }, merge: true);
  }

  //Sign user out of Firebase
  void signOut() {
    auth.signOut();
    googleSignIn.signOut();
    print("User signed out");
  }

  setName(String n) {
    name = n;
    print("Username set to $n");
  }

  setUID(String u) {
    uid = u;
    print("UID is: $uid");
  }

  setDP(String d) {
    dp = d;
    print("Photo URL: $dp");
  }

  getUid() {
    print('uid is $uid');
    return uid;
  }

  getDP() {
    return dp;
  }

  getName() {
    return name;
  }
} //AuthService

final AuthService authService = AuthService();

class UserDetails {
  final String displayName;
  final String photoURL;
  final String uid;

  UserDetails(this.displayName, this.photoURL, this.uid);
}
