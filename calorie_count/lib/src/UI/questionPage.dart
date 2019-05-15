import 'package:calorie_count/auth.dart';
import 'package:calorie_count/main.dart';
import 'package:calorie_count/src/UI/calorieCalc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:ui' as ui;

class QuestionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return QuestionPageState();
  }
}

TextEditingController ageController = new TextEditingController();
TextEditingController heightController = new TextEditingController();
TextEditingController weightController = new TextEditingController();

class QuestionPageState extends State<QuestionPage>
    with TickerProviderStateMixin {
  double age, height, weight;
  int currentIndex = 0;
  String exerTimes, goal, gender, activityLevel, loseGain, unit;
  bool completed = false;
  final formKey = GlobalKey<FormState>();
  bool _valid = false;
  CrudMethods crudObj = new CrudMethods();

  List<String> questions = [
    "How old are you?",
    "How tall are you in ?",
    "How much do you weigh in ?",
    "How often do you exercise per week?",
    "How much weight do you want to gain/lose per week?",
    "What is your gender"
  ];

  List<ExerQ> exerQuestion = [
    ExerQ('noX', 'Sedentary: Little to no exercise'),
    ExerQ('lightX', 'Lightly Active: Exercise 1-3 days/week'),
    ExerQ('moderateX', 'Active: Moderate exercise 3-5 days/week'),
    ExerQ('activeX', 'Active: Heavy exercise 6-7 days'),
    ExerQ("extremeX", "Very Active: Non-stop training")
  ];

  List<GoalQ> goalQuestion = [
    GoalQ("lose1", "Lose 0.5 lbs a week"),
    GoalQ("lose2", "Lose 1.0 lbs a week"),
    GoalQ("lose3", "Lose 1.5 lbs a week"),
    GoalQ("lose4", "Lose 2.0 lbs a week"),
    GoalQ("maintain", "Maintain weight"),
    GoalQ("gain1", "Gain 0.5 lbs a week"),
    GoalQ("gain2", "Gain 1.0 lbs a week"),
    GoalQ("gain3", "Gain 1.5 lbs a week"),
    GoalQ("gain4", "Gain 2.0 lbs a week"),
  ];

  List<GenderQ> genderQuestion = [GenderQ("M", "Male"), GenderQ("F", "Female")];

@override
  void dispose() {
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ui.Size logicalSize = MediaQuery.of(context).size;
    final double _width = logicalSize.width;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: getPages(_width),
        ),
      ),
      bottomNavigationBar: currentIndex != 0
          ?
          //_animateController.isCompleted ?
          BottomAppBar(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.grey.withAlpha(200))]),
                height: 50.0,
                child: GestureDetector(
                  onTap: () {
                    if (_valid && currentIndex < 7) { //only let user continue if they answered the question
                      setState(() {
                        currentIndex += 1;
                        _valid = false;
                      });
                    }

                    //When questionnaire is finished, user's calculate calorie intake
                    if (currentIndex == 7) {
                      
                      //make an object containing all the answers to pass through
                      QuestionAnswers calorieGoal = new QuestionAnswers(
                          age, height, weight, gender, activityLevel, goal);
                      Calculator().setCalories(calorieGoal, unit);
                      crudObj.addData(calorieGoal);
                     // authService.writeAnswersDB(FirebaseAuth.currentUser(), calorieGoal);
                      Navigator.pushNamed(context, '/results');
                    }
                  },
                  child: Center(
                      child: Text(
                    currentIndex < 5 ? 'Continue' : 'Finish',
                    style:
                        TextStyle(fontSize: 20.0, color: Colors.orangeAccent),
                  )),
                ),
              ),
            )
          : null,
    );
  } //build

  Widget getPages(double _width) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _backButton(),

        currentIndex == 0
            ? _firstPage()
            : currentIndex == 1
                ? _inputQuestion(ageController, "Question 1", questions[0])
                : currentIndex == 2
                    ? _inputQuestion(
                        heightController, "Question 2", questions[1])
                    : currentIndex == 3
                        ? _inputQuestion(
                            weightController, "Question 3", questions[2])
                        : currentIndex == 4
                            ? _getGenderQ()
                            : currentIndex == 5 ? _getActLvlQ() : _getGoalQ()
      ],
    );
  }

  Widget _firstPage() {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Padding(padding: EdgeInsets.only(top: 16.0),),
            Text(
              "Insert Logo",
              style: TextStyle(fontSize: 30.0),
            ),
            Padding(padding: EdgeInsets.only(bottom: 100.0)),
            Text(
              'Calorie Intake Calculator',
              style: TextStyle(
                  color: AppColours().coral,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0),
              textAlign: TextAlign.left,
            ),
            Padding(padding: EdgeInsets.only(bottom: 16.0)),
            Text(
              'Please complete this quick questionnaire so we can determine the number of calories you should intake',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 16.0)),
            Container(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              width: 150.0,
              child: FlatButton(
                  child: Text(
                    "Metric",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  color: AppColours().coral,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  onPressed: () {
                    setState(() {
                      currentIndex += 1;
                      unit = "Metric";
                    });
                  }),
            ),
            Container(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              width: 150.0,
              child: FlatButton(
                  child: Text(
                    "Imperial",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  color: AppColours().coral,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  onPressed: () {
                    setState(() {
                      currentIndex += 1;
                      unit = "Imperial";
                    });
                  }),
            )
          ],
        ),
      ),
    );
  }

  //returns a Widget that displays a question and a TextField
  Widget _inputQuestion(controllerName, String quesNum, String ques) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(quesNum),
            Container(
                margin: EdgeInsets.only(top: 16.0),
                child: Text(_quesWithUnits(ques))),
            Container(
                margin: EdgeInsets.symmetric(vertical: 50.0),
                //Form that validates input
                child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            maxLength: 3,
                            controller: controllerName,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Required';
                              }
                            },
                            decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(45.45),
                                ),
                              ),
                            ),
                            onFieldSubmitted: (String a) {
                              _submitted(a, ques, controllerName);
                            }),
                      ],
                    ))),
          ],
        ),
      ),
    );
  } //inputQuestion

  //function that sets a varaible depending on what question was asked
  _submitted(String a, String q, TextEditingController controller) {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      if (q == questions[0]) {
        setState(() {
          age = double.parse(a);
          print("Age is $age");
          _valid = true; //user answered so they can now continue to the next Q
        });
      } else if (q == questions[1]) {
        height = double.parse(a);
        print("Height is $height");
        _valid = true; //user answered so they can now continue to the next Q
      } else if (q == questions[2]) {
        weight = double.parse(a);
        print("Weight is $weight");
        _valid = true; //user answered so they can now continue to the next Q
      }
    }
  }

