import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task/models/schadule.dart';

class Userprovider extends ChangeNotifier {
  String errormassage = "";
  List<Schadule> scadules = [];
  TextEditingController tittle = TextEditingController();
  TextEditingController task = TextEditingController();
  List hoursto = [];
  List hoursfrom = [];
  int from;
  int to;
  String date;
  DateTime selectedDatedialog = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  dynamic colorvalue;
  clearall() {
    selectedDatedialog = DateTime.now();
    task.clear();
    tittle.clear();
    colorvalue = null;
    from = null;
    to = null;
    date = null;
  }

  getavailablehours() {
    hoursfrom = [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22,
      23,
      24,
    ];
    hoursto = [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22,
      23,
      24,
    ];
    List tasks = scadules
        .where(
            (element) => element.date == formatter.format(selectedDatedialog))
        .toList();
    ;
    print(tasks);

    tasks.forEach((element) {
      hoursfrom.removeRange(
          hoursfrom.indexOf(element.from), hoursfrom.indexOf(element.to));
      hoursto.removeRange(
          hoursto.indexOf(element.from), hoursto.indexOf(element.to));
    });

    notifyListeners();
  }

  // List getallavailablehourto() {
  //   List to = tohours;
  //   List tasks = getlistofschadules();
  //   tasks.forEach((element) {
  //     to.removeRange(element.from, element.to);
  //   });

  //   return to;
  // }

  addtoschadule(BuildContext context) {
    print(tittle.text);
    print(task.text);

    if (tittle.text != "") {
      if (task.text != "") {
        if (from != null && to != null) {
          if (from < to) {
            bool flag = false;
            List tasks = scadules
                .where((element) =>
                    element.date == formatter.format(selectedDatedialog))
                .toList();
            print(tasks);
            for (var tsk in tasks) {
              if (tsk.from >= from && tsk.to <= to) {
                flag = true;
                break;
              }
            }
            if (!flag) {
              errormassage = "";
              scadules.add(
                  Schadule(date, tittle.text, task.text, from, to, colorvalue));
              print(scadules);
              notifyListeners();
              clearall();
              Navigator.pop(context);
            } else {
              errormassage = "cant interscact the time";
              notifyListeners();
            }
          } else {
            errormassage = "from time cant pass to time ";
            notifyListeners();
          }
        } else {
          errormassage = "times can't be empty";
          notifyListeners();
        }
      } else {
        errormassage = "task can't be empty";
        notifyListeners();
      }
    } else {
      errormassage = "tittle can't be empty";
      notifyListeners();
    }
  }

  void setselectedDatedialog(DateTime userdate) {
    print(formatter.format(userdate));
    date = formatter.format(userdate);
    selectedDatedialog = userdate;
    notifyListeners();
  }

  setcolorvalue(dynamic color) {
    colorvalue = color;
    notifyListeners();
  }

  List<Schadule> getlistofschadules() {
    List list = scadules
        .where((element) => element.date == formatter.format(selectedDate))
        .toList();
    list.sort((a, b) => a.from.compareTo(b.from));
    return list;
  }

  DateTime selectedDate = DateTime.now().subtract(Duration(days: 0));
  void setdate(DateTime userdate) {
    print(formatter.format(userdate));
    selectedDate = userdate;
    notifyListeners();
  }

  void setfrom(int userindex) {
    from = userindex;
    print(from);
    notifyListeners();
  }

  void setto(int userindex) {
    to = userindex;
    notifyListeners();
  }

  addschdule(Schadule sc) {
    scadules.add(sc);
    notifyListeners();
  }
}
