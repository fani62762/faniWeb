import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:faniweb/menu_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:faniweb/Navbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

List<Map<String, dynamic>> workers = [];
Map<String, int>? dayor;
Map<String, int>? dayorw;
int couord = 0;
List<Map<String, dynamic>> allordw = [];
List<Map<String, dynamic>> orders = [];
List<Map<String, dynamic>> users = [];
List<Map<String, dynamic>> allord = [];
List<Map<String, dynamic>> alltype = [];
List<Map<String, dynamic>> allserv = [];
List<Map<String, dynamic>> ordserv = [];
List<Map<String, dynamic>> ordservw = [];

var gwf = 0;
var guf = 0;
var gwm = 0;
var gum = 0;
var Admin;
var WorW;
int servcount = 0;
int typecount = 0;
final List<String> servicesList = [];
final List<bool> hmf = [];
List<dynamic> types = [];
int i = 0;
final Color db = Color(0xFF488FCD); //Dark blue
final Color dy = Color(0xFFF8981D); //Dark yallow
final Color ly = Color(0xFFFFCC111); //light yallow
final Color lb = Color(0xFFF0FBCD4); //light blue
final Color bgColor = Color(0xffEEF7FA);
final Color bgSideMenu = Color(0xff1A2B30);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBBywMZ93DsFNFMtnhZYZ79xquBEHrsYJw",
      databaseURL: "https://fani-2-default-rtdb.firebaseio.com",
      projectId: "fani-2",
      storageBucket: "fani-2.appspot.com",
      messagingSenderId: "532682408970",
      appId: "1:532682408970:web:e3613f6594287dc5b3cbf3",
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Web',
        theme: ThemeData(
          primaryColor: db,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.secularOneTextTheme(),
        ),
        debugShowCheckedModeBanner: false,
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => MenuControllerr())
          ],
          child: MyHomePage(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> getorday() async {
    couord = 0;
    final response = await http
        .get(Uri.parse('https://fani-service.onrender.com/ord/getday'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      setState(() {
        dayor = Map<String, int>.from(jsonResponse);
        dayor?.forEach((key, value) {
          couord += value;
        });
      });
    } else {
      print('Error fetching days data: ${response.statusCode}');
    }
  }

  Future<void> getAllWorkers() async {
    final response =
        await http.get(Uri.parse('https://fani-service.onrender.com/worker/'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      setState(() {
        workers = List<Map<String, dynamic>>.from(jsonResponse);
      });
    } else {
      print('Error fetching workers data: ${response.statusCode}');
    }
  }

  Future<void> getgw() async {
    final response = await http
        .get(Uri.parse('https://fani-service.onrender.com/worker/wgender'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      setState(() {
        gwm = data['maleCount'];
        gwf = data['femaleCount'];
      });
    } else {
      print('Error fetching workers data: ${response.statusCode}');
    }
  }

  Future<void> getAlluserss() async {
    final response =
        await http.get(Uri.parse('https://fani-service.onrender.com/users/'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      setState(() {
        users = List<Map<String, dynamic>>.from(jsonResponse);
      });
     
    } else {
      print('Error fetching workers data: ${response.statusCode}');
    }
  }

  Future<void> getAllord() async {
    final response =
        await http.get(Uri.parse('https://fani-service.onrender.com/ord/'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      setState(() {
        allord = List<Map<String, dynamic>>.from(jsonResponse);
      });
      // print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
      // print(allord);
      // print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    } else {
      print('Error fetching orders data: ${response.statusCode}');
    }
  }

  Future<void> getAlltypes() async {
    final response =
        await http.get(Uri.parse('https://fani-service.onrender.com/type/'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      setState(() {
        alltype = List<Map<String, dynamic>>.from(jsonResponse);
      });
      typecount = alltype.length;
    } else {
      print('Error fetching types data: ${response.statusCode}');
    }
  }

  Future<void> getAlltypeserv() async {
    final response =
        await http.get(Uri.parse('https://fani-service.onrender.com/serv/4/'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      setState(() {
        allserv = List<Map<String, dynamic>>.from(jsonResponse);
      });
      servcount = allserv.length;
    } else {
      print('Error fetching services data: ${response.statusCode}');
    }
  }

  Future<void> getgu() async {
    final response = await http
        .get(Uri.parse('https://fani-service.onrender.com/users/ugender'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        gum = data['maleCount'];
        guf = data['femaleCount'];
      });
    } else {
      print('Error fetching workers data: ${response.statusCode}');
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

  Future<void> ordservcount() async {
    final response = await http
        .get(Uri.parse('https://fani-service.onrender.com/ord/getservord'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      setState(() {
        ordserv = List<Map<String, dynamic>>.from(jsonResponse);
      });
    } else {
      print('Error fetching workers data: ${response.statusCode}');
    }
  }

  Future<void> getAlltype() async {
    servicesList.clear();
    final response =
        await http.get(Uri.parse('https://fani-service.onrender.com/type/3'));
    print(response);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      types = data;

      for (int i = 0; i < types.length; i++) {
        servicesList.add(types[i]['type']);
        hmf.add(types[i]['hm']);
      }
    } else {
      print('Error fetching workers data: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    getAllWorkers();
    getAlluserss();
    getgw();
    getgu();
    getAdmin();
    getAlltype();
    getorday();
    ordservcount();
    getAllord();
    getAlltypes();
    getAlltypeserv();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: yourContentWidget(),
      ),
    );
  }

  Widget yourContentWidget() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 166, 199, 227),
            Colors.white,
            ly,
            Color.fromARGB(255, 250, 240, 154),
          ],
        ),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Navbar(),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  child: Image.asset(
                    "images/aa.png",
                  )),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("     خَـــدَمَـــاتُـــنـــا  ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35.0,
                          color: Colors.black)),
                ],
              ),
              Image.asset(
                "images/c.png",
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("      تواصل معنا  ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35.0,
                          color: Colors.black)),
                ],
              ),
              Image.asset(
                "images/c.jpg",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
