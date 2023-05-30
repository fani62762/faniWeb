import 'package:flutter/material.dart';
import 'package:faniweb/main.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:faniweb/app_responsive.dart';
import 'package:faniweb/main.dart';
import 'package:faniweb/menu_controller.dart';
import 'package:faniweb/dashboard/Admin/profiles/AdminSeeTech.dart';
import 'package:faniweb/dashboard/Admin/profiles/foradmin.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Type {
  String id;
  String name;

  Type({required this.id, required this.name});
}

String globtype = "";

class Service {
  String id;
  String name;
  String typeId;

  Service({required this.id, required this.name, required this.typeId});
}
// Rest of the code...

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
      final jsonResponse = json.decode(response.body);
      //                               setState(() {
      //                                 Navigator.pop(context);
      //                                   i = 0;
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => MultiProvider(
      //       providers: [
      //         ChangeNotifierProvider(create: (context) => MenuControllerr())
      //       ],
      //       child: AdminPage(),
      //     ),
      //   ),
      // );

      //                               });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  List<Type> types = [];
  List<Service> services = []; // List of services

  TextEditingController typeNameController = TextEditingController();
  TextEditingController serviceNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    servs = allserv;
    // Initial data
    types = [
      Type(id: '1', name: 'Type 1'),
      Type(id: '2', name: 'Type 2'),
    ];
    services = [
      Service(id: '1', name: 'Service 1', typeId: '1'),
      Service(id: '2', name: 'Service 2', typeId: '2'),
    ];
  }

  @override
  void dispose() {
    typeNameController.dispose();
    serviceNameController.dispose();
    super.dispose();
  }

  // void addType(String typeName) {
  //   setState(() {
  //     types.add(Type(name: typeName));
  //   });
  // }

  void deleteType(Type type) {
    setState(() {
      types.remove(type);
    });
  }

  // void addService(String serviceName, Type type) {
  //   final index = types.indexOf(type);
  //   if (index != -1) {
  //     setState(() {
  //       typeServices[index][type]!
  //           .add(Service(name: serviceName, type: type.name));
  //     });
  //   }
  // }

  // void deleteService(Service service, Type type) {
  //   final index = types.indexOf(type);
  //   if (index != -1) {
  //     setState(() {
  //       typeServices[index][type]!.remove(service);
  //     });
  //   }
  // }

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
        final value = serv[columnNameeng].toString();
        return value.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  // Rest of the code...

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: ListView.builder(
        itemCount: alltype.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> type = alltype[index];
          List<Map<String, dynamic>> typeServices = allserv
              .where((service) => service['type'] == type['type'])
              .toList();

          return Card(
            child: ExpansionTile(
              title: Text(type['type']),
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: typeServices.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> service = typeServices[index];
                    return ListTile(
                      title: Text(service['name']),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            // Delete the service
                            // services.remove(service);
                          });
                        },
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text('اضافة خدمة'),
                  trailing: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      globtype = type['type'];
                      // Open a dialog to add a new service
                      showDialog(
                        context: context,
                        builder: (context) => AddServiceDialog(
                          onServiceAdded: (newService) {
                            setState(() {
                              createserv(
                                  newService['name'], newService['type']);
                              // Add the new service
                              // services.add(newService);
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class AddServiceDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onServiceAdded;

  AddServiceDialog({required this.onServiceAdded});

  @override
  _AddServiceDialogState createState() => _AddServiceDialogState();
}

class _AddServiceDialogState extends State<AddServiceDialog> {
  String serviceName = '';
  String selectedType = globtype;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('اضافة خدمة'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                serviceName = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'اسم الخدمة',
            ),
          ),
          SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: globtype,
            onChanged: (value) {
              setState(() {
                selectedType = value!;
              });
            },
            items: alltype.map((type) {
              return DropdownMenuItem<String>(
                value: type['type'],
                child: Text(type['type']),
              );
            }).toList(),
            decoration: InputDecoration(
              labelText: 'النوع',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('الغاء'),
        ),
        ElevatedButton(
          onPressed: () {
            if (serviceName.isNotEmpty && selectedType.isNotEmpty) {
              // Service newService = Service(
              //   id: Uuid().v4(), // Generate a unique ID
              //   name: serviceName,
              //   type: selectedType,
              // );
              Map<String, dynamic> newService = {};
              newService['name'] = serviceName;
              newService['type'] = selectedType;
              widget.onServiceAdded(newService);
              Navigator.pop(context);
            }
          },
          child: Text('اضافة'),
        ),
      ],
    );
  }
}
