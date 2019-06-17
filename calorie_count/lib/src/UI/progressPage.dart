import 'package:calorie_count/src/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class ProgressPage extends StatelessWidget {
  Database _db = new Database();

  getData(String mealtime) async {
    String date = DateFormat.yMMMMd("en_US").format(DateTime.now());
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    QuerySnapshot querySnapshots = await Firestore.instance.collection('foodDB').document(user.uid).collection(date).document(date).collection(mealtime).getDocuments();
  return querySnapshots.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      

    );
  }
}

