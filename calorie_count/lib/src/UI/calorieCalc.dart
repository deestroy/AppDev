
import 'package:flutter/material.dart';

class CalorieCalc extends StatelessWidget {
  String calorieIntake = Calculator().calories.toString();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold (
      appBar: AppBar(
        title: Text("Calorie Calc"),
      ),
      body: Container(
        child: Text("Daily calorie intake is $calorieIntake"),
      ),
      );
  }

}

//question object to be passed to make calculations
class QuestionAnswers {
  double age, height, weight, gender, activitylvl,loseGain;

  // constructor
  QuestionAnswers (double a, double h, double w, String gen, String pa, String goal) {
    setAge(a);
    setHeight(h);
    setWeight(w);
    setGender(gen);
    setActLvl(pa);
    setLoseGain(goal);
  }

  setAge(double a) {
    age = a;
  }
  setHeight(double h) {
    height = h;
  }
  setWeight(double w) {
    weight = w;
  }
  setGender(String gen) {
    if (gen == "M") {
      gender = 0; //male
    } else {
      gender = 1; //female
    }
  }
  //setting the number you need to multiply by to get BMR
  setActLvl(String pa) { 
    if (pa == "noX") {
      activitylvl = 1.2;
    } else if (pa == "lightX") {
      activitylvl = 1.375;
    }
    else if (pa == "moderateX") {
      activitylvl = 1.55;
    }
    else if (pa == "activeX") {
      activitylvl = 1.725;
    }
    else if (pa == "extremeX") {
      activitylvl = 1.9;
    }
  }
  setLoseGain(String goal) {
    if (goal == "lose1") {
      loseGain = -250.0;
    } else if (goal == "lose2") {
      loseGain = -500.0;
    } else if (goal == "lose3") {
      loseGain = -750.0;
    } else if (goal == "lose4") {
      loseGain = -1000.0;
    } else if (goal == "maintain") {
      loseGain = 250.0;
    } else if (goal == "gain1") {
      loseGain = 250.0;
    } else if (goal == "gain2") {
      loseGain = 500.0;
    } else if (goal == "gain3") {
      loseGain = 750.0;
    } else if (goal == "gain4") {
      loseGain = 1000.0;
    } 
  }

  getAge() {
    return age;
  }
  getWeight() {
    return weight;
  }
  getHeight() {
    return height;
  }
  getGender() {
    return gender;
  }
  getActLvl() {
    return activitylvl;
  }
  getLoseGain() {
    return loseGain;
  }

}//QuestionAnswers

class Calculator {
int calories;
double bmr;

    calorieCalculator(QuestionAnswers ans) {

    if (ans.getGender() == 0) { //male
      bmr = ((66.5 + (13.75*ans.getWeight()) + (5.003*ans.getHeight()) - (6.775* ans.getAge()))*ans.getActLvl()) + ans.getLoseGain();
      calories = bmr.round();
      print("This male should be consuming $calories calories");
    } 
    else if (ans.getGender() == 1) {
      bmr = ((655.1 + (9.563*ans.getWeight()) + (1.85*ans.getHeight()) - (4.676*ans.getAge()))*ans.getActLvl()) + ans.getLoseGain();
      calories = bmr.round();
      print("This female should be consuming $calories calories");
    }

  }
}