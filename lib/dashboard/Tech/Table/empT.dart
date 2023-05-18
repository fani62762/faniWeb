import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:faniweb/app_responsive.dart';
import 'package:faniweb/main.dart';
import 'package:faniweb/menu_controller.dart';
import 'package:faniweb/dashboard/Tech/profiles/TechSeeTech.dart';
import 'package:faniweb/dashboard/Tech/profiles/foraTech.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class TableOfEmpData extends StatefulWidget {
  @override
  _TableOfEmpDataState createState() => _TableOfEmpDataState();
}
 
class _TableOfEmpDataState extends State<TableOfEmpData> {
  List<Map<String, dynamic>> filteredWorkers = [...workers];
  TextEditingController searchController = TextEditingController();

  void filterWorkers(String query) {
    setState(() {
      filteredWorkers = workers
          .where((w) =>
              w['name'].toLowerCase().contains(query.toLowerCase().trim()) ||
              w['email'].toLowerCase().contains(query.toLowerCase().trim()))
          .toList();
    });
  }


 Future<void> getAllWorkers() async {

    final response =
        await http.get(Uri.parse('https://fani-service.onrender.com/worker/'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
    
       setState(() {
          workers = List<Map<String, dynamic>>.from(jsonResponse);
  
  });
    } else {
      print('Error fetching workers data: ${response.statusCode}');
    }
  }
  
   @override
  void initState() {
    super.initState();
    getAllWorkers();
 
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(20),
       child: Column(
        children: [
          TextField(
            controller: searchController,
            onChanged: (value) => filterWorkers(value),
            decoration: InputDecoration(
              hintText: 'ابحث من خلال اسم أو إيميل العامل',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  searchController.clear();
                  filterWorkers('');
                },
              ),
            ),
          ),
          SizedBox(height: 10),
          DataTable(
            columnSpacing: 12,
            dataRowHeight: 60,
            dividerThickness: 1,
            columns: [
              DataColumn(
                label: Text('الإسم',style: TextStyle(fontFamily: 'Times New Roman')),
              ),
              DataColumn(label: _verticalDivider),
              DataColumn(
                label: Text('الإيميل',style: TextStyle(fontFamily: 'Times New Roman')),
                numeric: true,
              ),
              DataColumn(label: _verticalDivider),
              DataColumn(
                label: Text('الهاتف',style: TextStyle(fontFamily: 'Times New Roman')),
                numeric: true,
              ),
              if (AppResponsive.isDesktop(context)) ...{
                DataColumn(label: _verticalDivider),
                DataColumn(
                  label: Text('الجنس',style: TextStyle(fontFamily: 'Times New Roman')),
                ),
                DataColumn(label: _verticalDivider),
                DataColumn(
                  label: Text('الأعمال',style: TextStyle(fontFamily: 'Times New Roman')),
                ),
                DataColumn(label: _verticalDivider),
                DataColumn(
                  label: SizedBox(),
                  numeric: true,
                ),
              }
            ],
            rows: filteredWorkers.map((worker) {
              return DataRow(
                cells: [
                  if (MediaQuery.of(context).size.width > 1480)
                    DataCell(
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(worker['image']),
                          ),
                          SizedBox(width: 10),
                          Text(worker['name']),
                        ],
                      ),
                    ),
                  if (MediaQuery.of(context).size.width <= 1480)
                    DataCell(Text(worker['name'])),
                  DataCell(_verticalDivider),
                  DataCell(Text(worker['email'])),
                  DataCell(_verticalDivider),
                  DataCell(Text(worker['phone'])),
                  if (AppResponsive.isDesktop(context)) ...{
                    DataCell(_verticalDivider),
                    DataCell(Text(worker['gender'])),
                    DataCell(_verticalDivider),
                    DataCell(IconButton(
                      icon: Icon(Icons.info_outline),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MultiProvider(
                              providers: [
                                ChangeNotifierProvider(
                                    create: (context) => MenuControllerr())
                              ],
                              child: TsT(workName: worker['name']),
                            ),
                          ),
                        );
                      },
                    )),
                    DataCell(_verticalDivider),
                    DataCell(IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {},
                    )),
                  }
                ],
              );
            }).toList(),
          ),
          SizedBox(height: 10,),
         
   
        ],
      ),
    );
  }

  Widget _verticalDivider = const VerticalDivider(
    color: Colors.grey,
    thickness: .5,
  );
}
