import 'package:calorie_count/main.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  
    return new Scaffold(
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
                    Container(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      
                      width: 375.0,
                      child: Text(
                        "Food Log",
                        style: TextStyle(fontSize: 24.0),
                        textAlign: TextAlign.center,
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
                        //  child: user profile picture,
                        onPressed: () {},
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
                  //TODO: CHANGE TO ICON
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
            _header("Breakfast"),
            Padding(padding: EdgeInsets.only(bottom: 8.0)),
            Row(
              children: <Widget>[
                Expanded(
                    //section that displays food items
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Container(
                          padding: EdgeInsets.only(left: 8.0, right: 8.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(color: Colors.grey)),
                          child: DataTable(
                              columns: <DataColumn>[
                                DataColumn(
                                  numeric: false,
                                  label: Text(""),
                                ),
                                DataColumn(
                                  numeric: false,
                                  label: Text(""),
                                ),
                              ],
                              rows: breakfastData
                                  .map((food) => DataRow(cells: [
                                        DataCell(
                                            Text(
                                              food.foodName,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                                
                                            ),
                                            showEditIcon: false,
                                            placeholder: false),
                                        DataCell(
                                            Text(
                                              food.calories.toString(),
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                                  textAlign: TextAlign.right,
                                            ),
                                            showEditIcon: false,
                                            placeholder: false)
                                      ]))
                                  .toList()),
                        ))),
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 8.0)),
            _header("Lunch"),
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
            _header("Dinner"),
            Padding(padding: EdgeInsets.only(bottom: 8.0)),
            Row(
              //diplays food eaten
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
            Padding(padding: EdgeInsets.only(bottom: 8.0)),
            _header("Snack"),
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
                            child: Text(
                                "food snack\tfood\tfood\tlllll\tl\tl\tl\tl\tl\tl\tl\tl")))),
              ],
            ),

            //add here
          ],
        ),
      ),
    ));
  } //build

  //returns a Widget that displays title of meal and a plus button to add more meals
  _header(String mealTime) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0),
          width: 350.0,
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
    );
  }
} //Dashboard page

class BreaskfastFood {
  String foodName;
  int calories;
  int servingSize;

  BreaskfastFood({this.foodName, this.calories, this.servingSize});
}

var breakfastData = <BreaskfastFood>[
  BreaskfastFood(foodName: "Medium Banana", calories: 100, servingSize: 100),
  BreaskfastFood(foodName: "Raspberry", calories: 80, servingSize: 50),
  BreaskfastFood(foodName: "Boiled Egg", calories: 100, servingSize: 140),
];
