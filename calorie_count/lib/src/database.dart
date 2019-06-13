import 'dart:io';

import 'package:calorie_count/src/UI/calorieCalc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import 'foodData.dart';
//import 'package:firebase_storage/firebase_storage.dart';

class Database {
  //write questionnaire answers to database
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

  //update user's questionnaire answers
  Future<void> updateData(QuestionAnswers q, int calories) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection('questionnaire').document(user.uid).updateData({
      'age': q.getAge(),
      'height': q.getHeight(),
      'weight': q.getWeight(),
      'gender': q.getGender(),
      'activityLvl': q.getActLvlString(),
      'goal': q.getLoseGainString(),
      'calories': calories
    });
  }

   getCalories() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot snapshot = await Firestore.instance.collection('questionnaire').document(user.uid).get();
    int calories = snapshot['calories'];
    print("$calories");
    return calories;
  }

   Future<void> addFood(Food item, String mealtime) async {
    String date = DateFormat.yMMMMd("en_US").format(DateTime.now());
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection('foodDB').document(user.uid).collection(date).document(date).collection(mealtime).document(item.foodName).setData({
      'foodName': item.foodName,
      'calories': item.calories,
      'servingSize': item.servingSize,
      'servingUnit': item.unit
    }, merge: true);
  }

}
