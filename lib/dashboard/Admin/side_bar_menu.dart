import 'package:faniweb/main.dart';
import 'package:faniweb/menu_controller.dart';
import 'package:faniweb/dashboard/Admin/profiles/foradmin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  void _onItemTapped(int index) {
    setState(() {
      i = index;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => MenuControllerr())
            ],
            child: AdminPage(),
          ),
        ),
      );
      print(i);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.symmetric(
              vertical: BorderSide(
            color: Colors.grey,
          )),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 65,
              ),
              ListTile(
                selected: i == 0,
                leading: Icon(Icons.people),
                title: Text(
                  'الـفَـنـيـيـن',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'El Messiri'),
                ),
                onTap: () {
                  _onItemTapped(0);
                },
              ),
              SizedBox(
                height: 35,
              ),
              ListTile(
                selected: i == 1,
                leading: Icon(Icons.person),
                title: Text(
                  'الـعُـمَلاء',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'El Messiri'),
                ),
                onTap: () {
                  _onItemTapped(1);
                },
              ),
              SizedBox(
                height: 35,
              ),
              ListTile(
                selected: i == 2,
                leading: Icon(Icons.miscellaneous_services_sharp),
                title: Text(
                  'الخدمات',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'El Messiri'),
                ),
                onTap: () {
                  _onItemTapped(2);
                },
              ),
              SizedBox(
                height: 35,
              ),
              ListTile(
                selected: i == 3,
                leading: Icon(Icons.shopping_cart),
                title: Text(
                  'الـطَـلـبـات',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'El Messiri'),
                ),
                onTap: () {
                  _onItemTapped(3);
                },
              ),
              SizedBox(
                height: 35,
              ),
              ListTile(
                selected: i == 4,
                leading: Icon(Icons.bar_chart),
                title: Text(
                  'الإحـصـائـيـات',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'El Messiri'),
                ),
                onTap: () {
                  _onItemTapped(4);
                },
              ),
              SizedBox(
                height: 35,
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}
