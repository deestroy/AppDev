import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final Firestore _db = Firestore.instance;

  Observable<FirebaseUser> user; //Firebase user
  Observable <Map<String, dynamic>> profile; //user data in Firestore
  PublishSubject loading = PublishSubject();

  AuthService () {
    //define user observable. Changes when user signs in and out
    user = Observable(_auth.onAuthStateChanged);

    profile = user.switchMap((FirebaseUser u) {
      if (u != null) {
        return _db.collection('users').document(u.uid).snapshots().map((snap) => snap.data);
      } else {
        return Observable.just({});
      }
    });
  }
  
  Future <FirebaseUser> signIn() async {
    loading.add(true);
    //signs user into Google
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    //signs user into Firebase
    final FirebaseUser user = await _auth.signInWithCredential(credential);

    updateUserData(user);
    print(user.displayName + "signed in");

    loading.add(false);
    return user;
  }

  void updateUserData (FirebaseUser user) async {
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
    _auth.signOut();
    googleSignIn.signOut();
    print("User signed out");
  }

} //AuthService

final AuthService authService = AuthService();