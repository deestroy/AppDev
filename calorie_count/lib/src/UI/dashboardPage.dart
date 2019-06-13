import 'package:calorie_count/main.dart';
import 'package:calorie_count/src/UI/calorieCalc.dart';
import 'package:calorie_count/src/UI/manualEntryPage.dart';
import 'package:calorie_count/src/UI/settingPage.dart';
import 'package:calorie_count/src/foodData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:intl/intl.dart';

import '../database.dart';

class DashboardPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return DashboardPageState();
  }
}

class DashboardPageState extends State<DashboardPage> {
  int calories;
  int breakfastLength =0, lunchLength=0, dinnerLength=0, snackLength=0;
  int caloriesRemaining = 0, caloriesConsumed = 0;
  Database db = new Database();
  var today = new DateTime.now();

  ListofFood lists = new ListofFood();

@override
  void initState() {
   _setCalories();
   _setLength();
    super.initState();
  }

  // sets the length of each list (for UI)
  _setLength() async{
    int tempBL = await getLength("Breakfast");
    int tempLL = await getLength("Lunch");
    int tempDL = await getLength("Dinner");
    int tempSL = await getLength("Snack");

    setState(() {
      breakfastLength = tempBL;
      lunchLength = tempLL;
      dinnerLength = tempDL;
      snackLength = tempSL;
    });
  }

  //sets the number of calories
  _setCalories() async {
    int temp = await db.getCalories();
    setState(() {
      print("$temp");
      calories = temp;
    });
  }

  _addDay() {
    setState(() {
      today = today.add(Duration(days: 1));
    });
  }

  _removeDay() {
    setState(() {
      today = today.add(Duration(days: -1));
    });
  }

  getData(String mealtime) async {
    String date = DateFormat.yMMMMd("en_US").format(DateTime.now());
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    QuerySnapshot querySnapshots = await Firestore.instance.collection('foodDB').document(user.uid).collection(date).document(date).collection(mealtime).getDocuments();
    
    return querySnapshots.documents;
  }

  getLength(String mealtime) async {
    String date = DateFormat.yMMMMd("en_US").format(DateTime.now());
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    QuerySnapshot querySnapshots = await Firestore.instance.collection('foodDB').document(user.uid).collection(date).document(date).collection(mealtime).getDocuments();
    
    return querySnapshots.documents.length;
  }

