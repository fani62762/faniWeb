import 'package:flutter/material.dart';
import 'package:faniweb/main.dart';

class Type {
  String id;
  String name;

  Type({required this.id, required this.name});
}

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
        itemCount: types.length,
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
                  title: Text('Add Service'),
                  trailing: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      // Open a dialog to add a new service
                      // showDialog(
                      //   context: context,
                      //   builder: (context) => AddServiceDialog(
                      //     onServiceAdded: (newService) {
                      //       setState(() {
                      //         // Add the new service
                      //         services.add(newService);
                      //       });
                      //     },
                      //   ),
                      // );
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
