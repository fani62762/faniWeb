import 'package:faniweb/app_responsive.dart';
import 'package:faniweb/main.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class TableOfordData extends StatefulWidget {
  @override
  _TableOfordDataState createState() => _TableOfordDataState();
}

TextEditingController _searchController = TextEditingController();
List<Map<String, dynamic>> orders = [];

class _TableOfordDataState extends State<TableOfordData> {
  @override
  void initState() {
    super.initState();
    orders = allord;
    // print(workers);
  }

  void searchOrders(String? columnName, String query) {
    String columnNameeng = "";
    if (columnName == columnNames[0]) {
      columnNameeng = "uname";
    }
    if (columnName == columnNames[1]) {
      columnNameeng = "Wname";
    }
    if (columnName == columnNames[2]) {
      columnNameeng = "acc";
      //if (query == "مكتمل") query = 2.toString();
    }
    setState(() {
      orders = allord.where((order) {
        // Replace 'columnName' with the actual property name of the chosen column
        // in the 'order' object.
        final value = order[columnNameeng];
        return value.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  List<String> columnNames = [
    'اسم العميل',
    'اسم العامل',
    'حالة الطلب',
    // Add other column names as needed
  ];

  String? chosenColumnName = "";

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
                    chosenColumnName = value;
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
                          onPressed: () {},
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
