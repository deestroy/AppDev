import 'package:calorie_count/main.dart';
import 'package:calorie_count/src/foodData.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ui.Size logicalSize = MediaQuery.of(context).size;
    final double screenWidth = logicalSize.width;

    return new Scaffold(
        body: Container(
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
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
                    Positioned(
                      //Settings button
                      right: -7.0,
                      top: 3.0,
                      bottom: 3.0,
                      child: new OutlineButton(
                        child: Text("S"),
                        shape: new CircleBorder(),
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                        highlightedBorderColor: Colors.grey,
                        // child: user profile picture,
                        onPressed: () {
                          Navigator.pushNamed(context, '/setting');
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
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
                  child: Text("+",
                      style: TextStyle(color: Colors.grey, fontSize: 20.0)),
                  onPressed: () {},
                )),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 40.0,
                    //Date display
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        border: Border.all(color: Colors.grey, width: 2.0)),
                    child: Text(
                      "Date",
                      style: TextStyle(fontSize: 25.0, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
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
                  onPressed: () {},
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
                    "Calorie Goal\tXX", //TODO: Pull numbers
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
                    "Calories Consumed\tXX",
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
                    "Calories Remaining\tXX",
                    style: TextStyle(fontSize: 14.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 12.0)),

            /////////////////
            _header("Breakfast", screenWidth),
            Row(
              children: <Widget>[
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Container(
                            height: 73.0 * breakfastData.length,
                            padding: EdgeInsets.only(left: 8.0, right: 8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(color: Colors.grey)),
                            child: _foodList(breakfastData)))),
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
                            height: 73.0 * lunchData.length,
                            padding: EdgeInsets.only(left: 8.0, right: 8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(color: Colors.grey)),
                            child: _foodList(lunchData)))),
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
                            height: 73.0 * dinnerData.length,
                            padding: EdgeInsets.only(left: 8.0, right: 8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(color: Colors.grey)),
                            child: _foodList(dinnerData)))),
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
                            height: 73.0 * snackData.length,
                            padding: EdgeInsets.only(left: 8.0, right: 8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(color: Colors.grey)),
                            child: _foodList(snackData))))
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 8.0))
          ],
        ),
      ),
    ));
  } //build

  _foodList(List food) {
    return ListView.builder(
      padding: EdgeInsets.all(0.0),
      physics: NeverScrollableScrollPhysics(),
      itemCount: food.length,
      itemBuilder: (context, i) => Column(
            children: <Widget>[
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(food[i].foodName.toString(),
                        style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                    Text(food[i].calories.toString(),
                        style: TextStyle(fontSize: 12.0, color: Colors.grey)),
                  ],
                ),
                subtitle: Container(
                  // padding: EdgeInsets.only(top: 5.0),
                  child: Text(food[i].servingSize.toString(),
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
                onPressed: () => {},
              ),
            ),
          ],
        ));
  }
} //Dashboard page
