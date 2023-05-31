import 'dart:convert';
import 'dart:html';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:faniweb/main.dart';
import 'package:faniweb/menu_controller.dart';
import 'package:faniweb/dashboard/Tech/profiles/foraTech.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class editTech extends StatefulWidget {
  const editTech({required this.TechName, super.key});
  @override
  final String TechName;
  State<editTech> createState() => _editTechState();
}
var gg,dat;
String bio = "";String pt = "";
List<dynamic> servwork = [];
List<dynamic> selecServv = [];
List<String> timeSelecc = [];
String addr = "";

List<String> selecServ = [];
List<String> timeSelec = [];
DateTime ?selectedDate;

// File? imageFile;
TextEditingController naaCon = TextEditingController();
TextEditingController emmCon = TextEditingController();
TextEditingController pssCon = TextEditingController();
TextEditingController mobbC = TextEditingController();
TextEditingController dttCon = TextEditingController();
TextEditingController addrcon = TextEditingController();
TextEditingController bioController = TextEditingController();
TextEditingController priceCont = TextEditingController();
//  final formkkk = GlobalKey<FormState>();
class _editTechState extends State<editTech> {
    bool obscurede = true;
    bool obscuredw = true;
    final fok = GlobalKey<FormState>();
  Future<void> getalls(String name) async {
    final response = await http.get(
        Uri.parse('https://fani-service.onrender.com/servwork/4/?Wname=$name'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        servwork = data;
      });
      print(servwork);
    } else {
      print('Error fetching workers data: ${response.statusCode}');
    }
  }
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
  Future<void> updateWorker(String name, String password, String email,
      String gender, String phone, String date, String address) async {
    final body = jsonEncode({
      'password': password,
      'email': email,
      'gender': gender,
      'phone': phone,
      'date': date,
      'address': address
    });

    final response = await http.put(
      Uri.parse('https://fani-service.onrender.com/worker/2/$name'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode == 200) {
    } else {
      print('Failed to update worker');
    }
  }
  Future<void> updateWorkerbio(String name, String bio) async {
    final body = jsonEncode({
      'bio': bio,
    });
    final response = await http.put(
      Uri.parse('https://fani-service.onrender.com/worker/4/$name'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode == 200) {
    } else {
      print('Failed to update worker bio');
    }
  }
  Future<void> createservworker(
      String TypeServ, String Wname, String Price, List Hours) async {
    final body = jsonEncode(
        {"TypeServ": TypeServ, "Wname": Wname, "Price": Price, "Hours": Hours});
    final response = await http.post(
      Uri.parse('https://fani-service.onrender.com/servwork'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode == 200) {
      final servwork = jsonDecode(response.body);
    } else {
      print('Error: ${response.statusCode}');
    }
  }
  Future<void> getmyeWorker(String wName) async {
    priceCont = TextEditingController(text: "");
    final String url =
        'https://fani-service.onrender.com/servwork/2/?Wname=$wName';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List<dynamic> selecServ = jsonResponse;

      for (int i = 0; i < selecServ.length; i++) {
        _onServiceSelected(selecServ[i]);
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    
  }
  Future<void> deleteServworker(String TypeServ, String Wname) async {
    final body = jsonEncode({"TypeServ": TypeServ, "Wname": Wname});
    final response = await http.delete(
      Uri.parse('https://fani-service.onrender.com/servwork'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final servwork = jsonDecode(response.body);
    } else {
      print('Error deleting servwork: ${response.statusCode}');
    }
  }
  Future<void> getServiceWorker(String typeServ, String wName) async {
    priceCont = TextEditingController(text: "");
    final Uri uri = Uri.parse(
        'https://fani-service.onrender.com/servwork/1/?TypeServ=$typeServ&Wname=$wName');
    final http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> serviceWorker = jsonDecode(response.body);
      setState(() {
        List<dynamic> timeSelec = serviceWorker['Hours'];
        priceCont = TextEditingController(text: serviceWorker['Price']);
        for (int i = 0; i < timeSelec.length; i++) {
          _onTimeSelected(timeSelec[i]);
        }
      });
    } else {
      print('Failed to load service worker');
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

  
 List<String> _timeList = [
    '12-2',
    '10-12',
    '8-10',
    '4-6',
    '2-4',
  ];
  void showMyDialog(
      BuildContext context, String service, List timeSelec, String hint) {
    AwesomeDialog(
      width: 500,
      context: context,
      dismissOnTouchOutside: false,
      dialogType: DialogType.noHeader,
      animType: AnimType.BOTTOMSLIDE,
      title: 'مُنظف',
      desc: 'يرجى اختيار معلومات الخدمة:',
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 15, 0),
            child: Form(
              key: fok,
              child: Column(
                children: [
                  TextFormField(
                    controller: priceCont,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      suffixIcon: Icon(
                        Icons.attach_money,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'يرجى إدخال السعر ';
                      }
                      if (timeSelec.isEmpty) {
                        return 'يرجى اختيار وقت العمل ';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "ساعات العمل",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Wrap(
                        spacing: 18.0,
                        alignment: WrapAlignment.center,
                        children: _timeList.map((t) {
                          return FilterChip(
                            label: Text(t),
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                            backgroundColor: Color.fromARGB(227, 233, 232, 232),
                            selected: timeSelec.contains(t),
                            onSelected: (selected) {
                              setState(() {
                                _onTimeSelected(t);
                              });
                            },
                          );
                        }).toList(),
                      );
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (fok.currentState!.validate() &&
                              timeSelec.isNotEmpty) {
                            fok.currentState!.save();

                            _onServiceSelected(service);
                            await deleteServworker(service, WorW['name']);

                            await createservworker(
                                service,  WorW['name'], priceCont.text, timeSelec);
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
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 2,
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          primary: db,
                        ),
                        child: Text(
                          ' تـأكـيـد',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await deleteServworker(service, WorW['name']);
                          setState(() {
                            selecServ.remove(service);
                            timeSelec.clear();
                            priceCont = TextEditingController(text: "");
                          });

                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 2,
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          primary: dy,
                        ),
                        child: Text(
                          "حذف المهنة",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ).show();
      }
  void _onServiceSelected(String service) {
    setState(() {
      if (selecServ.contains(service)) {
      } else {
        selecServ.add(service);
      }
    });
  }
  void _onTimeSelected(String time) {
    setState(() {
      if (timeSelec.contains(time)) {
        timeSelec.remove(time);
      } else {
        timeSelec.add(time);
      }
    });
  }
 Widget builedittinfo(BuildContext context) {
    return Column(children: <Widget>[
      SizedBox(height: 15.0),
      TextField(
        controller: emmCon,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "ايميل المستخدم",
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
        obscureText: obscuredw,
        decoration: InputDecoration(
          hintText: "كلمة المرور",
          hintStyle: TextStyle(
            color: dy,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              obscuredw ? Icons.visibility_off : Icons.visibility,
              color: Colors.black12,
            ),
            onPressed: () {
              setState(() {
                obscuredw = !obscuredw;
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
      TextField(
        controller: addrcon,
        decoration: InputDecoration(
          hintText: "الموقع",
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
          await updateWorker(
            naaCon.text.toString(),
            pssCon.text.toString(),
            emmCon.text.toString(),
            gg as String,
            mobbC.text.toString(),
            // dtCon.text.toString(),
            dat as String,
            addrcon.text.toString(),
          );
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
   
  @override
  void initState() {
    super.initState();
    selecServ.clear();
    timeSelec.clear();
    servwork.clear();
    getAlltype();
    getalls(widget.TechName);
    getmyeWorker(widget.TechName);
  
    setState(() {
      addrcon=TextEditingController(text: WorW['address']);
      naaCon = TextEditingController(text: WorW['name']);
      emmCon = TextEditingController(text: WorW['email']);
      mobbC = TextEditingController(text: WorW['phone']);
      pssCon = TextEditingController(text: WorW['password']);
      bioController = TextEditingController(text: WorW['bio']);
     gg= WorW['gender'];
      bio = WorW['bio'];
        addr = WorW['address'];
      dttCon = TextEditingController(text: WorW['date']);
    });
  }
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
                image: NetworkImage(WorW['image']),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
 
  Widget build(BuildContext context) {
  Future<void> uploadImagemongo(String image, String name) async {
      final body = jsonEncode({
        'image': image,
      });
      final response = await http.put(
        Uri.parse('https://fani-service.onrender.com/worker/1/$name'),
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
              child: editTech(TechName: name),
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
      // Generate a unique filename for each uploaded image
      String filename = DateTime.now().millisecondsSinceEpoch.toString() +
          '_' +
          file.name;
      var snapshot =
          await fs.ref().child('imagesprofiles/worker/$filename').putBlob(file);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      uploadImagemongo(downloadUrl, WorW['name']);
    });
  });
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
                            child: TechPage(),
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
          actions: [
            IconButton(
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
              icon: Icon(Icons.person),
            ),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                        image: NetworkImage(WorW['image']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                SizedBox(height: 10),
                Text(
                  'الفني ${WorW['name']}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
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
                                      child: TechPage(),
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
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        maxLines: 2,
                        controller: bioController,
                        decoration: InputDecoration(
                          hintText: "السيرة الذاتية",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black45,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () async {
                        await updateWorkerbio(
                            widget.TechName, bioController.text.toString());
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
                      icon: Icon(
                        Icons.done_outlined,
                        size: 30,
                      ),
                      color: lb,
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                Container(
                  width: MediaQuery.of(context).size.width,
            
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black45,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ' اختر المهن التي تعمل بها :  ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: lb),
                      ),
                      SizedBox(height: 20.0),
                     Wrap(
  spacing: 15.0, // Horizontal spacing between FilterChip widgets
  runSpacing: 20.0, // Vertical spacing between FilterChip widgets
  alignment: WrapAlignment.center,
  children: servicesList.map((service) {
    return FilterChip(
      label: Text(service),
      labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      backgroundColor: Color.fromARGB(227, 233, 232, 232),
      selected: selecServ.contains(service),
      onSelected: (selected) async {
        await getServiceWorker(service, widget.TechName);
        if (hmf[servicesList.indexOf(service)] == false ||
            hmf[servicesList.indexOf(service)] == null) {
          pt = "سعر الساعة";
        } else {
          pt = "سعر المتر";
        }
        showMyDialog(context, service, timeSelec, pt);
        _onServiceSelected(service);
      },
    );
  }).toList(),
),

                    ],
                  ),
                ),
                SizedBox(height: 15.0),
                builedittinfo(context),
              ],
            
          ),
       
        ),
          ),   
        )
      );
 }
 Widget web() {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
        appBar: AppBar(
            toolbarHeight: 80,
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
                              child: TechPage(),
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
            actions: [
              IconButton(
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
                icon: Icon(Icons.person),
              ),
            ],
          ),
        body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
            child: Center(
              child: Column(
                children: [
              SizedBox(height: 30),
              builimg(),
              SizedBox(height: 15),
              
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
                                           child: TechPage(),
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
             //  SizedBox(height: 10),             
               Row(
                    children: [
                        Expanded(
                       child: Padding(
                         padding: EdgeInsets.fromLTRB(20, 0, 70, 5),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Row(
                                 children: [
                                   Expanded(
                                     child: TextField(
                                       maxLines: 2,
                                       controller: bioController,
                                       decoration: InputDecoration(
                                         hintText: "السيرة الذاتية",
                                         hintStyle: TextStyle(
                                           color: Colors.grey,
                                         ),
                                         enabledBorder: OutlineInputBorder(
                                           borderSide: BorderSide(
                                             color: Colors.black45,
                                           ),
                                         ),
                                         focusedBorder: OutlineInputBorder(
                                           borderSide: BorderSide(),
                                         ),
                                       ),
                                     ),
                                   ),
                                   SizedBox(
                                     width: 10,
                                   ),
                                   IconButton(
                                     onPressed: () async {
                                       await updateWorkerbio(
                                           widget.TechName, bioController.text.toString());
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
                                     icon: Icon(
                                       Icons.done_outlined,
                                       size: 30,
                                     ),
                                     color: lb,
                                   ),
                                 ],
                               ),
                               SizedBox(height: 20.0),
                               Container(
                                 width: MediaQuery.of(context).size.width,
                               
                                 decoration: BoxDecoration(
                                   border: Border.all(
                                     color: Colors.black45,
                                     width: 1,
                                   ),
                                   borderRadius: BorderRadius.circular(10),
                                 ),
                                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                 child: Column(
                                   // mainAxisSize: MainAxisSize.min,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text(
                                       ' اختر المهن التي تعمل بها :  ',
                                       style: TextStyle(
                                           fontWeight: FontWeight.bold,
                                           fontSize: 20,
                                           color: lb),
                                     ),
                                     SizedBox(height: 20.0),
                                    Wrap(
                  spacing: 40.0, // Horizontal spacing between FilterChip widgets
                  runSpacing: 40.0, // Vertical spacing between FilterChip widgets
                  alignment: WrapAlignment.center,
                  children: servicesList.map((service) {
                         return FilterChip(
                           label: Text(service),
                           labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                           backgroundColor: Color.fromARGB(227, 233, 232, 232),
                           selected: selecServ.contains(service),
                           onSelected: (selected) async {
                  await getServiceWorker(service, widget.TechName);
                  if (hmf[servicesList.indexOf(service)] == false ||
                           hmf[servicesList.indexOf(service)] == null) {
                         pt = "سعر الساعة";
                  } else {
                         pt = "سعر المتر";
                  }
                  showMyDialog(context, service, timeSelec, pt);
                  _onServiceSelected(service);
                           },
                         );
                  }).toList(),
                      ),
                             SizedBox(height: 20.0),
                      
                                   ],
                                 ),
                               ),
                               SizedBox(height: 15.0),
                           ],
                         ),
                       ),
                     ),
                   
                      Expanded(
                        child: Container(
                           padding: EdgeInsets.fromLTRB(70, 0, 20, 5),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               SizedBox(height: 30.0),
                             
                                  
                             builedittinfo(context),
                           
                            
                             ],
                           
                         ),
                            
                  ),   
                  
                      ),
                    ],
                  ),
               
                ],
              ),
            ),
          ),
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