//method to return the question with the correct units
  String _quesWithUnits(String q) {
    if (unit == "Metric") {
      if (q == questions[1]) {
        return "How tall are you in centimeters?";
      } else if (q == questions[2]) {
        return "How much do you weigh in kgs?";
      }
    } else if (unit == "Imperial") {
      if (q == questions[1]) {
        return "How tall are you in inches? (Note: 12 inches in a foot)";
      } else if (q == questions[2]) {
        return "How much do you weigh in pounds?";
      }
    }
    return q;
  }

  //Returns a Widget containing the gender question w/ a card and radio buttons
  Widget _getGenderQ() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text("Question 4"),
            Container(
                margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: Text(questions[5])),
            Expanded(
              child: Center(
                child: Container(
                  height: 108.0,
                  child: Card(
                    child: Column(
                      children:
                          List.generate(genderQuestion.length, (int index) {
                        final using = genderQuestion[index];
                        return GestureDetector(
                          onTapUp: (detail) {
                            setState(() {
                              gender = using.identifier;
                              print(gender);
                              _valid = true;
                            });
                          },
                          child: Container(
                            height: 50.0,
                            color: gender == using.identifier
                                ? Colors.orangeAccent.withAlpha(100)
                                : Colors.white,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Radio(
                                        activeColor: Colors.orangeAccent,
                                        value: using.identifier,
                                        groupValue: gender,
                                        onChanged: (String value) {
                                          setState(() {
                                            gender = value;
                                            print("changed");
                                          });
                                        }),
                                    Text(using.displayContent)
                                  ],
                                ),
                                Divider(
                                  height:
                                      index < exerQuestion.length ? 1.0 : 0.0,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  } //exerciseQuestion

  //Returns a Widget containing the activity level question w/ a card and radio buttons
  Widget _getActLvlQ() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text("Question 5"),
            Container(
                margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: Text(questions[3])),
            Expanded(
              child: Center(
                child: Container(
                  height: 258.0,
                  child: Card(
                    child: Column(
                      children: List.generate(exerQuestion.length, (int index) {
                        final using = exerQuestion[index];
                        return GestureDetector(
                          onTapUp: (detail) {
                            setState(() {
                              exerTimes = using.identifier;
                              activityLevel = using.identifier;
                              print(exerTimes);
                              _valid = true; //user answered so they can now continue to the next Q
                            });
                          },
                          child: Container(
                            height: 50.0,
                            color: exerTimes == using.identifier
                                ? Colors.orangeAccent.withAlpha(100)
                                : Colors.white,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Radio(
                                        activeColor: Colors.orangeAccent,
                                        value: using.identifier,
                                        groupValue: exerTimes,
                                        onChanged: (String value) {
                                          setState(() {
                                            exerTimes = value;
                                          });
                                        }),
                                    Text(using.displayContent)
                                  ],
                                ),
                                Divider(
                                  height:
                                      index < exerQuestion.length ? 1.0 : 0.0,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  } //exerciseQuestion

  //Returns a Widget containing the goal question w/ a card and radio buttons
  Widget _getGoalQ() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 34.0),
              child: Text("Question 6"),
            ),
            Container(
                margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: Text(questions[4])),
            Center(
              child: Container(
                child: Card(
                  child: Column(
                    children: List.generate(goalQuestion.length, (int index) {
                      final using = goalQuestion[index];
                      return GestureDetector(
                        onTapUp: (detail) {
                          setState(() {
                            goal = using.identifier;
                            loseGain = using.identifier;
                            print(goal);
                            _valid = true; //user answered so they can now continue to the next Q
                          });
                        },
                        child: Container(
                          height: 50.0,
                          color: goal == using.identifier
                              ? Colors.orangeAccent.withAlpha(100)
                              : Colors.white,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Radio(
                                      activeColor: Colors.orangeAccent,
                                      value: using.identifier,
                                      groupValue: goal,
                                      onChanged: (String value) {
                                        setState(() {
                                          goal = value;
                                        });
                                      }),
                                  Text(using.displayContent)
                                ],
                              ),
                              Divider(
                                height: index < exerQuestion.length ? 1.0 : 0.0,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  } //exerciseQuestion

  //Widget that displays a back button in the top right corner of the screen
  Widget _backButton() {
    if (currentIndex == 0) {
      //if on first page, hide button
      return IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.transparent,
          ),
          onPressed: () {});
    } else {
      //return a back button
      return IconButton(
          //back button
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          tooltip: "Go back",
          alignment: Alignment.topLeft,
          onPressed: () {
            setState(() {
              currentIndex -= 1;
            });
          });
    }
  }
} //QuestionStatePage

//Class that provides an identifier and String to be displayed for the activity level question
class ExerQ {
  final String identifier;
  final String displayContent;
  ExerQ(this.identifier, this.displayContent);
}

//Class that provides an identifier and String to be displayed for the gender question
class GenderQ {
  final String identifier;
  final String displayContent;
  GenderQ(this.identifier, this.displayContent);
}

//Class that provides an identifier and String to be displayed for the gender question
class GoalQ {
  final String identifier;
  final String displayContent;
  GoalQ(this.identifier, this.displayContent);
}
