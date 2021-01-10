import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Bet/screens/note_list2.dart';
import 'package:Bet/screens/note_detail_2.dart';
import 'package:Bet/models/lesson.dart';
import 'package:Bet/database/dbH.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_button/3d/3d_button.dart';

class home_scr extends StatefulWidget {
  @override
  _home_scrState createState() => _home_scrState();
}

class _home_scrState extends State<home_scr> {
  TextEditingController pick = TextEditingController();
  String date_time_p;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(
          title: Text('Hazır Mısın ?'),
        ),
        body: Column(children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.black,
              child: Center(
                  child: RaisedButton(
                      child: Text('GUN GİRİNİZ'),
                      color: Colors.yellow,
                      onPressed: () async {
                        DateTime _dateTime = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2021),
                            firstDate: DateTime(2021),
                            lastDate: DateTime(2022));
                        setState(() {
                          date_time_p = _dateTime.year.toString() +
                              '/' +
                              _dateTime.month.toString() +
                              '/' +
                              _dateTime.day.toString();
                        });
                        date_time_p = _dateTime.year.toString() +
                            '/' +
                            _dateTime.month.toString() +
                            '/' +
                            _dateTime.day.toString();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NoteList(date_time_p),
                            ));
                      })),
            ),
          ),
        ]));
  }

  void setDate() {
    date_time_p = pick.text;
  }
}

class AnimatedTextExample {
  final String label;
  final Color color;
  final Widget child;
  const AnimatedTextExample({
    @required this.label,
    @required this.color,
    @required this.child,
  });
}
