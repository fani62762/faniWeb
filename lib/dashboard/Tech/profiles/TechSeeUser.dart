import 'dart:convert';
import 'package:faniweb/app_responsive.dart';
import 'package:flutter/material.dart';
import 'package:faniweb/main.dart';
import 'package:http/http.dart' as http;
import 'dart:async'; // import the dart:async library

class TsU extends StatefulWidget {
  const TsU({
    super.key,
    required this.userName,
  });
  final String userName;
  @override
  State<TsU> createState() => _TsUState();
}
bool isLoading = true;

var user;
var imag = NetworkImage(
    'https://firebasestorage.googleapis.com/v0/b/fani-2.appspot.com/o/imagesprofiles%2Fuser.png?alt=media&token=30236ccb-7cb1-44f9-b200-4dc2a661c2a5');

class _TsUState extends State<TsU> {
  Future<void> userInfo(String name) async {
     setState(() {
    isLoading = true;
  });
    final responseW = await http
          .get(Uri.parse('https://fani-service.onrender.com/users/2/$name'));
    if (responseW.statusCode == 200) {
      final use = jsonDecode(responseW.body);
      setState(() {
        imag = NetworkImage(use['image']);
        user = use;
           isLoading = false;
      });
    } else {
      print("not exsist");
    }
  }


  @override
  void initState() {
    super.initState();
    userInfo(widget.userName);
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
                Text(user['email'],
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
                Text(user['phone'],
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
                Text(user['gender'],
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
                Text(user['date'],
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
                  user['address'],
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
            // crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 20),
              builimg(),
              SizedBox(height: 20),
              Text(
                " المستخدم ${user['name']} ",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 70),
              if (!AppResponsive.isDesktop(context)) ...{
                  SizedBox(height: 20),
                builinfo(),
                SizedBox(height: 20),
                
                builcon(),
                SizedBox(height: 20),
              
              } else ...{
                Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      SizedBox(height: 20),
                    builinfo(),
                    builcon(),
                  ],
                ),
              
                SizedBox(height: 70),
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
