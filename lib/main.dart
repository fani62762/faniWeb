import 'dart:async';

import 'package:faniweb/menu_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:faniweb/Navbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

List<Map<String, dynamic>> workers = [];
List<Map<String, dynamic>> users = [];

var Admin;
var WorW;
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
    getAdmin();
    getAlltype();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:yourContentWidget(),
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
            Color.fromARGB(255, 250, 240, 154),
            ly
          ],
        ),
      ),
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
                const Icon(
                  Icons.local_florist_outlined,
                  size: 30.0,
                  color: Colors.black,
                ),
                const Text("     خَـــدَمَـــاتُـــنـــا  ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                        color: Colors.black)),
              ],
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: Image.asset(
                  "images/c.png",
                )),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.local_florist_outlined,
                  size: 30.0,
                  color: Colors.black,
                ),
                const Text("     مــن نــحــن  ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                        color: Colors.black)),
              ],
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: Image.asset(
                  "images/aa.png",
                )),
          ],
        ),
      ),
    );
  }
}
