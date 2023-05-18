import 'package:faniweb/app_responsive.dart';
import 'package:faniweb/main.dart';
import 'package:faniweb/menu_controller.dart';
import 'package:faniweb/dashboard/Tech/profiles/editTec.dart';
import 'package:faniweb/dashboard/Tech/profiles/foraTech.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';
class Tp extends StatefulWidget {
  const Tp({super.key,required this.workName,});
  final String workName;
  @override
  State<Tp> createState() => _TpState();
}

bool isLoading = true;
List<dynamic> servwork = [];
var imag = NetworkImage(
    'https://firebasestorage.googleapis.com/v0/b/fani-2.appspot.com/o/imagesprofiles%2Fuser.png?alt=media&token=30236ccb-7cb1-44f9-b200-4dc2a661c2a5');


class _TpState extends State<Tp> {
   Future<void> workerInfo(String name) async {
     setState(() {
    isLoading = true;
  });
    final responseW = await http
        .get(Uri.parse('https://fani-service.onrender.com/worker/2/$name'));
    if (responseW.statusCode == 200) {
      final worker = jsonDecode(responseW.body);
      setState(() {
        imag = NetworkImage(worker['image']);
        WorW = worker;
           isLoading = false;
      });
    } else {
      print("not exsist");
    }
  }

  Future<void> getalls(String name) async {
    servwork.clear();
    final response = await http.get(
        Uri.parse('https://fani-service.onrender.com/servwork/4/?Wname=$name'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        servwork = data;
      });

      // print(servwork);
    } else {
      print('Error fetching workers data: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    workerInfo(widget.workName);
    getalls(widget.workName);
  }

  @override
  Widget build(BuildContext context) {
     Widget builimg() {
      return Container(
        width: 130,
        height: 130,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: dy,
            width: 3.0,
          ),
          image: DecorationImage(
            image: imag,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    Widget builjobs() {
      return Container(
        height: 200,
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 228, 228, 226),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Text(
                'المهن التي أقوم  بها ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              if (servwork.isEmpty) ...{
                Text("لم يقم بتعين أعماله بعد"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                      style: TextStyle(
                          // fontSize: 16,
                          // fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 228, 228, 226)),
                    ),
                  ],
                ),
              } else ...{
                for (var worker in servwork)
                  Card(
                    color: Color.fromARGB(255, 228, 228, 226),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(Icons.circle, color: Colors.black, size: 17),
                            SizedBox(width: 10),
                            Text(
                              worker["TypeServ"].toString(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(width: 27),
                                Row(children: <Widget>[
                                  for (int i = 0; i < worker["rating"]; i++)
                                    Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                      size: 25,
                                    )
                                ])
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 15),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Text(
                              'ساعات العمل: ${worker['Hours'].join(', ')}',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Text(
                              ' سعر الساعة : ' + worker["Price"].toString(),
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(height: 10),
                        Text(
                          "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                          style: TextStyle(
                              // fontSize: 16,
                              // fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 228, 228, 226)),
                        ),
                      ],
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                      style: TextStyle(
                          // fontSize: 16,
                          // fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 228, 228, 226)),
                    ),
                  ],
                ),
              }
            ],
          ),
        ),
      );
    }

    Widget builbio() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 255, 239, 91),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('السيرة الذاتية :',
                style: TextStyle(
                  fontSize: 16,
                )),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 10),
                Expanded(
                  child: Text(WorW['bio'],
                      style: TextStyle(
                        fontSize: 16,
                      )),
                ),
              ],
            ),
            SizedBox(height: 10),
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
          color: Color.fromARGB(255, 247, 192, 89),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('معلومات الإتصال ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('الإيميل :',
                    style: TextStyle(
                      fontSize: 20,
                    )),
                SizedBox(
                  width: 10,
                ),
                Text(WorW['email'],
                    style: TextStyle(
                      fontSize: 16,
                    )),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(" رقم الهاتف :",
                    style: TextStyle(
                      fontSize: 20,
                    )),
                SizedBox(
                  width: 10,
                ),
                Text(WorW['phone'],
                    style: TextStyle(
                      fontSize: 16,
                    )),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('معلومات شخصية ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('الجنس :',
                    style: TextStyle(
                      fontSize: 20,
                    )),
                SizedBox(
                  width: 10,
                ),
                Text(WorW['gender'],
                    style: TextStyle(
                      fontSize: 16,
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("تاريخ الميلاد :",
                    style: TextStyle(
                      fontSize: 20,
                    )),
                SizedBox(
                  width: 10,
                ),
                Text(WorW['date'],
                    style: TextStyle(
                      fontSize: 16,
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  " المنطقة :",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  WorW['address'],
                  style: TextStyle(
                    fontSize: 16,
                  ),
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

    Widget yourContentWidget()
{
return     SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              builimg(),
              SizedBox(height: 30),
              Text(
                " الفني ${WorW['name']} ",
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
                            child: TechPage(),
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
                            child: editTech(TechName: WorW['name']),
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
                builjobs(),
                SizedBox(height: 20),
                builcon(),
                SizedBox(height: 20),
                builbio(),
                SizedBox(height: 20),
              } else ...{
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    builinfo(),
                    // SizedBox(width: 30),
                    builjobs(),
                    // SizedBox(width: 30),
                    builcon(),
                  ],
                ),
                SizedBox(height: 50),
                builbio(),
                SizedBox(height: 20),
              }
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
          title: Text('مرحبا ${WorW['name']}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          // centerTitle: true,
          // automaticallyImplyLeading: false
        ),
       body: Center(
      child: isLoading ? CircularProgressIndicator() : yourContentWidget(),
    ),
     ),
    );
  }
}