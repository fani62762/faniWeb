import 'package:faniweb/app_responsive.dart';
import 'package:faniweb/main.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
class TableOfordData extends StatefulWidget {
  @override
  _TableOfordDataState createState() => _TableOfordDataState();
}

TextEditingController _searchController = TextEditingController();
List<Map<String, dynamic>> orders = [];
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

class _TableOfordDataState extends State<TableOfordData> {
  @override
  void initState() {
    super.initState();
    orders = allord;
    columnNames = columnNames.toSet().toList();
    // print(workers);
  }

  void showOrderDetails(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: AlertDialog(
      title: Center(child: Text('تفاصيل الطلب', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))),
      backgroundColor: Colors.white,
      content: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'نوع الخدمة:',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Text(
                '${order['TypeServ']}',
                style: TextStyle(color: db),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'السعر:',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Text(
                '${order['Price']}',
                style: TextStyle(color: db),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'الوقت:',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Text(
                '${order['Hour']}',
                style: TextStyle(color:db),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'الخدمات:',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Text(
                '${order['serv'].join(", ")}',
                style: TextStyle(color:db),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'التاريخ:',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Text(
                '${DateFormat('dd/MM/yyyy').format(DateTime.parse(order['date']))}',
                style: TextStyle(color: db),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'خدمات اضافية:',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Text(
                '${order['add'].join(", ")}',
                style: TextStyle(color: db),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'التكرار:',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Text(
                '${order['isrepeated']}',
                style: TextStyle(color: db),
              ),
            ],
          ),
        ],
      ),
      ),
      actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Center(child: Text('اغلاق', style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold))),
      ),
      ],
    ),
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
      orders = allord.where((order) {
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
                    child: Center(child: Text(columnName)),
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
               SizedBox(height: 20),
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
                      label: Text('اسم العامل'),
                      numeric: true,
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

                        DataCell(Text(order['Wname'])),
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
