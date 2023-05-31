import 'dart:convert';
import 'dart:html';

import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:faniweb/main.dart';
import 'package:faniweb/menu_controller.dart';

import 'package:faniweb/dashboard/Admin/profiles/foradmin.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class tableserv extends StatefulWidget {
  @override
  _tableservState createState() => _tableservState();
}
var sub;
var newtype;

class _tableservState extends State<tableserv> {

 Future<void> createserv(String name, String type) async {
    final body = jsonEncode({
      'name': name,
      'type': type,
    });
    final response = await http.post(
      Uri.parse('https://fani-service.onrender.com/serv/1/'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode == 200) {
       await getAlltypes();
       Fluttertoast.showToast(
                                          msg: "تمت إضافة خدمة جديد",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 2,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      setState(() {
                                        Navigator.pop(context);
                                          i = 2;
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
        AwesomeDialog(
                        width: 350,
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.BOTTOMSLIDE,
                        desc: 'هذه الخدمة موجودة بالفعل ',
                      ).show();
      print('Error: ${response.statusCode}');
    }
  }

  Future<void> createtype(String? type) async {
    final body = jsonEncode({'type': type});
    final response = await http.post(
      Uri.parse('https://fani-service.onrender.com/type/1/'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode == 200) {
    await getAlltypes();
       Fluttertoast.showToast(
                                          msg: "تمت إضافة نوع جديد",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 2,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      setState(() {
                                        Navigator.pop(context);
                                          i = 2;
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
       AwesomeDialog(
                        width: 350,
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.BOTTOMSLIDE,
                        desc: 'هذا النوع موجودة بالفعل ',
                      ).show();
      print('Error: ${response.statusCode}');
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
Future<void> uploadImagemongo(String image, String type,String name)async {
      final body = jsonEncode({
        'avatar': image,
      });
      final response = await http.put(
        Uri.parse('https://fani-service.onrender.com/serv/1/$name/$type'),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      if (response.statusCode == 200) {
       await getAlltypeserv();
       Fluttertoast.showToast(
                                          msg: "تم تحديث الصورة",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 2,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      setState(() {
                                        Navigator.pop(context);
                                          i = 2;
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
        print('Failed to update worker image');
      }
    }



Future<void> uploadImage(String type, String serv) async {
  FileUploadInputElement input = FileUploadInputElement()
    ..accept = 'image/*';
  InputElement inputElement = input as InputElement;
  FirebaseStorage fs = FirebaseStorage.instance;
  inputElement.click();
  inputElement.onChange.listen((event) {
    final file = inputElement.files!.first;
    final reader = FileReader();
    reader.readAsDataUrl(file);
    reader.onLoadEnd.listen((event) async {
      // Generate a unique filename for each uploaded image
      String filename = DateTime.now().millisecondsSinceEpoch.toString() +
          '_' +
          file.name;
      var snapshot = await fs.ref().child('servi/$filename').putBlob(file);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      uploadImagemongo(downloadUrl, type, serv);
    });
  });
}

 Future<void> uploadImagemongotype(String image, String type)async {
      final body = jsonEncode({
        'avatar': image,
      });
      final response = await http.put(
        Uri.parse('https://fani-service.onrender.com/type/1/$type'),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      if (response.statusCode == 200) {
       await getAlltypes();
       Fluttertoast.showToast(
                                          msg: "تمت تحديث الصورة  ",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 2,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      setState(() {
                                        Navigator.pop(context);
                                          i = 2;
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
        print('Failed to update worker image');
      }
    }



Future<void> uploadImagetype(String type) async {
  FileUploadInputElement input = FileUploadInputElement()
    ..accept = 'image/*';
  InputElement inputElement = input as InputElement;
  FirebaseStorage fs = FirebaseStorage.instance;
  inputElement.click();
  inputElement.onChange.listen((event) {
    final file = inputElement.files!.first;
    final reader = FileReader();
    reader.readAsDataUrl(file);
    reader.onLoadEnd.listen((event) async {
      // Generate a unique filename for each uploaded image
      String filename = DateTime.now().millisecondsSinceEpoch.toString() +
          '_' +
          file.name;
      var snapshot = await fs.ref().child('type/$filename').putBlob(file);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      uploadImagemongotype(downloadUrl,type);
    });
  });
}

 
   @override
  void initState() {
    super.initState();
    getAlltypeserv() ;
    getAlltypes();
 
 
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(20),
         child: Column(
        children: [
          Column(
  children: List.generate(alltype.length, (index) {
    Map<String, dynamic> type = alltype[index];
    List<Map<String, dynamic>> typeServices = allserv.where((service) {
      final serviceType = service['type'];
      final targetType = type['type'];
      final areEqual = targetType == serviceType;

     return areEqual;
    }).toList();

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(
          color: Colors.black, // Set the desired border color
          width: 1, // Set the desired border width
        ),
      ),
      child: ExpansionTile(
        title: Text(type['type']),
        children: [
          Column(
            children: List.generate(typeServices.length, (index) {
              Map<String, dynamic> service = typeServices[index];
              return ListTile(
  title: Text(service['name']),
  trailing: IconButton(
    icon: Icon(Icons.camera),
    onPressed: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              width: 200,
              height: 200,
             child: Image.network(
  service['avatar'],
  width: 80,
  height: 90,
  ),
            ),
            actions: <Widget>[
             
              TextButton(
                child: Text('إغلاق'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
               TextButton(
                child: Text('تغير'),
                onPressed: () {
                 uploadImage(service['type'],service['name']);
                 
                },
              ),
            ],
          );
        },
      );
    },
  ),
);

            }),
            
          ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
             
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
                        'اضافة خدمة جديدة',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextFormField(
                      onChanged: (value) => sub = value,
                      decoration: const InputDecoration(
                        labelText: 'اسم الخدمة',
                        icon: Icon(Icons.miscellaneous_services_sharp),
                      ),
                    ),
        SizedBox(height: 16),
            Row(
                  children:[
                    SizedBox(width:3 ,),
                   Text("النوع  : ") ,
                   SizedBox(width: 5,),
                  Text(  type['type']),
                  ]
                  
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
             
                        if (sub== null) {
                          AwesomeDialog(
                            width: 350,
                            context: context,
                            dialogType: DialogType.info,
                            animType: AnimType.BOTTOMSLIDE,
                            desc: 'الرجاءادخال المعلومات ',
                          ).show();
                        }
                         else {
                          await createserv(
                            sub,  type['type']
                             );
                  
                           
                        }
                      
                      },
                    ),
                    SizedBox(height: 10), 
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
                    fillColor: dy,
                    padding: EdgeInsets.all(10.0),
                    shape: CircleBorder(),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 24.0,
                    ),
                  ),
                    IconButton(
                    
                    
                    icon: Icon(Icons.image),
    onPressed: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              width: 200,
              height: 200,
             child: Image.network(
  type['avatar'],
  width: 80,
  height: 90,
),
            ),
            actions: <Widget>[
             
              TextButton(
                child: Text('إغلاق'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
               TextButton(
                child: Text('تغير'),
                onPressed: () {
                 uploadImagetype(type['type']);
                 
                },
              ),
            ],
          );
        },
      );
    },
  
                  ),
                    SizedBox(width: 15,),
                ],
              ),
      SizedBox(height: 10,),
        ],
      ),
      
    );
  }),
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
                    'اضافة نوع جديدة',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextFormField(
                  onChanged: (value) => newtype = value,
                  decoration: const InputDecoration(
                    labelText: ' النوع',
                    icon: Icon(Icons.miscellaneous_services_sharp),
                  ),
                ),
        SizedBox(height: 16),
            
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
             
                    if (newtype== null) {
                      AwesomeDialog(
                        width: 350,
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.BOTTOMSLIDE,
                        desc: 'الرجاءادخال المعلومات ',
                      ).show();
                    }
                     else {
                      await createtype(
                        newtype
                         );
              
                       
                    }
                  
                  },
                ),
                SizedBox(height: 10), 
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


}