  @override
  Widget build(BuildContext context) {
    final ui.Size logicalSize = MediaQuery.of(context).size;
    final double screenWidth = logicalSize.width;

    return Scaffold(
      body: Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              //first row with title and settings button
              children: <Widget>[
                Padding(padding: EdgeInsets.only(bottom: 70.0)),
                Stack(
                  children: <Widget>[
                    Center(
                      child: Container(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                        width: screenWidth,
                        child: Text(
                          "Food Log",
                          style: TextStyle(fontSize: 24.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    FutureBuilder(
                        future: FirebaseAuth.instance.currentUser(),
                        builder:
                            (context, AsyncSnapshot<FirebaseUser> snapshot) {
                          if (snapshot.hasData) {
                            return Positioned(
                              //Settings button
                              right: -7.0,
                              top: 3.0,
                              bottom: 3.0,
                              child: new OutlineButton(
                                child: Container(
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image:
                                          NetworkImage(snapshot.data.photoUrl),
                                    ),
                                  ),
                                ),
                                shape: new CircleBorder(),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2.0),
                                highlightedBorderColor: Colors.grey,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => SettingPage()));
                                },
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 6.0),
            ),
            Row(
              //SECOND ROW TO CHANGE DATE
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    //minus button
                    child: new OutlineButton(
                  shape: new CircleBorder(),
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                  highlightedBorderColor: Colors.grey,
                  child: Text("-",
                      style: TextStyle(color: Colors.grey, fontSize: 20.0)),
                  onPressed: () {
                    _removeDay();
                  },
                )),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 40.0,
                    //Date display
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        border: Border.all(color: Colors.grey, width: 2.0)),
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          today = DateTime.now();
                        });
                      },
                      child:  Text(
                      DateFormat.yMMMMd("en_US").format(today),
                      style: TextStyle(fontSize: 25.0, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    )
                    
                   
                  ),
                ),
                Expanded(
                    //plus button
                    child: new OutlineButton(
                  shape: new CircleBorder(),
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                  highlightedBorderColor: Colors.grey,
                  child: Text("+",
                      style: TextStyle(color: Colors.grey, fontSize: 20.0)),
                  onPressed: () {
                    _addDay();
                  },
                ))
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Text(
                    "Calorie Goal\t$calories",
                    style: TextStyle(fontSize: 14.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    "-",
                    style: TextStyle(fontSize: 14.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    "Calories Consumed\t$caloriesConsumed",
                    style: TextStyle(fontSize: 14.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    "=",
                    style: TextStyle(fontSize: 14.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    "Calories Remaining\t$caloriesRemaining",
                    style: TextStyle(fontSize: 14.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 12.0)),
            _header("Breakfast", screenWidth),
            Row(
              children: <Widget>[
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Container(
                            height: 73.0 * breakfastLength,
                            padding: EdgeInsets.only(left: 8.0, right: 8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(color: Colors.grey)),
                            child: _foodList(lists.breakfastData, "Breakfast")))),
              ],
            ),
            _header("Lunch", screenWidth),
            Row(
              //diplays food eaten during lunch
              children: <Widget>[
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Container(
                            height: 73.0 * lunchLength,
                            padding: EdgeInsets.only(left: 8.0, right: 8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(color: Colors.grey)),
                            child: _foodList(lists.lunchData, "Lunch")
                            )
                            )
                            ),
              ],
            ),
            _header("Dinner", screenWidth),
            Row(
              //diplays food eaten
              children: <Widget>[
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Container(
                            height: 73.0 * dinnerLength,
                            padding: EdgeInsets.only(left: 8.0, right: 8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(color: Colors.grey)),
                            child: _foodList(lists.dinnerData, "Dinner")))),
              ],
            ),
            _header("Snack", screenWidth),
            Row(
              //diplays food eaten as snacks
              children: <Widget>[
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Container(
                            height: 73.0 * snackLength,
                            padding: EdgeInsets.only(left: 8.0, right: 8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(color: Colors.grey)),
                            child: _foodList(lists.snackData, "Snack"))))
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 8.0))
          ],
        ),
      ),
      ),
      );
  } //build


  _foodList(List food, String mealtime) {
    return FutureBuilder(
      future: getData(mealtime),
      builder: (context, snapshot) {
      if (!snapshot.hasData) return ListTile();
      return ListView.builder(
        padding: EdgeInsets.all(0.0),
        physics: NeverScrollableScrollPhysics(),
        itemCount: snapshot.data.length,
        itemBuilder: (_, index) => Column(
            children: <Widget>[
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(snapshot.data[index].data['foodName'],
                        style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                    Text(snapshot.data[index].data['calories'].toString(),
                        style: TextStyle(fontSize: 12.0, color: Colors.grey)),
                  ],
                ),
                subtitle: Container(
                  // padding: EdgeInsets.only(top: 5.0),
                  child: Text(snapshot.data[index].data['servingSize'].toString() + " " + snapshot.data[index].data['servingUnit'],
                      style: TextStyle(fontSize: 10.0)),
                ),
              ),
              Divider(
                height: 0.0, //no padding
              ),
            ],
          ),

      );
       
      }
    );
    


  }

  // _foodList(List food) {
  //   return ListView.builder(
  //     padding: EdgeInsets.all(0.0),
  //     physics: NeverScrollableScrollPhysics(),
  //     itemCount: food.length,
  //     itemBuilder: (context, i) => Column(
  //           children: <Widget>[
  //             ListTile(
  //               title: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: <Widget>[
  //                   Text(food[i].foodName.toString(),
  //                       style: TextStyle(fontSize: 14.0, color: Colors.grey)),
  //                   Text(food[i].calories.toString(),
  //                       style: TextStyle(fontSize: 12.0, color: Colors.grey)),
  //                 ],
  //               ),
  //               subtitle: Container(
  //                 // padding: EdgeInsets.only(top: 5.0),
  //                 child: Text(food[i].servingSize.toString() + " " + food[i].unit.toString(),
  //                     style: TextStyle(fontSize: 10.0)),
  //               ),
  //             ),
  //             Divider(
  //               height: 0.0, //no padding
  //             ),
  //           ],
  //         ),
  //   );
  // }

  //returns a Widget that displays title of meal and a plus button to add more meals
  _header(String mealTime, double screenWidth) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0),
              width: screenWidth - 20.0,
              decoration: BoxDecoration(
                  color: AppColours().coral,
                  borderRadius: BorderRadius.circular(50.0),
                  border: Border.all(color: Colors.black, width: 1.0)),
              child: Text(
                mealTime,
                style: TextStyle(fontSize: 18.0, color: Colors.white),
                textAlign: TextAlign.left,
              ),
            ),
            Positioned(
              //plus button
              right: -3.0,
              top: 5.0,
              bottom: 5.0,
              child: FloatingActionButton(
                heroTag: mealTime,
                backgroundColor: Colors.white,
                elevation: 0.0,
                child: Text(
                  "+",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  if (mealTime == "Breakfast") {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => new ManualEntry(mealTime: "Breakfast")));
                  } else if (mealTime == "Lunch") {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => new ManualEntry(mealTime: "Lunch")));
                  } else if (mealTime == "Dinner") {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => new ManualEntry(mealTime: "Dinner")));
                  } else {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => new ManualEntry(mealTime: "Snack")));
                  }
                },
              ),
            ),
          ],
        ));
  }
} //Dashboard page
