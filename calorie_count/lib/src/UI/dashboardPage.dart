import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              //first row with title and settings button
              children: <Widget>[
                Padding(padding: EdgeInsets.only(bottom: 70.0)),
                Expanded(
                    flex: 4,
                    child: Text(
                      "            Food Log",
                      style: TextStyle(fontSize: 24.0),
                      textAlign: TextAlign.center,
                    )),
                Expanded(
                    //settings button
                    flex: 1,
                    child: new OutlineButton(
                      shape: new CircleBorder(),
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      highlightedBorderColor: Colors.grey,
                      //  child: user profile picture,
                      onPressed: () {},
                    )),
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
                    "Calorie Goal\tXX",
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
            Padding(padding: EdgeInsets.only(bottom: 20.0)),
            Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0),
                  width: 350.0,
                  decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(50.0),
                      border: Border.all(color: Colors.black, width: 1.0)),
                  child: Text(
                    "Breakfast",
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                ),
                Positioned(
                  //plus button
                  right: 10.0,
                  top: 5.0,
                  child: Container(
                    height: 25.0,
                    width: 25.0,
                    child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      elevation: 0.0,
                      child: Text(
                        "+",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () => {},
                    ),
                  ),
                )
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 8.0)),
            Row(
              children: <Widget>[
                Expanded(
                    //section that displays breakfast items
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Container(
                            padding: EdgeInsets.only(left: 8.0, right: 8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(color: Colors.grey)),
                            child: Text("food")))),
              ],
            ),

            Padding(padding: EdgeInsets.only(bottom: 8.0)),
            //LUNCH SECTION
            Stack(
              children: <Widget>[
                Container(
                  //bar that says "Lunch"
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0),
                  width: 350.0,
                  decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(50.0),
                      border: Border.all(color: Colors.black, width: 1.0)),
                  child: Text(
                    "Lunch",
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                ),
                Positioned(
                  //plus button
                  right: 10.0,
                  top: 5.0,
                  child: Container(
                    height: 25.0,
                    width: 25.0,
                    child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      elevation: 0.0,
                      child: Text(
                        "+",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () => {},
                    ),
                  ),
                )
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 8.0)),
            Row(
              //diplays food eaten during lunch
              children: <Widget>[
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Container(
                            padding: EdgeInsets.only(left: 8.0, right: 8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(color: Colors.grey)),
                            child: Text("food lunch\tfood\tfood")))),
              ],
            ),

            Padding(padding: EdgeInsets.only(bottom: 8.0)),
            //LUNCH SECTION
            Stack(
              children: <Widget>[
                Container(
                  //bar that says "Lunch"
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0),
                  width: 350.0,
                  decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(50.0),
                      border: Border.all(color: Colors.black, width: 1.0)),
                  child: Text(
                    "Dinner",
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                ),
                Positioned(
                  //plus button
                  right: 10.0,
                  top: 5.0,
                  child: Container(
                    height: 25.0,
                    width: 25.0,
                    child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      elevation: 0.0,
                      child: Text(
                        "+",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () => {},
                    ),
                  ),
                )
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 8.0)),
            Row(
              //diplays food eaten during lunch
              children: <Widget>[
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Container(
                            padding: EdgeInsets.only(left: 8.0, right: 8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(color: Colors.grey)),
                            child: Text("food dinner\tfood\tfood")))),
              ],
            ),

            //add here
          ],
        ),
      ),
    );
  }
}
