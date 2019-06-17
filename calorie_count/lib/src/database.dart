import 'package:calorie_count/src/UI/calorieCalc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import '../main.dart';

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

  //gets the user's calorie goal
   getCalories() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot snapshot = await Firestore.instance.collection('questionnaire').document(user.uid).get();
    int calories = snapshot['calories'];
    return calories;
  }
  
  //adds food user ate to the database
   Future<void> addFood(Food item, String mealtime) async {
    String date = DateFormat.yMMMMd("en_US").format(DateTime.now());
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection('foodDB').document(user.uid).collection(date).document(date).collection(mealtime).document(item.foodName).setData({
      'foodName': item.foodName,
      'calories': item.calories,
      'servingSize': item.servingSize,
      'servingUnit': item.unit
    }, merge: true);
    setCaloriesConsumed(item.calories, date);
  }

  //delete food user ate to the database
   Future<void> removeFood(String itemName, String mealtime, int calories, String date) async {
    String date = DateFormat.yMMMMd("en_US").format(DateTime.now());
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection('foodDB').document(user.uid).collection(date).document(date).collection(mealtime).document(itemName).delete();
    setCaloriesConsumed(calories, date);
  }

  //sets the number of caloies consumed by the user that day
  setCaloriesConsumed(int cal, String date) async {
    int caloriesConsumed;
    int previousCal = await getCaloriesConsumed(date);
    if (previousCal != null) {
      caloriesConsumed = previousCal + cal;
    } else {
      caloriesConsumed = cal;
    }
    
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection('caloriesConsumed').document(user.uid).collection(date).document('caloriesConsumed').setData({
      'calories': caloriesConsumed,
    }, merge: true);
  }

  //return user's number of calories consumed for that day
  getCaloriesConsumed(String date) async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot snapshot = await Firestore.instance.collection('caloriesConsumed').document(user.uid).collection(date).document('caloriesConsumed').get();
    if (snapshot.data != null) {
      int calsConsumed = snapshot['calories'];
      return calsConsumed;
    } else {
      return 0;
    }
  }

}
