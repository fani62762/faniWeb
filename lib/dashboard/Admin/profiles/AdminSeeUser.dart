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

    Widget _verticalDivider = const VerticalDivider(
      color: Colors.grey,
      thickness: .5,
    );
    void showOrderDetails(Map<String, dynamic> order) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('تفاصيل الطلب'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'نوع الخدمة: ${order['TypeServ']}',
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    'السعر: ${order['Price']}',
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    'الوقت: ${order['Hour']}',
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    'الخدمات: ${order['serv'].join(", ")}',
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    'التاريخ: ${order['date']}',
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    'خدمات اضافية: ${order['add'].join(", ")}',
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    'التكرار: ${order['isrepeated']}',
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('اغلاق'),
              ),
            ],
          );
        },
      );
    }

    // Widget orders() {
    //   return Expanded(
    //     child: Container(
    //       height: MediaQuery.of(context).size.height,
    //       margin: EdgeInsets.symmetric(horizontal: 20),
    //       padding: EdgeInsets.all(10),
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(10),
    //         color: Color.fromARGB(255, 228, 228, 226),
    //       ),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           SizedBox(height: 20),
    //           Text(
    //             'الخدمات التي قام ${user['name']} بطلبها مني',
    //             style: TextStyle(
    //               fontSize: 20,
    //               fontWeight: FontWeight.bold,
    //               fontFamily: 'ArabicFont',
    //             ),
    //             textDirection: TextDirection.rtl,
    //           ),
    //           SizedBox(height: 10),
    //           Flexible(
    //             child: ListView.builder(
    //               shrinkWrap: true,
    //               physics: NeverScrollableScrollPhysics(),
    //               itemCount: userord.length,
    //               itemBuilder: (context, index) {
    //                 final order = userord[index];
    //                 return SingleChildScrollView(
    //                   scrollDirection: Axis.horizontal,
    //                   child: DataTable(
    //                     columnSpacing: 12,
    //                     dataRowHeight: 60,
    //                     dividerThickness: 1,
    //                     columns: [
    //                       DataColumn(
    //                         label: Text('اسم العميل'),
    //                       ),
    //                       DataColumn(label: _verticalDivider),
    //                       DataColumn(
    //                         label: Text('حالة الطلب'),
    //                         numeric: true,
    //                       ),
    //                       DataColumn(label: _verticalDivider),
    //                       DataColumn(
    //                         label: Text('تفاصيل'),
    //                       ),
    //                       DataColumn(label: _verticalDivider),
    //                     ],
    //                     rows: userord.map((order) {
    //                       return DataRow(
    //                         cells: [
    //                           DataCell(Text(order['uname'])),
    //                           DataCell(_verticalDivider),
    //                           order['acc'] == 0
    //                               ? DataCell(
    //                                   Container(
    //                                     child: Text(
    //                                       "بانتظار موافقة العامل",
    //                                       style: TextStyle(
    //                                         color: Colors.orange,
    //                                       ),
    //                                     ),
    //                                   ),
    //                                 )
    //                               : order['acc'] == 1
    //                                   ? DataCell(
    //                                       Container(
    //                                         child: Text(
    //                                           "قيد التنفيذ",
    //                                           style: TextStyle(
    //                                             color: Colors.blue,
    //                                           ),
    //                                         ),
    //                                       ),
    //                                     )
    //                                   : order['acc'] == 2
    //                                       ? DataCell(
    //                                           Container(
    //                                             child: Text(
    //                                               "مكتمل",
    //                                               style: TextStyle(
    //                                                 color: Colors.green,
    //                                               ),
    //                                             ),
    //                                           ),
    //                                         )
    //                                       : order['acc'] == -1
    //                                           ? DataCell(
    //                                               Container(
    //                                                 child: Text(
    //                                                   "رفض من قبل العامل",
    //                                                   style: TextStyle(
    //                                                     color: Colors.red,
    //                                                   ),
    //                                                 ),
    //                                               ),
    //                                             )
    //                                           : order['acc'] == -2
    //                                               ? DataCell(
    //                                                   Container(
    //                                                     child: Text(
    //                                                       "الغاء من قبل العميل",
    //                                                       style: TextStyle(
    //                                                         color: Colors.red,
    //                                                       ),
    //                                                     ),
    //                                                   ),
    //                                                 )
    //                                               : DataCell(Text("")),
    //                           DataCell(_verticalDivider),
    //                           DataCell(IconButton(
    //                             icon: Icon(Icons.info_outline),
    //                             onPressed: () {
    //                               showOrderDetails(order);
    //                             },
    //                           )),
    //                           DataCell(_verticalDivider),
    //                         ],
    //                       );
    //                     }).toList(),
    //                   ),
    //                 );
    //               },
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }

    Widget orders() {
      return Expanded(
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
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    height: 250, // Set the desired height for the table
                    child: DataTable(
                      columnSpacing: 12,
                      dataRowHeight: 60,
                      dividerThickness: 1,
                      columns: [
                        DataColumn(
                          label: Text('اسم العميل'),
                        ),
                        DataColumn(label: _verticalDivider),
                        DataColumn(
                          label: Text('حالة الطلب'),
                          numeric: true,
                        ),
                        DataColumn(label: _verticalDivider),
                        DataColumn(
                          label: Text('تفاصيل'),
                        ),
                        DataColumn(label: _verticalDivider),
                      ],
                      rows: userord.map((order) {
                        return DataRow(
                          cells: [
                            DataCell(Text(order['uname'])),
                            DataCell(_verticalDivider),
                            order['acc'] == 0
                                ? DataCell(
                                    Container(
                                      child: Text(
                                        "بانتظار موافقة العامل",
                                        style: TextStyle(
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ),
                                  )
                                : order['acc'] == 1
                                    ? DataCell(
                                        Container(
                                          child: Text(
                                            "قيد التنفيذ",
                                            style: TextStyle(
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      )
                                    : order['acc'] == 2
                                        ? DataCell(
                                            Container(
                                              child: Text(
                                                "مكتمل",
                                                style: TextStyle(
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                          )
                                        : order['acc'] == -1
                                            ? DataCell(
                                                Container(
                                                  child: Text(
                                                    "رفض من قبل العامل",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : order['acc'] == -2
                                                ? DataCell(
                                                    Container(
                                                      child: Text(
                                                        "الغاء من قبل العميل",
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : DataCell(Text("")),
                            DataCell(_verticalDivider),
                            DataCell(IconButton(
                              icon: Icon(Icons.info_outline),
                              onPressed: () {
                                showOrderDetails(order);
                              },
                            )),
                            DataCell(_verticalDivider),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
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
