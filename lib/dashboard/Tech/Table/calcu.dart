
import 'package:faniweb/main.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'bar_chart_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

    Map<String, double> dataMap1 = {
    "العُمال الفَنين": workers.length as double,
    "المُستخدمين":  users.length as double,
  };
    Map<String, double> dataMap2 = {
    " الذكور": gwf as double,
    " الإاناث":  gwm as double,
  };
    Map<String, double> dataMap3= {
    " الذكور": guf as double,
    " الإاناث":  gum as double,
  };
List<BarChartModel> data1 = [
  BarChartModel(
    year: "Sun",
    financial: dayor?['Sun']  ?? 0,
    color: charts.ColorUtil.fromDartColor(Colors.blueGrey),
  ),
  BarChartModel(
    year: "Mon",
     financial: dayor?['Mon']  ?? 0,
    color: charts.ColorUtil.fromDartColor(Colors.red),
  ),
  BarChartModel(
    year: "Tue",
     financial: dayor?['Tue']  ?? 0,
    color: charts.ColorUtil.fromDartColor(Colors.green),
  ),
  BarChartModel(
    year: "Wed",
     financial: dayor?['Wed']  ?? 0,
    color: charts.ColorUtil.fromDartColor(Colors.yellow),
  ),
  BarChartModel(
    year: "Thu",
     financial: dayor?['Thu']  ?? 0,
    color: charts.ColorUtil.fromDartColor(Colors.lightBlueAccent),
  ),
  BarChartModel(
    year: "Fri",
     financial: dayor?['Fri']  ?? 0,
    color: charts.ColorUtil.fromDartColor(Colors.pink),
  ),
  BarChartModel(
    year: "Sat",
    financial: dayor?['Sat']  ?? 0,
    color: charts.ColorUtil.fromDartColor(Colors.purple),
  ),
 
];

List<BarChartModel> data2 = ordserv.map((item) {

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
  Future<void> getgw() async {
    final response =
        await http.get(Uri.parse('https://fani-service.onrender.com/worker/wgender'));
    if (response.statusCode == 200) {
     final data = json.decode(response.body);
 
      setState(() {
       gwm   = data['maleCount'];
     gwf = data['femaleCount'];
    
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
 Future<void> getgu() async {
    final response =
        await http.get(Uri.parse('https://fani-service.onrender.com/users/ugender'));
    if (response.statusCode == 200) {
     final data = json.decode(response.body);
      setState(() {
     gum   = data['maleCount'];
     guf = data['femaleCount'];
    
      });
    } else {
      print('Error fetching workers data: ${response.statusCode}');
    }
  }
 
     Future<void> getorday() async {
    final response =
        await http.get(Uri.parse('https://fani-service.onrender.com/ord/getday'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
     
      setState(() {
         dayor = Map<String, int>.from(jsonResponse);
    
      });
    } else {
      print('Error fetching days data: ${response.statusCode}');
    }
  }
 
   @override
  void initState() {
    super.initState();
    getAllWorkers();
    getAlluserss();
    getgw();
    getgu();
      getorday();
   
 
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
         SizedBox(height:20,),
          Center(child:Text(" نسبة المُستخدمين و العُمال الفَنيين لهذا التطبيق ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Times New Roman'),)),
        
         Center(
          child: PieChart(
            dataMap: dataMap1,
            colorList: [db, dy],
            chartRadius: 450,
            
            legendOptions: LegendOptions(
              legendPosition: LegendPosition.top,
              legendShape: BoxShape.rectangle,
              showLegendsInRow: true
          
            ),
            chartValuesOptions: ChartValuesOptions(
              showChartValuesInPercentage: true,
            ),
          )
         ),
             SizedBox(height: 45,),
          Center(child:Text("عدد الطلبات خلال الأيام",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Times New Roman'),)),
      
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
             SizedBox(height: 35,),
          Center(child:Text("  الـخـدَمـات الـمـطـلـوبـة ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Times New Roman'),)),
  
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
          Center(child:Text("   نسبة العُمال من الذكور والإناث ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Times New Roman'),)),
         
         Center(
          child: PieChart(
            dataMap: dataMap2,
             colorList: [dy, db],
            chartRadius: 450,
            
            legendOptions: LegendOptions(
              legendPosition: LegendPosition.top,
              legendShape: BoxShape.rectangle,
              showLegendsInRow: true
          
            ),
            chartValuesOptions: ChartValuesOptions(
              showChartValuesInPercentage: true,
            ),
          )
         ),
         SizedBox(height: 35,),
          Center(child:Text("   نسبة المُستخدمين من الذكور والإناث ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Times New Roman'),)),
        
         Center(
          child: PieChart(
            dataMap: dataMap3,
              colorList: [dy, db],
            chartRadius: 450,
            
            legendOptions: LegendOptions(
              legendPosition: LegendPosition.top,
              legendShape: BoxShape.rectangle,
              showLegendsInRow: true
          
            ),
            chartValuesOptions: ChartValuesOptions(
              showChartValuesInPercentage: true,
            ),
          )
         ),
         
         
         
        ],)
    );
}
}
