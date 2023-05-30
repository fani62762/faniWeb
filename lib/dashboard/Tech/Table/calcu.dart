
import 'package:faniweb/main.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'bar_chart_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

 List<BarChartModel> data1 = [
  BarChartModel(
    year: "Sun",
    financial: dayorw?['Sun']  ?? 0,
    color: charts.ColorUtil.fromDartColor(Colors.blueGrey),
  ),
  BarChartModel(
    year: "Mon",
     financial: dayorw?['Mon']  ?? 0,
    color: charts.ColorUtil.fromDartColor(Colors.red),
  ),
  BarChartModel(
    year: "Tue",
     financial: dayorw?['Tue']  ?? 0,
    color: charts.ColorUtil.fromDartColor(Colors.green),
  ),
  BarChartModel(
    year: "Wed",
     financial: dayorw?['Wed']  ?? 0,
    color: charts.ColorUtil.fromDartColor(Colors.yellow),
  ),
  BarChartModel(
    year: "Thu",
     financial: dayorw?['Thu']  ?? 0,
    color: charts.ColorUtil.fromDartColor(Colors.lightBlueAccent),
  ),
  BarChartModel(
    year: "Fri",
     financial: dayorw?['Fri']  ?? 0,
    color: charts.ColorUtil.fromDartColor(Colors.pink),
  ),
  BarChartModel(
    year: "Sat",
    financial: dayorw?['Sat']  ?? 0,
    color: charts.ColorUtil.fromDartColor(Colors.purple),
  ),
 
];

List<BarChartModel> data2 = ordservw.map((item) {

  return BarChartModel(
    year: item['_id'] as String,
    financial:item['count'] as int,
    color: charts.ColorUtil.fromDartColor(Colors.blueGrey),
  );
}).toList();


class maths extends StatefulWidget {
  @override
  _mathsState createState() => _mathsState();
}
class _mathsState extends State<maths> {
 
   Future<void> ordservcountw(String wname) async {
    final response = await http
        .get(Uri.parse('https://fani-service.onrender.com/ord/getservordw/$wname'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      setState(() {
        ordservw = List<Map<String, dynamic>>.from(jsonResponse);
        print("----------------------------------------");
        print(ordservw);
      });
    } else {
      print('Error fetching workers data: ${response.statusCode}');
    }
  }
 
     Future<void> getordayw(String wname) async {
    final response =
        await http.get(Uri.parse('https://fani-service.onrender.com/ord/getdayw/$wname'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
     
      setState(() {
         dayorw = Map<String, int>.from(jsonResponse);
         
    
      });
    } else {
      print('Error fetching days data: ${response.statusCode}');
    }
  }
 
   @override
  void initState() {
    super.initState();
      getordayw(WorW['name']);
      ordservcountw(WorW['name']);
   
 
  }

  Widget build(BuildContext context) {
    List<charts.Series<BarChartModel, String>> series1 = [
      charts.Series(
        id: "financial",
        data: data1,
        domainFn: (BarChartModel series, _) => series.year,
        measureFn: (BarChartModel series, _) => series.financial,
        colorFn: (BarChartModel series, _) => series.color,
      ),
    ];
 List<charts.Series<BarChartModel, String>> series2 = [
      charts.Series(
        id: "financial",
        data: data2,
        domainFn: (BarChartModel series, _) => series.year,
        measureFn: (BarChartModel series, _) => series.financial,
        colorFn: (BarChartModel series, _) => series.color,
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(20),
       child: 
       Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           SizedBox(height: 10,),
          Center(child:Text("statistics",style: TextStyle(fontSize:25,fontWeight: FontWeight.bold))),
         SizedBox(height: 45,),
          Center(child:Text("عدد طلباتي خلال الأيام",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Times New Roman'),)),
      
         Center(
          child:
          SizedBox(
            height: 500,
            width: 650,
            child:charts.BarChart(
          series1,
          animate: true,
               ) ,
          )
         ),
             SizedBox(height: 45,),
          Center(child:Text("الـخـدَمـات التي تم طلبها مني ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Times New Roman'),)),
  
         Center(
          child:SizedBox(
            height: 500,
            width: 650,
            child:charts.BarChart(
          series2,
          animate: true,
               ) ,
          )
         ),
           SizedBox(height: 35,),

        ],)
    );
}
}
