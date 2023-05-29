import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:faniweb/app_responsive.dart';
import 'package:faniweb/main.dart';
import 'package:faniweb/menu_controller.dart';
import 'package:faniweb/dashboard/Admin/profiles/AdminSeeUser.dart';
import 'package:faniweb/dashboard/Admin/profiles/foradmin.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:html';

class TableOfUserData extends StatefulWidget {
  @override
  _TableOfUserDataState createState() => _TableOfUserDataState();
}
 var ph, nn, pas,gg;
class _TableOfUserDataState extends State<TableOfUserData> {
  List<Map<String, dynamic>> filteredWorkers = [...users];
  TextEditingController searchController = TextEditingController();
var serverToken="AAAAfAZYhAo:APA91bH4KtyI1wyJVnYjT6FU60RLY2Vfu0U0mXlMCa-Hq_2lYuZtL5imkfVrAw8Yb2xWvbf0X5GSUjSd8K2-Wo4W4au8jhl_oqT2d7DTBHXJh5nu8JXbBnJy1A3c1RnD9zh0R_fekvdI";
Future<void> sendNotificationToAll(String title, String body,String name) async {
  final url = Uri.parse('https://fcm.googleapis.com/fcm/send');

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=$serverToken',
  };

  final notification = {
    'body': body,
    'title': title,
  };

  final message = {
    'notification': notification,
    'priority': 'high',
    'to': '/topics/all',
    'data': <String, dynamic>{
'click_action': 'FLUTTER_NOTIFICATION_CLICK',

"name":name
},
  };

  final response = await http.post(
    url,
    headers: headers,
    body: jsonEncode(message),
  );

