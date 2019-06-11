import 'dart:io';

import 'package:calorie_count/src/UI/calorieCalc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_storage/firebase_storage.dart';

class Database {

  Future<void> addData(QuestionAnswers q, int calories) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection('questionnaire').document(user.uid).setData({
      'age': q.getAge(),
      'height': q.getHeight(),
      'weight': q.getWeight(),
      'gender': q.getGender(),
      'activityLvl': q.getActLvlString(),
      'goal': q.getLoseGainString(),
      'calories': calories
    }, merge: true);
  }


}
