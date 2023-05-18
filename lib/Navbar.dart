import 'package:faniweb/app_responsive.dart';
import 'package:faniweb/menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:faniweb/auth/login.dart';
import 'package:faniweb/main.dart';
import 'package:provider/provider.dart';

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            // color: Color.fromARGB(255, 253, 252, 252),
            height: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (AppResponsive.isDesktop(context))
                  Container(
                    width: 160,
                    height: 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/1.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                TextButton(
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
                  child: const Text(
                    "الرئيسية",
                    style: TextStyle(
                      color: Color.fromARGB(255, 16, 92, 154),
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
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
                  child: const Text(
                    "خدماتنا",
                    style: TextStyle(
                      color: Color.fromARGB(255, 16, 92, 154),
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
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
                  child: const Text(
                    "من نحن",
                    style: TextStyle(
                      color: Color.fromARGB(255, 16, 92, 154),
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    );
                  },
                  child: Text(
                    'تسجيل الدخول',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 15, vertical: 10)),
                    backgroundColor: MaterialStateProperty.all<Color>(dy),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
