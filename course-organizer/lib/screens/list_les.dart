import 'dart:async';
import 'package:flutter/material.dart';
import 'package:Bet/models/lesson.dart';
import 'package:Bet/database/dbH.dart';
import 'package:Bet/screens/add_les.dart';
import 'package:sqflite/sqflite.dart';

class NoteList extends StatefulWidget {
  String date_time_p;
  @override
  State<StatefulWidget> createState() {
    return NoteListState(this.date_time_p);
  }

  NoteList(this.date_time_p);
}

class NoteListState extends State<NoteList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  String date_time_p;

  List<Note> noteList;
  int count = 0;
  NoteListState(this.date_time_p);
  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(date_time_p),
        actions: [
          IconButton(
              icon: Icon(Icons.date_range),
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
              })
        ],
      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB clicked');
          navigateToDetail(Note('deneme', 0, 0, 2, date_time_p), date_time_p);
        },
        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getNoteListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          margin: EdgeInsets.all(10),
          color: Colors.white,
          elevation: 2.0,
          child: date_time_p == noteList[position].date
              ? ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        getPriorityColor(this.noteList[position].priority),
                    child: Icon(this.noteList[position].c_done == 1
                        ? Icons.done
                        : Icons.error),
                  ),
                  title: Text(this.noteList[position].l_name == null
                      ? "Deneme"
                      : this.noteList[position].l_name),
                  trailing: GestureDetector(
                    child: Icon(
                      Icons.delete,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      _delete(context, noteList[position]);
                    },
                  ),
                  onTap: () {
                    debugPrint("ListTile Tapped");
                    navigateToDetail(this.noteList[position], 'Edit Note');
                  },
                )
              : null,
        );
      },
    );
  }

  // Returns the priority color
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;

      default:
        return Colors.yellow;
    }
  }

  // Returns the priority icon
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void _delete(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      _showSnackBar(context, 'Note Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Note note, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(note, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}
