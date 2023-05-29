import 'package:faniweb/app_responsive.dart';
import 'package:faniweb/main.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<Map<String, dynamic>> allordw = [];
List<Map<String, dynamic>> orders = [];

class TableOfordDataw extends StatefulWidget {
  @override
  _TableOfordDatawState createState() => _TableOfordDatawState();
}

TextEditingController _searchController = TextEditingController();

List<String> columnNames = [
  'اسم العميل',
  'اسم العامل',
  'حالة الطلب',
  'نوع الخدمة',
  'السعر',
  'الوقت',
  'الخدمات',
  'التاريخ',
  'خدمات اضافية',
  'التكرار',
  // Add other column names as needed
];
String? chosenColumnName = columnNames.first;

class _TableOfordDatawState extends State<TableOfordDataw> {
  Future<void> getAllordw(String Wname) async {
    final response = await http
        .get(Uri.parse('https://fani-service.onrender.com/ord/12/$Wname'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      setState(() {
        allordw = List<Map<String, dynamic>>.from(jsonResponse);
      });
      orders = allordw;
      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbb");
      print(allordw);
      print("aaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbb");
      print(orders);
    } else {
      print('Error fetching orders data: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    print("worker name is ");
    print(WorW['name']);
    getAllordw(WorW['name']);
    orders = allordw;
    print("hiiiiiiiiiiiiiiiiii");
    print(orders);
    columnNames = columnNames.toSet().toList();
    // print(workers);
  }

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

  void searchOrders(String? columnName, String query) {
    String columnNameeng = "";
    int stat;
    if (columnName == columnNames[0]) {
      columnNameeng = "uname";
    }
    if (columnName == columnNames[1]) {
      columnNameeng = "Wname";
    }
    if (columnName == columnNames[2]) {
      columnNameeng = "acc";
      if (query == "مكتمل") query = "2";
      if (query == "قيد التنفيذ") query = "1";
      if (query == "بانتظار موافقة العامل") query = "0";
      if (query == "رفض من قبل العامل") query = "-1";
      if (query == "الغاء من قبل العميل") query = "-2";
    }
    if (columnName == columnNames[3]) {
      columnNameeng = "TypeServ";
      //if (query == "مكتمل") query = 2.toString();
    }
    if (columnName == columnNames[4]) {
      columnNameeng = "Price";

      //if (query == "مكتمل") query = 2.toString();
    }
    if (columnName == columnNames[5]) {
      columnNameeng = "Hour";
      //if (query == "مكتمل") query = 2.toString();
    }
    if (columnName == columnNames[6]) {
      columnNameeng = "serv";
      //if (query == "مكتمل") query = 2.toString();
    }
    if (columnName == columnNames[7]) {
      columnNameeng = "date";
      //if (query == "مكتمل") query = 2.toString();
    }
    if (columnName == columnNames[8]) {
      columnNameeng = "add";
      //if (query == "مكتمل") query = 2.toString();
    }
    if (columnName == columnNames[9]) {
      columnNameeng = "isrepeated";
      //if (query == "مكتمل") query = 2.toString();
    }
    setState(() {
      orders = allordw.where((order) {
        // Replace 'columnName' with the actual property name of the chosen column
        // in the 'order' object.
        final value = order[columnNameeng].toString();
        return value.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(20),
        child: StatefulBuilder(
          builder: (context, setState) {
            return Column(children: [
              DropdownButtonFormField<String>(
                value: chosenColumnName,
                decoration: InputDecoration(
                  labelText: '  بحث على حسب',
                ),
                onChanged: (String? value) {
                  setState(() {
                    chosenColumnName = value ?? '';
                  });
                },
                items: columnNames.map((String columnName) {
                  return DropdownMenuItem<String>(
                    value: columnName,
                    child: Text(columnName),
                  );
                }).toList(),
              ),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'بحث',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                      });
                    },
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    setState(() {
                      // Call the search function with the chosen column name and search query
                      searchOrders(chosenColumnName, value);
                    });
                  });
                },
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
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
                    // // DataColumn(label: _verticalDivider),
                    // // if (AppResponsive.isDesktop(context))
                    // //   DataColumn(
                    // //     label: Text('التقييم'),
                    // //   ),
                    // if (AppResponsive.isDesktop(context))
                    //   DataColumn(label: _verticalDivider),
                    DataColumn(
                      label: Text('تفاصيل'),
                    ),
                    DataColumn(label: _verticalDivider),
                    // //if (!AppResponsive.isMobile(context))
                    // DataColumn(
                    //   label: SizedBox(),
                    //   numeric: true,
                    // ),
                  ],
                  rows: orders.map((order) {
                    return DataRow(
                      cells: [
                        // if (AppResponsive.isDesktop(context))
                        //   DataCell(
                        //     Row(
                        //       // children: [
                        //       //   // CircleAvatar(
                        //       //   //   backgroundImage: NetworkImage(worker['image']),
                        //       //   // ),
                        //       //   // SizedBox(width: 10),
                        //       //   Text(order['uname']),
                        //       // ],
                        //     ),
                        //   ),
                        //if (!AppResponsive.isDesktop(context))
                        DataCell(Text(order['uname'])),
                        DataCell(_verticalDivider),

                        order['acc'] == 0
                            ? DataCell(
                                Container(
                                  child: Text(
                                    "بانتظار موافقة العامل",
                                    style: TextStyle(
                                      color: Colors
                                          .orange, // Set the desired text color here
                                    ),
                                  ),
                                ),
                              )
                            : order['acc'] == 1
                                ? DataCell(
                                    Container(
                                      child: Text(
                                        "قيد التنفيذ  ",
                                        style: TextStyle(
                                          color: Colors
                                              .blue, // Set the desired text color here
                                        ),
                                      ),
                                    ),
                                  )
                                : order['acc'] == 2
                                    ? DataCell(
                                        Container(
                                          child: Text(
                                            "  مكتمل",
                                            style: TextStyle(
                                              color: Colors
                                                  .green, // Set the desired text color here
                                            ),
                                          ),
                                        ),
                                      )
                                    : order['acc'] == -1
                                        ? DataCell(
                                            Container(
                                              child: Text(
                                                "  رفض من قبل العامل",
                                                style: TextStyle(
                                                  color: Colors
                                                      .red, // Set the desired text color here
                                                ),
                                              ),
                                            ),
                                          )
                                        : order['acc'] == -2
                                            ? DataCell(
                                                Container(
                                                  child: Text(
                                                    "  الغاء من قبل العميل",
                                                    style: TextStyle(
                                                      color: Colors
                                                          .red, // Set the desired text color here
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : DataCell(Text("")),
                        DataCell(_verticalDivider),

                        // // if (AppResponsive.isDesktop(context))
                        // //   DataCell(Text(worker['gender'])),
                        // if (AppResponsive.isDesktop(context))
                        //   DataCell(_verticalDivider),

                        DataCell(IconButton(
                          icon: Icon(Icons.info_outline),
                          onPressed: () {
                            showOrderDetails(order);
                          },
                        )),
                        DataCell(_verticalDivider),
                        // // if (!AppResponsive.isMobile(context))
                        // DataCell(IconButton(
                        //   icon: Icon(Icons.delete),
                        //   onPressed: () {},
                        // )),
                      ],
                    );
                  }).toList(),
                ),
              )
            ]);
          },
        ));
  }

  Widget _verticalDivider = const VerticalDivider(
    color: Colors.grey,
    thickness: .5,
  );
}
