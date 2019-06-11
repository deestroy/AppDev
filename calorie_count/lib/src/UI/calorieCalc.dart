import 'package:calorie_count/main.dart';
import 'package:calorie_count/src/database.dart';
import 'package:flutter/material.dart';

class CalorieCalc extends StatelessWidget {
  final firstCamera = cameras.first;
  final QuestionAnswers ans;
  final String units;
  CalorieCalc({this.ans, this.units});

  int calories = 0;
  double bmr;

  Database db = new Database();
  
  setCalories(QuestionAnswers ans, String unit) {
    //Metric Calculations
    if (unit == "Metric") {
      if (ans.getGender() == 0) {
        //male
        bmr = ((66.5 +
                    (13.75 * ans.getWeight()) +
                    (5.003 * ans.getHeight()) -
                    (6.775 * ans.getAge())) *
                ans.getActLvl()) +
            ans.getLoseGain();
          calories = bmr.round();
        if (calories < 1200) {
          calories = 1200;
        }
        ("This male should be consuming $calories calories");
      } else if (ans.getGender() == 1) {
        //female
        bmr = ((655.1 +
                    (9.563 * ans.getWeight()) +
                    (1.85 * ans.getHeight()) -
                    (4.676 * ans.getAge())) *
                ans.getActLvl()) +
            ans.getLoseGain();
        calories = bmr.round();
        if (calories < 1200) {
          calories = 1200;
        }
        print("This female should be consuming $calories calories");
      }
    } //Imperial calculations
    else if (unit == "Imperial") {
      if (ans.getGender() == 0) {
        //male
        bmr = ((66.0 +
                    (6.23 * ans.getWeight()) +
                    (12.7 * ans.getHeight()) -
                    (6.8 * ans.getAge())) *
                ans.getActLvl()) +
            ans.getLoseGain();
        calories = bmr.round();
        if (calories < 1200) {
          calories = 1200;
        }
        print("This male should be consuming $calories calories");
      } else if (ans.getGender() == 1) {
        //female
        bmr = ((655.0 +
                    (4.35 * ans.getWeight()) +
                    (4.7 * ans.getHeight()) -
                    (4.7 * ans.getAge())) *
                ans.getActLvl()) +
            ans.getLoseGain();
         calories = bmr.round();
         if (calories < 1200) {
          calories = 1200;
        }
        print("This female should be consuming $calories calories");
      } 
    }
  } //setCalories

  getCalories() {
    return calories;
  }
 
  @override
  Widget build(BuildContext context) {
    print("building results");
    setCalories(ans, units);
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0),
              child: Center(
                child: Container(
                  padding: EdgeInsets.only(
                      top: 20.0, bottom: 20.0, left: 16.0, right: 16.0),
                  child: Wrap(
                    children: <Widget>[
                      Text(
                        "Based on your answers, your total daily calorie intake has been calculate to help you reach your goal! Your recommended intake is displayed below. You can take the quiz again in settings",
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: AppColours().offBlack,
                      borderRadius: BorderRadius.circular(15.0)),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(32.0)),
            Container(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 20.0, left: 70.0, right: 70.0),
              child:
              Text(
                calories.toString(),
                style: TextStyle(fontSize: 40.0, color: AppColours().offBlack),
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColours().offBlack),
                  borderRadius: BorderRadius.circular(15.0)),
            ),
            Container(
              width: 90.0,
              margin: EdgeInsets.only(left: 270.0, top: 290.0),
              padding: EdgeInsets.only(left: 8.0, right: 8.0),
              child: FlatButton(
                child: Text("Save",
                    style: TextStyle(fontSize: 16.0, color: Colors.white)),
                onPressed: () {
                  //write answers to database
                  db.addData(ans, calories);
                 Navigator.push(context, new MaterialPageRoute(builder: (context) => HomePage(camera: firstCamera)));
                },
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: AppColours().offBlack,
              ),
            ),
          ],
        ),
      ),
    );
  } //build
} //CalorieCalc

//question object to be passed to make calculations
class QuestionAnswers {
  double age, height, weight, gender, activitylvl, loseGain;
  String actLvlString, loseGainString;

  QuestionAnswers(
      double a, double h, double w, String gen, String pa, String goal) {
    this.setAge(a);
    this.setHeight(h);
    this.setWeight(w);
    this.setGender(gen);
    this.setActLvl(pa);
    this.setLoseGain(goal);
  }

  //SETS VARIABLES PASSED THROUGH
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
      actLvlString = "Sedentary";
      activitylvl = 1.2;
    } else if (pa == "lightX") {
      actLvlString = "Lightly Active";
      activitylvl = 1.375;
    } else if (pa == "moderateX") {
      actLvlString = "Moderately Active";
      activitylvl = 1.55;
    } else if (pa == "activeX") {
      actLvlString = "Active";
      activitylvl = 1.725;
    } else if (pa == "extremeX") {
      actLvlString = "Very Active";
      activitylvl = 1.9;
    }
  }

  setLoseGain(String goal) {
    if (goal == "lose1") {
      loseGainString = "Lose 0.5 lbs/ week";
      loseGain = -250.0;
    } else if (goal == "lose2") {
      loseGainString = "Lose 1.0 lbs/ week";
      loseGain = -500.0;
    } else if (goal == "lose3") {
      loseGainString = "Lose 1.5 lbs/ week";
      loseGain = -750.0;
    } else if (goal == "lose4") {
      loseGainString = "Lose 2.0 lbs/ week";
      loseGain = -1000.0;
    } else if (goal == "maintain") {
      loseGainString = "Maintain weight";
      loseGain = 250.0;
    } else if (goal == "gain1") {
      loseGainString = "Gain 0.5 lbs/ week";
      loseGain = 250.0;
    } else if (goal == "gain2") {
      loseGainString = "Gain 1.0 lbs/ week";
      loseGain = 500.0;
    } else if (goal == "gain3") {
      loseGainString = "Gain 1.5 lbs/ week";
      loseGain = 750.0;
    } else if (goal == "gain4") {
      loseGainString = "Gain 2.0 lbs/ week";
      loseGain = 1000.0;
    }
  }

  //FUNCTIONS TO GET VARIABLES
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

  getActLvlString() {
    return actLvlString;
  }

  getLoseGain() {
    return loseGain;
  }

  getLoseGainString() {
    return loseGainString;
  }

} //QuestionAnswers