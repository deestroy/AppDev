import 'package:calorie_count/src/calorieCalc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
//import 'package:calorie_count/main.dart' as main;

class QuestionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: QPage(),
    );
  }
}

class QPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return QPageState();
  }
}

class QPageState extends State<QPage> {
  int age, height, weight;
  List<String> questions = [
    "How old are you?",
    "How tall are you?",
    "How much do you weigh?"
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: StaggeredGridView.count(
          crossAxisCount: 1,
          mainAxisSpacing: 8.0,
          padding: EdgeInsets.only(top: 36.0),
          children: <Widget>[
            //questions
            _qAndBox(questions[0]),
            _genderQuestion(),
            _qAndBox(questions[1]),
            _qAndBox(questions[2]),
            _paQuestion()
          ],
          staggeredTiles: [
            StaggeredTile.extent(1, 130.0), //rows for each question
            StaggeredTile.extent(1, 80.0),
            StaggeredTile.extent(1, 130.0),
            StaggeredTile.extent(1, 130.0),
            StaggeredTile.extent(1, 230.0),
          ]),
    );
  }

  Widget _qAndBox(String ques) {
    //Function to create TextField with correct controller and saves different variables
    _buildTextBox(String q) {
      final TextEditingController controller1 = new TextEditingController();
      final TextEditingController controller2 = new TextEditingController();
      final TextEditingController controller3 = new TextEditingController();

      if (q == questions[0]) {
        return TextField(
            controller: controller1,
            keyboardType:
                TextInputType.number, //TODO: make it so that user can exit!
            textAlign: TextAlign.center,
            onSubmitted: (String ans) {
              setState(() {
                age = int.parse(ans);
                print("age is $age");
              });
            });
      } else if (q == questions[1]) {
        return TextField(
            controller: controller2,
            keyboardType: TextInputType.number, //make it so that user can exit!
            textAlign: TextAlign.center,
            onSubmitted: (String ans) {
              setState(() {
                height = int.parse(ans);
                print("h is $height");
              });
            });
      } else if (q == questions[2]) {
        return TextField(
            controller: controller3,
            keyboardType: TextInputType.number, //make it so that user can exit!
            textAlign: TextAlign.center,
            onSubmitted: (String ans) {
              setState(() {
                weight = int.parse(ans);
              });
            });
      } else {
        print("No such thing");
      }
    } //buildTextBox

    //return Grey container with textfield
    return Material(
      color: Colors.grey,
      child: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(15.0),
                  child: Text(ques, style: TextStyle(color: Colors.white))),
              Container(
                color: Colors.white,
                width: 150.0,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(color: Colors.black, width: 1.0),
                          ),
                          child: _buildTextBox(ques)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _genderQuestion() {
    int groupValue;

    changeRadio(int e) {
      setState(() {
        if (e == 0){
          groupValue = 0;
        } else if (e == 1) {
          groupValue = 1;
        }
      });
    }

    return Material(
      child: Container(
        color: Colors.grey,
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 8.0),
                child: Text("What is your gender?",
                    style: TextStyle(
                      color: Colors.white,
                    ))),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      //male
                      activeColor: Colors.blue,
                      value: 0,
                      groupValue: groupValue,
                      onChanged: (int e) => changeRadio(e),
                    ),
                    Text (
                      "Male", style: TextStyle(color: Colors.white),
                    ),
                    Radio(
                      //female
                      activeColor: Colors.blue,
                      value: 1,
                      groupValue: groupValue,
                      onChanged: (int e) => changeRadio(e),
                    ),
                    Text (
                      "Female", style: TextStyle(color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _paQuestion() {
    List<ThirdQ> thirdQuestion = [
      ThirdQ('noX', 'Sedentary: Little to no exercise'),
      ThirdQ('lightX', 'Light: 1-3 times/week'),
      ThirdQ('moderateX', 'Moderate: 3-5 times/week'),
      ThirdQ('activeX', 'Active: daily exercise'),
    ];

    String exerTimes;

    return Material(
      child: Container(
        color: Colors.grey,
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 8.0),
                child: Text("How often do you exercise?",
                    style: TextStyle(
                      color: Colors.white,
                    ))),
            Expanded(
              //dlt
              child: Container(
                //dlt
                child: Card(
                  margin: EdgeInsets.only(top: 8.0),
                  child: Column(
                    children: List.generate(thirdQuestion.length, (int index) {
                      final using = thirdQuestion[index];
                      return GestureDetector(
                        onTapUp: (detail) {
                          setState(() {
                            exerTimes = using.identifier;
                            print(exerTimes);
                          });
                        },
                        child: Container(
                          color: exerTimes ==
                                  using
                                      .identifier //if selected, highlight colour
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
                                      onChanged: (String e) {
                                        setState(() {
                                          exerTimes = e;
                                        });
                                      }),
                                  Text(using.displayContent)
                                ],
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
  } //thirdQuestion

  // saveData (int a, int h, int w, int g, String pa) {
  //   QuestionAnswer ans = new QuestionAnswer();
  //   ans.setAge(a);
  //   ans.setHeight(h);

  // }

} //QPageState

class ThirdQ {
  final String identifier;
  final String displayContent;
  ThirdQ(this.identifier, this.displayContent);
}
