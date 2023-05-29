import 'dart:convert';
import 'package:faniweb/app_responsive.dart';
import 'package:flutter/material.dart';
import 'package:faniweb/main.dart';
import 'package:http/http.dart' as http;
import 'dart:async'; // import the dart:async library

List<Map<String, dynamic>> userord = [];

class AsU extends StatefulWidget {
  const AsU({
    super.key,
    required this.userName,
  });
  final String userName;
  @override
  State<AsU> createState() => _AsUState();
}

bool isLoading = true;
bool showAdditionalInfo = false;

var user;
var imag = NetworkImage(
    'https://firebasestorage.googleapis.com/v0/b/fani-2.appspot.com/o/imagesprofiles%2Fuser.png?alt=media&token=30236ccb-7cb1-44f9-b200-4dc2a661c2a5');

class _AsUState extends State<AsU> {
  Future<void> getuserord(String uname) async {
    final response = await http
        .get(Uri.parse('https://fani-service.onrender.com/ord/11/$uname'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      setState(() {
        userord = List<Map<String, dynamic>>.from(jsonResponse);
      });
      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
      print(userord);
      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    } else {
      print('Error fetching user orders data: ${response.statusCode}');
    }
  }

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
    getuserord(widget.userName);
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
            color: Colors.black,
            width: 1.5,
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
        height: 300,
        // width: 300,
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 255, 238, 127),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
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
                Text("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 238, 127),
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
                      color: Color.fromARGB(255, 255, 238, 127)),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget builinfo() {
      return Container(
        height: 300,
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
            SizedBox(
              height: 20,
            ),
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

    Widget orders() {
      return Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 228, 228, 226),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 20),
                Text(
                  'الخدمات التي قام ${user['name']} بطلبها مني',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ArabicFont',
                  ),
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: userord.length,
                  itemBuilder: (context, index) {
                    final order = userord[index];

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 10),
                        Text(
                          "الخدمة: ${order['TypeServ']}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 228, 228, 226),
                            fontFamily: 'ArabicFont',
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        IconButton(
                          icon: Icon(Icons.info),
                          onPressed: () {
                            // Handle showing/hiding additional information for this order
                            setState(() {
                              showAdditionalInfo = !showAdditionalInfo;
                            });
                          },
                        ),
                      ],
                    );
                  },
                ),
                // Add additional information here (hidden by default)
                if (showAdditionalInfo) ...[
                  SizedBox(height: 10),
                  for (final order in userord)
                    Column(
                      children: [
                        Text(
                          "الساعة: ${order['Hour']}",
                          style: TextStyle(
                            fontFamily: 'ArabicFont',
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        Text(
                          "السعر: ${order['Price']}",
                          style: TextStyle(
                            fontFamily: 'ArabicFont',
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        Text(
                          "التاريخ: ${order['date']}",
                          style: TextStyle(
                            fontFamily: 'ArabicFont',
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        // Display additional service details here
                        // Display repeated order information here
                      ],
                    ),
                ],
              ],
            ),
          ),
        ),
      );
      //     return Container(
      //       height: 300,
      //       // width: 300,
      //       margin: EdgeInsets.symmetric(horizontal: 20),
      //       padding: EdgeInsets.all(10),
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(10),
      //          color: Color.fromARGB(255, 228, 228, 226),
      //       ),
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //          children: [
      //   SizedBox(height: 20),
      //   Text(
      //     'الخدمات التي قام ${user['name']} بطلبها مني',
      //     style: TextStyle(
      //       fontSize: 20,
      //       fontWeight: FontWeight.bold,
      //       fontFamily: 'ArabicFont', // Replace with your Arabic font
      //     ),
      //     textDirection: TextDirection.rtl,
      //   ),
      //   SizedBox(height: 10),
      //   ListView.builder(
      //     shrinkWrap: true,
      //     physics: NeverScrollableScrollPhysics(),
      //     itemCount: userord.length,
      //     itemBuilder: (context, index) {
      //       final order = userord[index];

      //       return Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           SizedBox(width: 10),
      //           Text(
      //             "الخدمة: ${order['TypeServ']}",
      //             style: TextStyle(
      //               fontSize: 16,
      //               fontWeight: FontWeight.bold,
      //               color: Color.fromARGB(255, 228, 228, 226),
      //               fontFamily: 'ArabicFont', // Replace with your Arabic font
      //             ),
      //             textDirection: TextDirection.rtl,
      //           ),
      //           IconButton(
      //             icon: Icon(Icons.info),
      //             onPressed: () {
      //               // Handle showing/hiding additional information for this order
      //               showAdditionalInfo=!showAdditionalInfo;
      //             },
      //           ),
      //         ],
      //       );
      //     },
      //   ),
      // ],
      //   ),
      //   // Add additional information here (hidden by default)
      //   if (showAdditionalInfo)
      //     Column(
      //       children: [
      //         SizedBox(height: 10),
      //         Text(
      //           "الساعة: ${userord['hour']}",
      //           style: TextStyle(
      //             fontFamily: 'ArabicFont', // Replace with your Arabic font
      //           ),
      //           textDirection: TextDirection.rtl,
      //         ),
      //         Text(
      //           "السعر: ${userord['price']}",
      //           style: TextStyle(
      //             fontFamily: 'ArabicFont', // Replace with your Arabic font
      //           ),
      //           textDirection: TextDirection.rtl,
      //         ),
      //         Text(
      //           "التاريخ: ${userord['date']}",
      //           style: TextStyle(
      //             fontFamily: 'ArabicFont', // Replace with your Arabic font
      //           ),
      //           textDirection: TextDirection.rtl,
      //         ),
      //         // Display additional service details here
      //         // Display repeated order information here
      //       ],
      //     ),
      //],
      // children: [
      //    SizedBox(
      //             height: 20,
      //           ),
      //   Text('الخدمات التي قام ${user['name']}  بطلبها مني',
      //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

      //   SizedBox(height: 10),
      //   Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       SizedBox(
      //         width: 10,
      //       ),
      //       Text(
      //         "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
      //         style: TextStyle(
      //             fontSize: 16,
      //             fontWeight: FontWeight.bold,
      //               color: Color.fromARGB(255, 228, 228, 226),)
      //       ),
      //     ],
      //   ),
      // ],
      //   ),
      // );
    }

    Widget yourContentWidget() {
      return Container(
          height: 600,
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 10),
                builimg(),
                SizedBox(height: 5),
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
                  // Adjust the height as needed
                  orders(),

                  SizedBox(height: 20),
                  builcon(),
                  SizedBox(height: 20),
                } else ...{
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: 20),
                      builinfo(),
                      orders(),
                      builcon(),
                      SizedBox(height: 20),
                    ],
                  ),
                  SizedBox(height: 70),
                }
              ],
            ),
          ));
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: lb,
          toolbarHeight: 80,
          title: Text('مرحبا ${Admin['name']}',
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
