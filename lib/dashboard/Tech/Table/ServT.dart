import 'dart:convert';
import 'package:faniweb/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class tableserv extends StatefulWidget {
  @override
  _tableservState createState() => _tableservState();
}
var sub;
var newtype;

class _tableservState extends State<tableserv> {


 
 
  Future<void> getAlltypes() async {
    final response =
        await http.get(Uri.parse('https://fani-service.onrender.com/type/'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      setState(() {
        alltype = List<Map<String, dynamic>>.from(jsonResponse);
      });
      typecount = alltype.length;
    } else {
      print('Error fetching types data: ${response.statusCode}');
    }
  }

  Future<void> getAlltypeserv() async {
    final response =
        await http.get(Uri.parse('https://fani-service.onrender.com/serv/4/'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      setState(() {
        allserv = List<Map<String, dynamic>>.from(jsonResponse);
      });
      servcount = allserv.length;
    } else {
      print('Error fetching services data: ${response.statusCode}');
    }
  }

 
   @override
  void initState() {
    super.initState();
    getAlltypeserv() ;
    getAlltypes();
 
 
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
          Text("جميع الخدمات لدى تطبيق فني ",style: TextStyle(fontSize: 20),),
          SizedBox(height: 10,),
          Column(
  children:
  
   List.generate(alltype.length, (index) {
    Map<String, dynamic> type = alltype[index];
    List<Map<String, dynamic>> typeServices = allserv.where((service) {
      final serviceType = service['type'];
      final targetType = type['type'];
      final areEqual = targetType == serviceType;

     return areEqual;
    }).toList();

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(
          color: Colors.black, // Set the desired border color
          width: 1, // Set the desired border width
        ),
      ),
      child: ExpansionTile(
        title: Text(type['type']),
        children: [
          Column(
            children: List.generate(typeServices.length, (index) {
              Map<String, dynamic> service = typeServices[index];
              return ListTile(
                title: Text(service['name']),
                trailing: IconButton(
     icon: Icon(Icons.camera),
    onPressed: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              width: 200,
              height: 200,
             child: Image.network(
  service['avatar'],
  width: 80,
  height: 90,
),
            ),
            actions: <Widget>[
              
              TextButton(
                child: Center(child: Text('Close')),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    },
  ),
);

            }),
            
          ),

      SizedBox(height: 10,),
        ],
      ),
      
    );
  }),
),








          SizedBox(height: 10,),
       
       

   
  
        ],
      ),
   );
  }


}
