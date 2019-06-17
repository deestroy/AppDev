import 'package:calorie_count/main.dart';
import 'package:calorie_count/src/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ManualEntry extends StatefulWidget {
  final String mealTime;

  const ManualEntry({
    Key key,
    @required this.mealTime
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ManualEntryState();
  }
}

class ManualEntryState extends State<ManualEntry> {
  TextEditingController _foodController = new TextEditingController();
  TextEditingController _portionController = new TextEditingController();
  TextEditingController _calorieController = new TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var _formKey2 = GlobalKey<FormState>();
  var _formKey3 = GlobalKey<FormState>();
  String foodName, portionUnit, mealTime;
  int portionSize, calories, caloriesConsumed = 0;
  var units = ["g", "cups", 'mL'];
  Database _db = new Database();

  @override
  void initState() {
    mealTime = widget.mealTime; //mealTime passed through
    //_setList(mealTime);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: SingleChildScrollView(
              child: Container(
          child: Column(
            children: <Widget>[
              Align(
                  alignment: Alignment.topLeft,
                  child: BackButton(color: AppColours().offBlack)),
              Container(
                padding: EdgeInsets.only(top: 25.0, bottom: 50.0),
                child: Center(
                  child: Text(
                    "Manually enter your food",
                    style:
                        TextStyle(color: AppColours().offBlack, fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              foodQuestion(),
              Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: calorieQuestion(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: portionQuestion(),
              ),
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
                if ((foodName != null) && (portionUnit != null) && (portionSize != null) && (calories != null)) { 
                  Food newItem = Food(calories: calories, foodName: foodName, servingSize: portionSize, unit: portionUnit);
                  _db.addFood(newItem, mealTime);
                   Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                new HomePage(camera: cameras.first,)));
                }
              },
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: AppColours().coral,
            ),
          ),
            ],
          ),
        ),
      ),
    );
  } //build

  Widget foodQuestion() {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Food Name: ",
            style: TextStyle(fontSize: 16.0),
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 16.0),
              //Form that validates input
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        // width: 200.0,
                        child: TextFormField(
                            controller: _foodController,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Required';
                              }
                            },
                            onFieldSubmitted: (String a) {
                              submitted(a, "Food",_formKey,
                              );
                            }),
                      )
                    ],
                  ))),
        ],
      ),
    );
  } //inputQuestion

  Widget calorieQuestion() {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Calories: ",
            style: TextStyle(fontSize: 16.0),
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 16.0),
              //Form that validates input
              child: Form(
                  key: _formKey3,
                  child: Column(
                    children: <Widget>[
                      Container(
                        // width: 200.0,
                        child: TextFormField(
                            controller: _calorieController,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Required';
                              }
                            },
                            onFieldSubmitted: (String a) {
                              submitted(a, "Calories",_formKey3,
                              );
                            }),
                      )
                    ],
                  ))),
        ],
      ),
    );
  } //inputQuestion

  Widget portionQuestion() {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Portion Size:",
            style: TextStyle(fontSize: 16.0),
          ),
          Row(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Form(
                    key: _formKey2,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 200.0,
                          child: TextFormField(
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              controller: _portionController,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.center,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Required';
                                }
                              },
                              onFieldSubmitted: (String a) {
                                submitted(
                                  a,
                                  "Portion",
                                  _formKey2,
                                );
                              }),
                        ),
                      ],
                    ),
                  )),
              DropdownButton<String>(
                items: units.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                onChanged: (String newValue) {
                  setState(() {
                    this.portionUnit = newValue;
                  });
                },
                value: portionUnit,
              ),
            ],
          ),
        ],
      ),
    );
  } //inputQuestion

  //function that sets a varaible depending on what question was asked
  submitted(String answer, String q, GlobalKey<FormState> formKey) {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      if (q == "Food") {
        setState(() {
          foodName = answer;
        });
      } else if (q == "Portion") {
        setState(() {
          portionSize = int.parse(answer);
        });
      } else {
        setState(() {
          calories = int.parse(answer);
        });

      }
    }
  }
}
