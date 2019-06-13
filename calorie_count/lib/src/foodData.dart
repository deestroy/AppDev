//CHANGE 
// https://codelabs.developers.google.com/codelabs/flutter-firebase/#8
class Food {
  String foodName, unit;
  int calories, servingSize;

  Food({this.foodName, this.calories, this.servingSize, this.unit});
}

class ListofFood {

var breakfastData = <Food>[
  Food(foodName: "Medium Banana", calories: 100, servingSize: 100, unit: "g"),
  Food(foodName: "Raspberry", calories: 80, servingSize: 50),
  Food(foodName: "Boiled Egg", calories: 100, servingSize: 140),
];

var lunchData = <Food>[
  Food(foodName: "Rice", calories: 100, servingSize: 100),
  Food(foodName: "Beef", calories: 80, servingSize: 50),
  Food(foodName: "Brocolli", calories: 100, servingSize: 140),
];

var dinnerData = <Food>[
  Food(foodName: "Beef Noodle Soup", calories: 400, servingSize: 100),
  Food(foodName: "Oolong Milk Tea", calories: 80, servingSize: 50),
  Food(foodName: "Mochi", calories: 100, servingSize: 140),
];

var snackData = <Food>[
  Food(foodName: "BBQ Chips", calories: 250, servingSize: 100),
  Food(foodName: "Almonds", calories: 80, servingSize: 50),
];

}
