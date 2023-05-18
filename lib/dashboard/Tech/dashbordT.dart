import 'package:faniweb/app_responsive.dart';
import 'package:faniweb/dashboard/Tech/msgs/viewmsgsTA.dart';
import 'package:faniweb/dashboard/Tech/msgs/viewmsgsTW.dart';
import 'package:faniweb/dashboard/calender_widget.dart';
import 'package:faniweb/dashboard/Tech/headbarT.dart';
import 'package:faniweb/dashboard/Tech/notficationT.dart';
import 'package:faniweb/dashboard/Tech/profileT.dart';
import 'package:faniweb/dashboard/Tech/Table/empT.dart';
import 'package:faniweb/dashboard/Tech/Table/userT.dart';
import 'package:faniweb/dashboard/Tech/msgs/viewmsgTU.dart';
import 'package:faniweb/main.dart';
import 'package:flutter/material.dart';

class DashbordT extends StatefulWidget {
  @override
  _DashbordTState createState() => _DashbordTState();
}

class _DashbordTState extends State<DashbordT> {
  Widget currentTable = TableOfEmpData();
  @override
  void initState() {
    super.initState();

    setState(() {
      currentTable = _getTableForValue(i);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 213, 235, 243),
          borderRadius: BorderRadius.circular(30)),
      child: Column(
        children: [
          HeadBarT(),
          Expanded(
              child: SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      children: [
                        NotficationT(),
                        SizedBox(
                          height: 20,
                        ),
                        if (AppResponsive.isMobile(context)) ...{
                          CalenderWidget(),
                          SizedBox(
                            height: 20,
                          ),
                          ProfileT(),
                          SizedBox(
                            height: 20,
                          ),
                        },
                        currentTable,
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                if (!AppResponsive.isMobile(context))
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        CalenderWidget(),
                        SizedBox(
                          height: 20,
                        ),
                        ProfileT(),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ))
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget _getTableForValue(int value) {
    switch (value) {
      case 0:
        return TableOfEmpData();
      case 1:
        return TableOfUserData();
      case 2:
        return Text("خدمات");
      case 3:
        return Text("طلبات");
      case 4:
        return Text("إحصائيات");
      case 5:
        return Text("تقارير");
      case 6:
        return TmsgsT();
      case 9:
        return TmsgsU();
      case 10:
        return TmsgsA();
      default:
        // Show some default table or an error message
        return TableOfEmpData();
    }
  }
}
