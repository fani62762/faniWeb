import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:faniweb/menu_controller.dart';
import 'package:faniweb/dashboard/Tech/profiles/foraTech.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:faniweb/main.dart';
import 'package:flutter/services.dart';
import 'package:faniweb/dashboard/Admin/profiles/foradmin.dart';
import 'package:faniweb/auth/forget.dart';
import 'package:provider/provider.dart';

String Ana = "";
String Apass = "";
GlobalKey<FormState> formkk = GlobalKey<FormState>();
final TextEditingController cname2 = TextEditingController();
final TextEditingController cpass2 = TextEditingController();

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
   Future<void> getWork(String name) async {
    final responseW = await http
        .get(Uri.parse('https://fani-service.onrender.com/worker/2/$name'));
    if (responseW.statusCode == 200) {
      final worker = jsonDecode(responseW.body);
      setState(() {
   WorW = worker;
      });
    } else {
      print("not exsist");
    }
  }

  Future<void> getAdmin() async {

    final responseW =
        await http.get(Uri.parse('https://fani-service.onrender.com/admin/'));
    if (responseW.statusCode == 200) {
      
      setState(() {
        final ad = jsonDecode(responseW.body);
        Admin = ad;

      });
    } else {
      print("not exsist");
    }
  }
  Future<void> submitCredentialsm(String name, String password) async {
  //   final response = await http.post(
  //     Uri.parse('https://fani-service.onrender.com/admin/login'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({
  //       'name': name,
  //       'password': password,
  //     }),
  //   );

  //   if (response.statusCode == 200) {
  // await getAdmin();
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

  //   } else if (response.statusCode == 401) {
  //     final message = jsonDecode(response.body)['message'];
  //     if (message == 'Invalid nameAdmin') {
  //       AwesomeDialog(
  //         width: 350,
  //         context: context,
  //         dialogType: DialogType.info,
  //         animType: AnimType.BOTTOMSLIDE,
  //         desc: "اسم الادمين غير صحيح",
  //       ).show();
  //     } else if (message == 'Invalid passwordU') {
  //       AwesomeDialog(
  //         width: 350,
  //         context: context,
  //         dialogType: DialogType.info,
  //         animType: AnimType.BOTTOMSLIDE,
  //         desc: ' كلمة المرور خاطئة',
  //       ).show();
  //     } else {
  //       AwesomeDialog(
  //         width: 350,
  //         context: context,
  //         dialogType: DialogType.info,
  //         animType: AnimType.BOTTOMSLIDE,
  //          desc: 'الاسم أو كلمة المرورو غير صحيحات',
  //       ).show();
  //     }
  //   }
  }

  Future<void> submitCredentialsw(String name, String password) async {
    print(name);
    final response = await http.post(
      Uri.parse('https://fani-service.onrender.com/worker/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
    
  await getWork(name);
       Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => MenuControllerr())
          ],
          child: TechPage(),
        ),
      ),
    );
    } else if (response.statusCode == 401) {
      final message = jsonDecode(response.body)['message'];
      if (message == 'Invalid nameU') {
        AwesomeDialog(
          width: 350,
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.BOTTOMSLIDE,
          desc: 'الاسم غير مسجل قم بانشاء حساب',
        ).show();
      } else if (message == 'Invalid passwordU') {
        AwesomeDialog(
          width: 350,
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.BOTTOMSLIDE,
          desc: ' كلمة المرور خاطئة',
        ).show();
      } else {
        AwesomeDialog(
          width: 350,
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.BOTTOMSLIDE,
          desc: 'الاسم أو كلمة المرورو غير صحيحات',
        ).show();
      }
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
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.person, color: dy),
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

  Widget buildimg() {
    return SizedBox(
      child: Image.asset(
        'images/1.png',
        height: 280,
        width: 280,
      ),
    );
  }

  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'كلمة المرور',
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
            controller: cpass2,
            obscureText: true,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.lock, color: dy),
                hintText: 'كلمة المرور',
                hintStyle: TextStyle(color: Colors.black38)),
            validator: (value) {
              setState(() {
                Apass = value!;
              });
            },
          ),
        )
      ],
    );
  }

  Widget buildForgotPassBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          formkk.currentState!.save();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Forget()));
          print("نسيت كلمة المرور");
        },
        child: Text(
          'نسيت كلمة المرور',
          style: TextStyle(color: db, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      child: ElevatedButton(
        onPressed: () {
          if (formkk.currentState!.validate()) {
            print(" formkk.currentState!.save();");
            formkk.currentState!.save();
            submitCredentialsw(cname2.text.toString(), cpass2.text.toString());
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
          'تسجيل الدخول كفَني',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildLoginBtnm() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      child: ElevatedButton(
        onPressed: () {
          if (formkk.currentState!.validate()) {
            formkk.currentState!.save();
            submitCredentialsm(cname2.text.toString(), cpass2.text.toString());
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
          '  تسجيل الدخول كمدير',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget mob() {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: GestureDetector(
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 166, 199, 227),
                      Colors.white,
                      Color.fromARGB(255, 250, 240, 154),
                      Color.fromARGB(255, 255, 182, 74)
                    ],
                  )),
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: formkk,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                buildimg(),
                                buildEmail(),
                                SizedBox(height: 20),
                                buildPassword(),
                              ]),
                        ),
                        SizedBox(height: 10),
                        buildForgotPassBtn(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildLoginBtnm(),
                            SizedBox(
                              width: 15,
                            ),
                            buildLoginBtn(),
                          ],
                        ),
                      ],
                    ),

                    ///
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget web() {
    return Scaffold(
      body: Row(
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        key: formkk,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              buildEmail(),
                              SizedBox(height: 20),
                              buildPassword(),
                            ]),
                      ),
                      SizedBox(height: 10),
                      buildForgotPassBtn(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildLoginBtnm(),
                          SizedBox(
                            width: 15,
                          ),
                          buildLoginBtn(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
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
              child: Center(
                child: Image.asset(
                  'images/1.png', // replace this with your logo image asset path
                  width: MediaQuery.of(context).size.width * .6,
                  height: MediaQuery.of(context).size.height * .6,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    if (MediaQuery.of(context).size.width < 850) {
      return mob();
    } else {
      return web();
    }
  }
}
