import 'package:faniweb/app_responsive.dart';
import 'package:faniweb/main.dart';
import 'package:faniweb/menu_controller.dart';
import 'package:faniweb/dashboard/Admin/profiles/editAdmin.dart';
import 'package:faniweb/dashboard/Admin/profiles/foradmin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Ap extends StatefulWidget {
  const Ap({super.key});

  @override
  State<Ap> createState() => _ApState();
}

// List addressList = addrr.split(',');

class _ApState extends State<Ap> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget builinfo() {
      return Container(
        height: 200,
        // width: 300,
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 247, 192, 89),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'معلومات شخصية ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'الجنس :',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  Admin['gender'],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "تاريخ الميلاد :",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  Admin['date'],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 247, 192, 89)),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget builcon() {
      return Container(
        height: 200,
        // width: 300,
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 255, 239, 91),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'معلومات الإتصال ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'الإيميل :',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  Admin['email'],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  " رقم الهاتف :",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  Admin['phone'],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 239, 91)),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: lb,
            toolbarHeight: 80,
            title: Text('صفحتي الشخصية',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            centerTitle: true,
            automaticallyImplyLeading: false),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: dy,
                    width: 3.0,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(Admin['image']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                Admin['name'],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_outlined),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MultiProvider(
                            providers: [
                              ChangeNotifierProvider(
                                  create: (context) => MenuControllerr())
                            ],
                            child: AdminPage(),
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MultiProvider(
                            providers: [
                              ChangeNotifierProvider(
                                  create: (context) => MenuControllerr())
                            ],
                            child: editAdmin(AdminName: Admin['name']),
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.exit_to_app_sharp),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MultiProvider(
                            providers: [
                              ChangeNotifierProvider(
                                  create: (context) => MenuControllerr())
                            ],
                            child: MyHomePage(),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 50),
              if (!AppResponsive.isDesktop(context)) ...{
                builinfo(),
                SizedBox(height: 20),
                // builinfo(),
                // SizedBox(height: 20),
                builcon(),
                SizedBox(height: 20),
              } else ...{
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                 
            
                    builcon(),
                    builinfo(),
                    // SizedBox(width: 15),
                  ],
                )
              }
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: lb,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'صفحتي',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'الرسائل',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.request_page,
              ),
              label: 'المهام',
            ),
          ],
          onTap: (index) {
            switch (index) {
              case 0:
                print("prof");
                break;
              case 1:
                i = 6;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(
                            create: (context) => MenuControllerr())
                      ],
                      child: AdminPage(),
                    ),
                  ),
                );
                print("viewmsgFORUSER");
                break;

              case 2:
                print("req");
                 i = 3;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(
                            create: (context) => MenuControllerr())
                      ],
                      child: AdminPage(),
                    ),
                  ),
                );
                break;
            }
          },
        ),
      ),
    );
  }
}
