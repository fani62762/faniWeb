import 'package:faniweb/app_responsive.dart';
import 'package:faniweb/dashboard/Admin/Table/calcu.dart';
import 'package:faniweb/dashboard/calender_widget.dart';
import 'package:faniweb/dashboard/Admin/headbar.dart';
import 'package:faniweb/dashboard/Admin/notfication.dart';
import 'package:faniweb/dashboard/Admin/profile.dart';
import 'package:faniweb/dashboard/Admin/Table/empT.dart';
import 'package:faniweb/dashboard/Admin/Table/userT.dart';
import 'package:faniweb/dashboard/Admin/msgs/viewmsgAU.dart';
import 'package:faniweb/dashboard/Admin/msgs/viewmsgsAW.dart';
import 'package:faniweb/main.dart';
import 'package:flutter/material.dart';

class Dashbord extends StatefulWidget {
  @override
  _DashbordState createState() => _DashbordState();
}

class _DashbordState extends State<Dashbord> {
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
          HeadBar(),
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
                     if (i!=4)   Notfication(),
                     if (i!=4)     SizedBox(
                          height: 20,
                        ),
                        if (AppResponsive.isMobile(context)) ...{
                          CalenderWidget(),
                          SizedBox(
                            height: 20,
                          ),
                          Profile(),
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
                        Profile(),
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
        return maths();
      case 5:
        return Text("تقارير");
      case 6:
        return AmsgsT();
      case 9:
        return AmsgsU();
      default:
        // Show some default table or an error message
        return TableOfEmpData();
    }
  }
}
