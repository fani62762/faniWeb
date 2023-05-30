import 'package:flutter/material.dart';
import 'package:faniweb/main.dart';

class Service {
  String name;
  String type;

  Service({required this.name, required this.type});
}

class Type {
  String name;

  Type({required this.name});
}

class ServiceManagementScreen extends StatefulWidget {
  @override
  _ServiceManagementScreenState createState() =>
      _ServiceManagementScreenState();
}

List<Map<String, dynamic>> servs = [];
TextEditingController _searchController = TextEditingController();
List<String> columnNames = [
  'الخدمة ',
  'نوع الخدمة',

  // Add other column names as needed
];
String? chosenColumnName = columnNames.first;

class _ServiceManagementScreenState extends State<ServiceManagementScreen> {
  List<Type> types = [];
  List<Map<Type, List<Service>>> typeServices = [];

  TextEditingController typeNameController = TextEditingController();
  TextEditingController serviceNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    servs = allserv;
    // Initial data
    types = [
      Type(name: 'Type 1'),
      Type(name: 'Type 2'),
    ];
    typeServices = [
      {
        types[0]: [
          Service(name: 'Service 1', type: 'Type 1'),
          Service(name: 'Service 2', type: 'Type 1'),
        ]
      },
      {
        types[1]: [
          Service(name: 'Service 3', type: 'Type 2'),
          Service(name: 'Service 4', type: 'Type 2'),
          Service(name: 'Service 5', type: 'Type 2'),
        ]
      },
    ];
  }

  @override
  void dispose() {
    typeNameController.dispose();
    serviceNameController.dispose();
    super.dispose();
  }

  void addType(String typeName) {
    setState(() {
      types.add(Type(name: typeName));
    });
  }

  void deleteType(Type type) {
    setState(() {
      types.remove(type);
    });
  }

  void addService(String serviceName, Type type) {
    final index = types.indexOf(type);
    if (index != -1) {
      setState(() {
        typeServices[index][type]!
            .add(Service(name: serviceName, type: type.name));
      });
    }
  }

  void deleteService(Service service, Type type) {
    final index = types.indexOf(type);
    if (index != -1) {
      setState(() {
        typeServices[index][type]!.remove(service);
      });
    }
  }

  void searchOrders(String? columnName, String query) {
    String columnNameeng = "";
    int stat;
    if (columnName == columnNames[0]) {
      columnNameeng = "name";
    }
    if (columnName == columnNames[1]) {
      columnNameeng = "type";
    }

    setState(() {
      servs = allserv.where((serv) {
        // Replace 'columnName' with the actual property name of the chosen column
        // in the 'order' object.
        final value = serv[columnNameeng].toString();
        return value.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  // Rest of the code...

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
          return Column(
            children: [
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
                    // Call the search function with the chosen column name and search query
                    searchOrders(chosenColumnName, value);
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
                      label: Text('اسم الخدمة'),
                    ),
                    DataColumn(label: _verticalDivider),
                    // DataColumn(
                    //   label: Text('اسم العامل'),
                    //   numeric: true,
                    // ),
                    // DataColumn(label: _verticalDivider),
                    // DataColumn(
                    //   label: Text('حالة الطلب'),
                    //   numeric: true,
                    // ),
                    // DataColumn(label: _verticalDivider),
                    // DataColumn(
                    //   label: Text('تفاصيل'),
                    // ),
                    // DataColumn(label: _verticalDivider),
                  ],
                  rows: servs.map((serv) {
                    List<DataCell> cells = [
                      DataCell(Text(serv['name'])),
                      DataCell(_verticalDivider),
                      // DataCell(Text(serv['Wname'])),
                      // DataCell(_verticalDivider),
                    ];

                    // List<Service> services =
                    //     typeServices[serv['type']][serv['type']] ?? [];

                    // for (Service service in services) {
                    //   cells.add(
                    //     DataCell(
                    //       Container(
                    //         child: Checkbox(
                    //           value: serv['services'].contains(service),
                    //           onChanged: (value) {
                    //             setState(() {
                    //               if (value == true) {
                    //                 serv['services'].add(service);
                    //               } else {
                    //                 serv['services'].remove(service);
                    //               }
                    //             });
                    //           },
                    //         ),
                    //       ),
                    //     ),
                    //   );
                    //   cells.add(DataCell(_verticalDivider));
                    // }

                    // cells.addAll([
                    //   DataCell(IconButton(
                    //     icon: Icon(Icons.info_outline),
                    //     onPressed: () {
                    //       showOrderDetails(serv);
                    //     },
                    //   )),
                    //   DataCell(_verticalDivider),
                    // ]);

                    return DataRow(cells: cells);
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _verticalDivider = const VerticalDivider(
    color: Colors.grey,
    thickness: .5,
  );
}
