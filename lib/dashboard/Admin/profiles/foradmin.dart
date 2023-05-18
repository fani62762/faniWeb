import 'dart:convert';
import 'package:faniweb/app_responsive.dart';
import 'package:faniweb/dashboard/Admin/dashbord.dart';
import 'package:faniweb/menu_controller.dart';
import 'package:faniweb/dashboard/Admin/side_bar_menu.dart';
import 'package:flutter/material.dart';
import 'package:faniweb/main.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: SideBar(),
        key: Provider.of<MenuControllerr>(context, listen: false).scaffuldKey,
        backgroundColor: bgColor,
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (AppResponsive.isDesktop(context)) Expanded(child: SideBar()),
              Expanded(flex: 4, child: Dashbord())
            ],
          ),
        ),
      ),
    );
  }
}
