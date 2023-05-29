import 'dart:convert';
import 'dart:html';
import 'package:faniweb/main.dart';
import 'package:faniweb/menu_controller.dart';
import 'package:faniweb/dashboard/Admin/profiles/AdmP.dart';
import 'package:faniweb/dashboard/Admin/profiles/foradmin.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class editAdmin extends StatefulWidget {
  const editAdmin({required this.AdminName, super.key});
  @override
  final String AdminName;
  State<editAdmin> createState() => _editAdminState();
}
var gg,dat,xm;
DateTime ?selectedDate;

// File? imageFile;
TextEditingController naaCon = TextEditingController();
TextEditingController emmCon = TextEditingController();
TextEditingController pssCon = TextEditingController();
TextEditingController mobbC = TextEditingController();
TextEditingController dttCon = TextEditingController();
//  final formkkk = GlobalKey<FormState>();
class _editAdminState extends State<editAdmin> {
 
  void initState() {
    super.initState();
    setState(() {
      naaCon = TextEditingController(text: Admin['name']);
      emmCon = TextEditingController(text: Admin['email']);
      mobbC = TextEditingController(text: Admin['phone']);
      pssCon = TextEditingController(text: Admin['password']);
     gg= Admin['gender'];
     xm= Admin['image'];
      dttCon = TextEditingController(text: Admin['date']);
    });
  }

  bool obscurede = true;
  @override
  Future<void> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
    // You can customize the date picker appearance and behavior further if needed
  );
  if (picked != null && picked != selectedDate) {
    setState(() {
      selectedDate = picked;
        dat =
                          "${picked.year.toString()}-${picked.month.toString()}-${picked.day.toString()}";
                           dttCon = TextEditingController(text:"${picked.year.toString()}-${picked.month.toString()}-${picked.day.toString()}");
    });
  }
}

  Widget build(BuildContext context) {
    Future<void> uploadImagemongo(String image, String name) async {
      final body = jsonEncode({
        'image': image,
      });
      final response = await http.put(
        Uri.parse('https://fani-service.onrender.com/admin/1/$name'),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => MenuControllerr())
              ],
              child: editAdmin(AdminName: name),
            ),
          ),
        );
      } else {
        print('Failed to update worker image');
      }
    }

    Future<void> uploadImage() async {
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
          var snapshot =
              await fs.ref().child('imagesprofiles/admin').putBlob(file);
          String downloadUrl = await snapshot.ref.getDownloadURL();
          uploadImagemongo(downloadUrl, Admin['name']);
        });
      });
    }

    Future<void> getAdmin() async {
      final responseW =
          await http.get(Uri.parse('https://fani-service.onrender.com/admin/'));
      if (responseW.statusCode == 200) {
        final ad = jsonDecode(responseW.body);
        setState(() {
          Admin = ad;
        });
      } else {
        print("not exsist");
      }
    }

    Future<void> updateAdmin(String name, String password, String email,
        String gender, String phone, String date) async {
      final body = jsonEncode({
        'name': name,
        'password': password,
        'email': email,
        'gender': gender,
        'phone': phone,
        'date': date
      });

      final response = await http.put(
        Uri.parse('https://fani-service.onrender.com/admin/2/$name'),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        await getAdmin();
        print('User updated successfully');
      } else {
        print('Failed to update User');
      }
    }

    Widget builedittinfo() {
      return Column(children: <Widget>[
        SizedBox(height: 15.0),
        TextField(
          controller: emmCon,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: "ايميل المُدير",
            hintStyle: TextStyle(
              color: dy,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: db,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: dy,
              ),
            ),
          ),
        ),
        SizedBox(height: 15.0),
        TextField(
          controller: pssCon,
          obscureText: obscurede,
          decoration: InputDecoration(
            hintText: "كلمة المرور",
            hintStyle: TextStyle(
              color: dy,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                obscurede ? Icons.visibility_off : Icons.visibility,
                color: Colors.black12,
              ),
              onPressed: () {
                setState(() {
                  obscurede = !obscurede;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: db,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: dy,
              ),
            ),
          ),
        ),
        SizedBox(height: 15.0),
        TextField(
          controller: mobbC,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: "رقم الهاتف",
            hintStyle: TextStyle(
              color: dy,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: db,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: dy,
              ),
            ),
          ),
        ),
      SizedBox(height: 15.0),
     GestureDetector(
  onTap: () {
    _selectDate(context);
  },
  child: AbsorbPointer(
    child: TextField(
      controller: dttCon,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: "تاريخ الميلاد",
        hintStyle: TextStyle(
          color: dy,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: db,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: dy,
          ),
        ),
      ),
    ),
  ),
),
   SizedBox(height: 15.0),
       DropdownButtonFormField<String>(
         value: gg,
         decoration: InputDecoration(
           labelText: 'اختر الجنس',
           icon: Icon(Icons.person),
         ),
         items: [
           DropdownMenuItem<String>(
             value: 'ذكر',
             child: Center(child: Text('ذكر')),
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

       
        SizedBox(height: 15.0),
        ElevatedButton(
          onPressed: () async {
            await updateAdmin(
              naaCon.text.toString(),
              pssCon.text.toString(),
              emmCon.text.toString(),
             gg as String,
              mobbC.text.toString(),
              dat as String,
            );

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                        create: (context) => MenuControllerr())
                  ],
                  child: editAdmin(AdminName: naaCon.text.toString()),
                ),
              ),
            );
          },
          child: Text(
            'تعديل المعلومات الشخصية',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          style: ElevatedButton.styleFrom(
            primary: lb,
          ),
        ),
      ]);
    }

    Widget mob() {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(
                            create: (context) => MenuControllerr())
                      ],
                      child: Ap(),
                    ),
                  ),
                );
              },
            ),
            title: Text(
              'تعديل صفحتي الشخصية',
              style: TextStyle(fontSize: 20),
            ),
            backgroundColor: dy,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.0),
                  Container(
                    alignment: Alignment.center,
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: dy,
                        width: 3.0,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(xm),
                        fit: BoxFit.cover,
                      ),
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
                        icon: Icon(Icons.camera_alt),
                        onPressed: uploadImage,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    Admin['name'],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  builedittinfo(),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20.0),
                        Container(
                          alignment: Alignment.center,
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
                                            create: (context) =>
                                                MenuControllerr())
                                      ],
                                      child: AdminPage(),
                                    ),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.camera_alt),
                              onPressed: uploadImage,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          Admin['name'],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        builedittinfo(),
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

    print(MediaQuery.of(context).size.width);
    if (MediaQuery.of(context).size.width < 850) {
      return mob();
    } else {
      return web();
    }
  }
}
