import 'dart:convert';
import 'package:faniweb/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileT extends StatefulWidget {
  @override
  _ProfileTState createState() => _ProfileTState();
}

class _ProfileTState extends State<ProfileT> {
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
   Future<void> getAlluserss() async {
   
    final response =
        await http.get(Uri.parse('https://fani-service.onrender.com/users/'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
     
      setState(() { 
        users = List<Map<String, dynamic>>.from(jsonResponse);
       
      });
    } else {
      print('Error fetching workers data: ${response.statusCode}');
    }
  }
   Future<void> getAllordw(String Wname) async {
    final response = await http
        .get(Uri.parse('https://fani-service.onrender.com/ord/12/$Wname'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      setState(() {
        allordw = List<Map<String, dynamic>>.from(jsonResponse);
      });
      orders = allordw;
    } else {
      print('Error fetching orders data: ${response.statusCode}');
    }
  }
   @override
  void initState() {
    super.initState();
    getAllWorkers();
       getAlluserss();
       getAllordw(WorW['name']);

 
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: lb,
                      width: 0.0,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(WorW[
                          'image']), // use NetworkImage instead of Image.network
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Text(
                    WorW['name'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("Fani")
                ],
              )
            ],
          ),
          Divider(thickness: 0.5, color: Colors.grey),
          employeeTasks(Icons.miscellaneous_services, "عددالخدمات", "10"),
          employeeTasks(Icons.people, "عددالعُمال", workers.length),
          employeeTasks(
              Icons.supervised_user_circle_sharp, "عددالزبائن", users.length),
          employeeTasks(Icons.list_alt_sharp, "عدد الطلبات", allordw.length),
        ],
      ),
    );
  }

  Widget employeeTasks(icon, text, value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon),
              SizedBox(width: 8),
              Text(text),
            ],
          ),
          Text(
            "$value",
            style: TextStyle(fontWeight: FontWeight.bold, color: lb),
          )
        ],
      ),
    );
  }
}
