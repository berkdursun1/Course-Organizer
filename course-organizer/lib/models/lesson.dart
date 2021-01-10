class Note {
  int _id;
  String l_name;
  int que_num;
  int c_done;
  int _priority;
  String _date;

  Note(
    this.l_name,
    this.que_num,
    this.c_done,
    this._priority,
    this._date,
  );

  Note.withId(
    this._id,
    this.l_name,
    this.que_num,
    this.c_done,
    this._priority,
    this._date,
  );

  int get id => _id;

  String get name => l_name;

  int get number => que_num;

  int get priority => _priority;

  int get done => c_done;

  String get date => _date;

  set name(String newName) {
    if (newName.length <= 255) {
      this.l_name = newName;
    }
  }

  set qnum(int newNum) {
    this.que_num = newNum;
  }

  set done(int newDone) {
    this.c_done = newDone;
  }

  set priority(int newPriority) {
    if (newPriority >= 1 && newPriority <= 2) {
      this._priority = newPriority;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['l_name'] = l_name;
    map['que_num'] = que_num;
    map['c_done'] = c_done;
    map['priority'] = _priority;
    map['date'] = _date;

    return map;
  }

  // Extract a Note object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this.l_name = map['l_name'];
    this.que_num = map['que_num'];
    this.c_done = map['c_done'];
    this._priority = map['priority'];
    this._date = map['date'];
  }
}
