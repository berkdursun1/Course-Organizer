import 'package:Bet/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'screens/home_screen.dart';
import 'screens/list_les.dart';

void main() {
  runApp(bet_cal());
}

class bet_cal extends StatefulWidget {
  @override
  _bet_calState createState() => _bet_calState();
}

class _bet_calState extends State<bet_cal> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteKeeper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: NoteList(DateTime.now().year.toString() +
          '/' +
          DateTime.now().month.toString() +
          '/' +
          DateTime.now().day.toString()),
    );
  }
}
