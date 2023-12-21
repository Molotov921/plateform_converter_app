import 'package:platform_converter_ios_android/model/date_model.dart';
import 'package:platform_converter_ios_android/model/month_model.dart';
import 'package:platform_converter_ios_android/model/time_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MonthProvider extends ChangeNotifier {
  DateModel dateModel = DateModel(date: '');
  TimeModel timeModel = TimeModel(timeOfDay: '');
  List<MonthModel> monthName = [
    MonthModel(month: 'Jan'),
    MonthModel(month: 'Feb'),
    MonthModel(month: 'Mar'),
    MonthModel(month: 'Apr'),
    MonthModel(month: 'May'),
    MonthModel(month: 'Jun'),
    MonthModel(month: 'Jul'),
    MonthModel(month: 'Aug'),
    MonthModel(month: 'Sep'),
    MonthModel(month: 'Oct'),
    MonthModel(month: 'Nav'),
    MonthModel(month: 'Dec'),
  ];

  DateTime dateTime = DateTime.now();
  bool dateChecked = false;
  bool iDateChecked = false;
  TimeOfDay timeOfDay = TimeOfDay.now();
  bool timeChecked = false;
  bool iTimeChecked = false;

  String iDate() {
    return '${dateTime.day}, ${monthName.elementAt(dateTime.month - 1).month} ${dateTime.year}';
  }

  void iDateFind(context) async {
    iDateChecked = true;
    await showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          color: CupertinoColors.black,
          child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime dateTime) {
                dateModel.date =
                    '${dateTime.day}, ${monthName.elementAt(dateTime.month - 1).month} ${dateTime.year}';
              }),
        );
      },
    );
    notifyListeners();
  }

  String iTime() {
    return '${dateTime.hour % 12}:${dateTime.minute % 60} ${(dateTime.hour >= 12) ? 'PM' : 'AM'}';
  }

  void iTimeFind(context) async {
    iTimeChecked = true;
    await showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          color: CupertinoColors.black,
          child: CupertinoDatePicker(
            use24hFormat: false,
            mode: CupertinoDatePickerMode.time,
            onDateTimeChanged: (DateTime dateTime) {
              if (dateTime.hour >= 1 && dateTime.hour <= 11) {
                timeModel.timeOfDay =
                    '${dateTime.hour}:${dateTime.minute % 60} ${(dateTime.hour >= 12) ? 'PM' : 'AM'}';
              } else if (dateTime.hour > 12 && dateTime.hour <= 23) {
                timeModel.timeOfDay =
                    '${dateTime.hour % 12}:${dateTime.minute % 60} ${(dateTime.hour >= 12) ? 'PM' : 'AM'}';
              } else if ((dateTime.hour % 12) == 0) {
                timeModel.timeOfDay =
                    '${(dateTime.hour % 12) + 12}:${dateTime.minute % 60} ${(dateTime.hour >= 12) ? 'PM' : 'AM'}';
              } else if (dateTime.hour == 24) {
                timeModel.timeOfDay =
                    '${(dateTime.hour % 12) + 12}:${dateTime.minute % 60} ${(dateTime.hour >= 12) ? 'PM' : 'AM'}';
              }
            },
          ),
        );
      },
    );
    notifyListeners();
  }

  void dateFind1(context) async {
    dateChecked = true;
    DateTime? res = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      initialDatePickerMode: DatePickerMode.day,
      initialEntryMode: DatePickerEntryMode.calendar,
    );
    dateModel.date =
        '${res!.day},${monthName.elementAt(res.month - 1).month} ${res.year}';
    notifyListeners();
  }

  String dateFind() {
    return '${dateTime.day},${monthName.elementAt(dateTime.month - 1).month} ${dateTime.year}';
  }

  void timeFind1(context) async {
    timeChecked = true;
    TimeOfDay? res = await showTimePicker(
      context: context,
      initialTime: timeOfDay,
    );

    if (res!.hour >= 1 && res.hour <= 11) {
      timeModel.timeOfDay =
          '${res.hour}:${res.minute % 60} ${(res.hour >= 12) ? 'PM' : 'AM'}';
    } else if (res.hour > 12 && res.hour <= 23) {
      timeModel.timeOfDay =
          '${res.hour % 12}:${res.minute % 60} ${(res.hour >= 12) ? 'PM' : 'AM'}';
    } else if ((res.hour % 12) == 0) {
      timeModel.timeOfDay =
          '${(res.hour % 12) + 12}:${res.minute % 60} ${(res.hour >= 12) ? 'PM' : 'AM'}';
    } else if (res.hour == 24) {
      timeModel.timeOfDay =
          '${(res.hour % 12) + 12}:${res.minute % 60} ${(res.hour >= 12) ? 'PM' : 'AM'}';
    }

    notifyListeners();
  }

  String timeFind() {
    return '${timeOfDay.hour % 12}:${timeOfDay.minute % 60} ${timeOfDay.period.name}';
  }
}
