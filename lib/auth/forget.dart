import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:faniweb/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:faniweb/main.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Forget extends StatefulWidget {
  @override
  _ForgetState createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {
  Widget buildimg() {
    return SizedBox(
      child: Image.asset(
        'images/1.png',
        height: 200,
        width: 250,
      ),
    );
  }

  Widget builarrow() {
    return Container(
      child: IconButton(
        icon: Icon(
          Icons.arrow_back,
          size: 25,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        },
      ),
    );
  }

  Future<void> resetPassword(String name) async {
    print(name);
    final response = await http.post(
      Uri.parse('https://fani-service.onrender.com/admin/forgot-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
      }),
    );
    final responseW = await http.post(
      Uri.parse('https://fani-service.onrender.com/worker/forgot-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
      }),
    );
    var data;
    if (response.statusCode == 200 || responseW.statusCode == 200) {
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
      } else {
        data = jsonDecode(responseW.body);
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: Text('تم الإرسال '),
              content: Text(data['message']),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text('تسجيل الدخول'),
                ),
              ],
            ),
          );
        },
      );
    } else if (response.statusCode == 404 || responseW.statusCode == 404) {
      if (response.statusCode == 404) {
        data = jsonDecode(response.body);
      } else {
        data = jsonDecode(responseW.body);
      }
      showDialog(
        
        context: context,
        builder: (BuildContext context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: Text('حدث خطأ  '),
              content: Text(data['message'].toString()),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('تم'),
                ),
              ],
            ),
          );
        },
      );
    } else {
      AwesomeDialog(
        width: 350,
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.BOTTOMSLIDE,
        desc: 'حدث خظأ غير متوقع الرجاء المحاوله مرة أخرى',
      ).show();
    }
  }

  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "اسم المستخدم",
          style:
              TextStyle(color: db, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextFormField(
            controller: cname2,
            // enabled: false,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(right: 14),
                hintText: 'اسم المستخدم',
                hintStyle: TextStyle(color: Colors.black38)),
            validator: (value) {
              setState(() {
                Ana = value!;
              });
            },
          ),
        )
      ],
    );
  }

  Widget buildForgotPass() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'نسيت كلمة المرور',
        style: TextStyle(
            color: Colors.black, fontSize: 44, fontWeight: FontWeight.bold),
      ),
    );
  }

  GlobalKey<FormState> ff = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    print(size.height);
    print(size.width);

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 166, 199, 227),
              Colors.white,
              Color.fromARGB(255, 250, 240, 154),
              ly
            ],
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(padding: EdgeInsets.all(32), child: builarrow()),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.copyright,
                      color: Colors.grey,
                      size: 24,
                    ),
                  ],
                ),
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (widget, animation) =>
                  ScaleTransition(child: widget, scale: animation),
              child: buil(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buil() {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.all(size.height > 770
          ? 64
          : size.height > 670
              ? 32
              : 16),
      child: Center(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: size.height *
                (size.height > 770
                    ? 0.7
                    : size.height > 670
                        ? 0.8
                        : 0.9),
            width: 500,
            color: Colors.white,
            child: Center(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: ff,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                buildimg(),
                                buildForgotPass(),
                                buildEmail(),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 25),
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (ff.currentState!.validate()) {
                                        ff.currentState!.save();
                                        resetPassword(Ana);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 5,
                                      padding: EdgeInsets.all(15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      primary: db,
                                    ),
                                    child: Text(
                                      'ارسال كلمة سر جديدة ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
