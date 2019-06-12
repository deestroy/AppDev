import 'package:calorie_count/main.dart';
import 'package:calorie_count/src/UI/calorieCalc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

class EditQuestionnaire extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EditQuestionnaireState();
}

TextEditingController _ageController = new TextEditingController();
TextEditingController _heightController = new TextEditingController();
TextEditingController _weightController = new TextEditingController();

class EditQuestionnaireState extends State<EditQuestionnaire> {
  double age, height, weight;
  String exerTimes, goal, gender, activityLevel, loseGain, unit;
  bool completed;
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  AppColours c = new AppColours();
  bool emptyText = true;
  int currentIndex = 0;
  bool edited = false;


  List questions = [
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
    ExerQ('moderateX', 'Moderately Active: Exercise 3-5 days/week'),
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
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ui.Size logicalSize = MediaQuery.of(context).size;
    final double _width = logicalSize.width;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(right: 16.0, left: 16.0, top: 16.0),
            child: getPages(_width)),
      ),
    );
  } //build

  Widget getPages(double _width) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        currentIndex == 0
            ? _firstPage()
            : currentIndex == 1
                ? questionList()
                : Container(
                    child: Text("No page"),
                  )
      ],
    );
  }

  Widget questionList() {
    return Column(
      children: <Widget>[
        Align(
            alignment: Alignment.topLeft,
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                tooltip: "Go back",
                onPressed: () {
                  setState(() {
                    currentIndex -= 1;
                  });
                })),
        inputQuestion(_ageController, "Question 1", questions[0], formKey),
        inputQuestion(_heightController, "Question 2", questions[1], formKey2),
        inputQuestion(_weightController, "Question 3", questions[2], formKey3),
        getGenderQ(),
        getActLvlQ(),
        getGoalQ(),
        Container(
          width: 100.0,
          margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
          padding: EdgeInsets.only(
            left: 8.0,
            right: 8.0,
          ),
          child: FlatButton(
            child: Text("Save",
                style: TextStyle(fontSize: 16.0, color: Colors.white)),
            onPressed: () {
              if ((age != null) && (height != null) && (weight != null) && (gender!= null) && (activityLevel!= null) && (goal != null)) {
                edited = true;
                QuestionAnswers calorieGoal = new QuestionAnswers(
                          age, height, weight, gender, activityLevel, goal);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new CalorieCalc(
                                  ans: calorieGoal, units: unit)));
              }
            },
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: c.coral,
          ),
        ),
      ],
    );
  } // questionList

  Widget _firstPage() {
    return Container(
      height: 600.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: BackButton(
              color: c.offBlack,
            ),
          ),
          Expanded(
              child: Center(
                  child: FlutterLogo(
            size: 150.0,
          ))),
          Padding(padding: EdgeInsets.only(bottom: 100.0)),
          Text(
            'Calorie Intake Calculator',
            style: TextStyle(
                color: c.coral, fontWeight: FontWeight.bold, fontSize: 24.0),
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
                color: c.coral,
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
                color: c.coral,
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
    );
  }

  //returns a Widget that displays a question and a TextField
  Widget inputQuestion(controllerName, String quesNum, String ques,
      GlobalKey<FormState> formKey) {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(quesNum),
          Container(
              margin: EdgeInsets.only(top: 8.0),
              child: Text(_quesWithUnits(ques))),
          Container(
              margin: EdgeInsets.symmetric(vertical: 16.0),
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
                          keyboardType: TextInputType.text,
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
                            submitted(a, ques, controllerName, formKey);
                          }),
                    ],
                  ))),
        ],
      ),
    );
  } //inputQuestion

  //function that sets a varaible depending on what question was asked
  submitted(String a, String q, TextEditingController controller,
      GlobalKey<FormState> formKey) {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      if (q == questions[0]) {
        setState(() {
          age = double.parse(a);
        });
      } else if (q == questions[1]) {
        print("$height");
        height = double.parse(a);
         
      } else if (q == questions[2]) {
        weight = double.parse(a);
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
  Widget getGenderQ() {
    return Container(
      height: 174.0,
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
                    children: List.generate(genderQuestion.length, (int index) {
                      final using = genderQuestion[index];
                      return GestureDetector(
                        onTapUp: (detail) {
                          setState(() {
                            gender = using.identifier;
                          });
                        },
                        child: Container(
                          height: 50.0,
                          color: gender == using.identifier
                              ? c.coral.withAlpha(100)
                              : Colors.white,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Radio(
                                      activeColor: c.coral,
                                      value: using.identifier,
                                      groupValue: gender,
                                      onChanged: (String value) {
                                        setState(() {
                                          gender = value;
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
          )
        ],
      ),
    );
  } //exerciseQuestion

  //Returns a Widget containing the activity level question w/ a card and radio buttons
  Widget getActLvlQ() {
    return Container(
      height: 324.0,
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
                          });
                        },
                        child: Container(
                          height: 50.0,
                          color: exerTimes == using.identifier
                              ? c.coral.withAlpha(100)
                              : Colors.white,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Radio(
                                      activeColor: c.coral,
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
          )
        ],
      ),
    );
  } //exerciseQuestion

  //Returns a Widget containing the goal question w/ a card and radio buttons
  Widget getGoalQ() {
    return Container(
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
                        });
                      },
                      child: Container(
                        height: 50.0,
                        color: goal == using.identifier
                            ? c.coral.withAlpha(100)
                            : Colors.white,
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Radio(
                                    activeColor: c.coral,
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
    );
  } //exerciseQuestion

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
