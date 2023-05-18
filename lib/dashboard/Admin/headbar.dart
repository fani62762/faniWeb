import 'package:faniweb/app_responsive.dart';
import 'package:faniweb/main.dart';
import 'package:faniweb/menu_controller.dart';
import 'package:faniweb/dashboard/Admin/profiles/foradmin.dart';
import 'package:faniweb/dashboard/Admin/profiles/AdmP.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeadBar extends StatefulWidget {
  @override
  _HeadBarState createState() => _HeadBarState();
}

class _HeadBarState extends State<HeadBar> {
  void _onItemPre(int index) {
    if (index == 8) {
      i = index;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => MenuControllerr())
            ],
            child: MyHomePage(),
          ),
        ),
      );
    } else if (index == 7) {
      print(index);
      i = index;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => MenuControllerr())
            ],
            child: Ap(),
          ),
        ),
      );
    } else {
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
      });
    }
    print(i);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          if (!AppResponsive.isDesktop(context))
            IconButton(
                icon: Icon(Icons.menu, color: bgSideMenu),
                onPressed: Provider.of<MenuControllerr>(context, listen: false)
                    .controlMenu),
          Text(
            "Dashboard",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Row(
            children: [
              navIcon(Icons.message, 6),
              navIcon(Icons.account_circle_outlined, 7),
              navIcon(Icons.logout, 8),
            ],
          )
        ],
      ),
    );
  }

  Widget navIcon(IconData icon, int index) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: IconButton(
        icon: Icon(
          icon,
          color: Colors.black,
        ),
        onPressed: () {
          _onItemPre(index);
        },
      ),
    );
  }
}
