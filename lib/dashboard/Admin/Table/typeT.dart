import 'package:flutter/material.dart';

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

class _ServiceManagementScreenState extends State<ServiceManagementScreen> {
  List<Type> types = [];
  List<Map<Type, List<Service>>> typeServices = [];

  TextEditingController typeNameController = TextEditingController();
  TextEditingController serviceNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Service Management'),
        ),
        body: Container(
            height: 300,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 228, 228, 226),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: types.length,
                      itemBuilder: (context, index) {
                        final type = types[index];
                        final services = typeServices[index][type]!;

                        return Card(
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(type.name),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    deleteType(type);
                                  },
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: services.length,
                                itemBuilder: (context, serviceIndex) {
                                  final service = services[serviceIndex];
                                  return ListTile(
                                    title: Text(service.name),
                                    trailing: IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        deleteService(service, type);
                                      },
                                    ),
                                  );
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: ElevatedButton(
                                  onPressed: () {
                                    addService(
                                        serviceNameController.text, type);
                                    serviceNameController.clear();
                                  },
                                  child: Text('Add Service'),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: TextField(
                      controller: typeNameController,
                      decoration: InputDecoration(
                        labelText: 'Type Name',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: ElevatedButton(
                      onPressed: () {
                        addType(typeNameController.text);
                        typeNameController.clear();
                      },
                      child: Text('Add Type'),
                    ),
                  ),
                ],
              ),
            )));
  }
}
