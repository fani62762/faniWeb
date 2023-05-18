import 'dart:convert';
import 'package:faniweb/app_responsive.dart';
import 'package:faniweb/dashboard/Tech/dashbordT.dart';
import 'package:faniweb/menu_controller.dart';
import 'package:faniweb/dashboard/Tech/side_bar_menuT.dart';
import 'package:flutter/material.dart';
import 'package:faniweb/main.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class TechPage extends StatefulWidget {
  const TechPage({Key? key}) : super(key: key);

  @override
  _TechPageState createState() => _TechPageState();
}

class _TechPageState extends State<TechPage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: SideBarT(),
        key: Provider.of<MenuControllerr>(context, listen: false).scaffuldKey,
        backgroundColor: bgColor,
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (AppResponsive.isDesktop(context)) Expanded(child: SideBarT()),
              Expanded(flex: 4, child: DashbordT())
            ],
          ),
        ),
      ),
    );
  }
}
