import 'package:calorie_count/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database {
  final Firestore _db = Firestore.instance;
  String uid = AuthService().getUid();
  
  void writeData (String uid, gender, goal, actLvl, double age, height, weight) {
    Firestore.instance.collection('questionnaire').document().setData({
      'uid': uid,
      'age': age,
      'height': height,
      'weight': weight,
      'gender': gender,
      'activityLvl': actLvl,
      'goal': goal
    }, merge: true);

  }





}