import 'package:faniweb/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderWidget extends StatefulWidget {
  @override
  _CalenderWidgetState createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromARGB(246, 246, 252, 255),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${DateFormat("MMM, yyyy").format(_dateTime)}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _dateTime =
                            DateTime(_dateTime.year, _dateTime.month - 1);
                      });
                    },
                    child: Icon(Icons.chevron_left, color: Colors.black),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _dateTime =
                            DateTime(_dateTime.year, _dateTime.month + 1);
                      });
                    },
                    child: Icon(Icons.chevron_right, color: Colors.black),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TableCalendar(
            focusedDay: _dateTime,
            firstDay: DateTime.utc(2009),
            lastDay: DateTime.utc(2050),
            headerVisible: false,
            onFormatChanged: (result) {},
            daysOfWeekStyle: DaysOfWeekStyle(
                dowTextFormatter: (date, local) {
                  return DateFormat("EEE").format(date).toUpperCase();
                },
                weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
                weekendStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: dy)),
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(color: lb, shape: BoxShape.circle),
              markerDecoration:
                  BoxDecoration(color: lb, shape: BoxShape.circle),
            ),
            onPageChanged: (theDate) {
              _dateTime = theDate;
              setState(() {});
            },
          )
        ],
      ),
    );
  }
}