  if (response.statusCode == 200) {
    print('Notification sent successfully');
  } else {
    print('Failed to send notification. Status code: ${response.statusCode}');
  }
}
  void filterWorkers(String query) {
    setState(() {
      filteredWorkers = users
          .where((w) =>
              w['name'].toLowerCase().contains(query.toLowerCase().trim()) ||
              w['email'].toLowerCase().contains(query.toLowerCase().trim()))
          .toList();
    });
  }
  Future<void> deleteOrders(String uname) async {
   final url = Uri.parse('https://fani-service.onrender.com/ord/delseordsuser/$uname');
  final response = await http.delete(url);
  if (response.statusCode == 200) {
    print('Orders deleted successfully');
  } else {
    print('Failed to delete orders. Status code: ${response.statusCode}');
  }
}
    Future<void> retrieveWorkerByUser(String uname) async {
  final response = await http.get(Uri.parse('https://fani-service.onrender.com/ord/retrieveWnams/$uname'));
  
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    
    for (var Wname in jsonResponse) {
      await sendNotificationToAll(
        "حذف مستخدم",
        "تم حذف العامل $uname للحفاظ على الجودة قم بإعادة حجز طلبك لدى عامل اخر",
        Wname,
      );
    }
  } else {
    print('Error fetching workers data: ${response.statusCode}');
  }
}

 
  static const String signupUrl = 'https://fani-service.onrender.com/users';
 Future<void> delluseremail(String name) async {
    print(name);
    final response = await http.post(
      Uri.parse('https://fani-service.onrender.com/worker/deluseremail'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
      }),
    );
  
      await retrieveWorkerByUser(name);
      await deleteUser(name);
      await deleteOrders(name);
    
  }
  Future<void> deleteUser(String name) async {
  print(name);
    final response = await http.delete(Uri.parse('https://fani-service.onrender.com/users/$name'));
    if (response.statusCode == 200) {
      final deletedWorker = jsonDecode(response.body);
      
    await getAlluserss();
        Fluttertoast.showToast(
                                          msg: "تمت حذف المستخدم وارسال ايميل له",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 3,
                                   
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      setState(() {
                                        Navigator.pop(context);
                                          i = 1;
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
    
    } else {
      print('Failed to delete user. Status code: ${response.statusCode}');
    }
  
}
  Future<void> createworker(String name,  String password,
      String phone, String gen) async {
    final body = jsonEncode({
      'name': name,
      'password': password,
      'phone': phone,
      'gender': gen,
    });
    final response = await http.post(
      Uri.parse(signupUrl),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode == 200) {
    await getAlluserss();
       Fluttertoast.showToast(
                                          msg: "تمت إضافة المستخدم",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 2,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      setState(() {
                                        Navigator.pop(context);
                                          i = 1;
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
    } else {
      print('Error: ${response.statusCode}');
    }
  }
 Future<bool> fetchUserByName(String name) async {
    final response = await http
        .get(Uri.parse('https://fani-service.onrender.com/users/2/$name'));
    final responseW = await http
        .get(Uri.parse('https://fani-service.onrender.com/worker/2/$name'));
    if (response.statusCode == 200) {
  
      return (true);
    } else if (responseW.statusCode == 200) {
      
      return (true);
    } else {
      print("not exsist");
      return (false);
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

   @override
  void initState() {
    super.initState();
    getAlluserss();
 
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: searchController,
            onChanged: (value) => filterWorkers(value),
            decoration: InputDecoration(
              hintText: 'ابحث من خلال اسم أو إيميل العَميل',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  searchController.clear();
                  filterWorkers('');
                },
              ),
            ),
          ),
          SizedBox(height: 10),
          DataTable(
            columnSpacing: 12,
            dataRowHeight: 60,
            dividerThickness: 1,
            columns: [
              DataColumn(
                label: Text('الاسم',style: TextStyle(fontFamily: 'Times New Roman')),
              ),
              DataColumn(label: _verticalDivider),
              DataColumn(
                label: Text('الايميل',style: TextStyle(fontFamily: 'Times New Roman')),
                numeric: true,
              ),
              DataColumn(label: _verticalDivider),
              DataColumn(
                label: Text('الهاتف',style: TextStyle(fontFamily: 'Times New Roman')),
                numeric: true,
              ),
              if (AppResponsive.isDesktop(context)) ...{
                DataColumn(label: _verticalDivider),
                DataColumn(
                  label: Text('الجنس',style: TextStyle(fontFamily: 'Times New Roman')),
                ),
                DataColumn(label: _verticalDivider),
                DataColumn(
                  label: Text('معلومات',style: TextStyle(fontFamily: 'Times New Roman')),
                ),
                DataColumn(label: _verticalDivider),
                DataColumn(
                  label: SizedBox(),
                  numeric: true,
                ),
              }
            ],
            rows: filteredWorkers.map((user) {
              return DataRow(
                cells: [
                  if (MediaQuery.of(context).size.width > 1480)
                    DataCell(
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(user['image']),
                          ),
                          SizedBox(width: 10),
                          Text(user['name']),
                        ],
                      ),
                    ),
                  if (MediaQuery.of(context).size.width <= 1480)
                    DataCell(Text(user['name'])),
                  DataCell(_verticalDivider),
                  DataCell(Text(user['email'])),
                  DataCell(_verticalDivider),
                  DataCell(Text(user['phone'])),
                  if (AppResponsive.isDesktop(context)) ...{
                    DataCell(_verticalDivider),
                    DataCell(Text(user['gender'])),
                    DataCell(_verticalDivider),
                    DataCell(IconButton(
                      icon: Icon(Icons.info_outline),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MultiProvider(
                              providers: [
                                ChangeNotifierProvider(
                                    create: (context) => MenuControllerr())
                              ],
                              child: AsU(userName: user['name']),
                            ),
                          ),
                        );
                      },
                    )),
                    DataCell(_verticalDivider),
                    DataCell(IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async{
                        
                         await delluseremail(user['name']);
                    
                    
                  
                      },
                    )),
                  }
                ],
              );
            }).toList(),
          ),
          SizedBox(height: 10,),
          RawMaterialButton(
        onPressed: () {
showDialog(
  context: context,
  builder: (BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        scrollable: true,
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    'اضافة مستخدم جديد',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              //  SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) => nn = value,
                  decoration: const InputDecoration(
                    labelText: 'اسم المستخدم',
                    icon: Icon(Icons.account_box),
                  ),
                ),
                TextFormField(
                  onChanged: (value) => ph = value,
                  decoration: const InputDecoration(
                    labelText: 'رقم الجوال',
                    icon: Icon(Icons.phone),
                  ),
                ),
                TextFormField(
                  onChanged: (value) => pas = value,
                  decoration: InputDecoration(
                    labelText: 'كلمة السر',
                    icon: Icon(Icons.password),
                  ),
                ),
                   SizedBox(height: 5),
                DropdownButtonFormField<String>(
                  value: gg,
                  decoration: InputDecoration(
                    labelText: 'اختر الجنس',
                    icon: Icon(Icons.person),
                  ),
                  items: [
                    
                    DropdownMenuItem<String>(
                      value: 'ذكر',
                      child: Center( child: Text('ذكر')),
                    ),
                    DropdownMenuItem<String>(
                      value: 'أنثى',
                      child: Center(child: Text('أنثى')),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      gg = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          Center(
            child: Column(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(dy), // Set the desired background color
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Set the desired border radius
                      ),
                    ),
                  ),
                  child: Text("اضافة"),
                  onPressed: () async {
                bool isExist = await fetchUserByName(nn);
                    if (gg== null||nn== null||pas== null||ph== null) {
                      AwesomeDialog(
                        width: 350,
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.BOTTOMSLIDE,
                        desc: 'الرجاءادخال المعلومات ',
                      ).show();
                    } else if (isExist == true) {
                                AwesomeDialog(
                                  width: 350,
                                  context: context,
                                  dialogType: DialogType.info,
                                  animType: AnimType.BOTTOMSLIDE,
                                  desc: 'صاحب هذا الاسم لديه حساب بالفعل ',
                                ).show();
                              }
                     else {
                      await createworker(
                        nn,pas,ph,gg
                         );
                         

                    
                     
                    }
                  
                  },
                ),
                SizedBox(height: 10), // Add space of 10 pixels after the button
              ],
            ),
          ),
        ],
      ),
    );
  },
);

},

                elevation: 2.0,
                fillColor: lb,
                padding: EdgeInsets.all(10.0),
                shape: CircleBorder(),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 24.0,
                ),
              ),
   
        ],
      ),
    );
  }

  Widget _verticalDivider = const VerticalDivider(
    color: Colors.grey,
    thickness: .5,
  );
}
