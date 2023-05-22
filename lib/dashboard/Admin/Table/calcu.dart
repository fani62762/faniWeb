
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
    year: "Jan",
    financial: 10,
    color: charts.ColorUtil.fromDartColor(Colors.blueGrey),
  ),
  BarChartModel(
    year: "Feb",
    financial: 20,
    color: charts.ColorUtil.fromDartColor(Colors.red),
  ),
  BarChartModel(
    year: "Mar",
    financial: 30,
    color: charts.ColorUtil.fromDartColor(Colors.green),
  ),
  BarChartModel(
    year: "Apr",
    financial: 50,
    color: charts.ColorUtil.fromDartColor(Colors.yellow),
  ),
  BarChartModel(
    year: "May",
    financial: 40,
    color: charts.ColorUtil.fromDartColor(Colors.lightBlueAccent),
  ),
  BarChartModel(
    year: "Jun",
    financial: 5,
    color: charts.ColorUtil.fromDartColor(Colors.pink),
  ),
  BarChartModel(
    year: "Jul",
    financial: 0,
    color: charts.ColorUtil.fromDartColor(Colors.purple),
  ),
  BarChartModel(
    year: "Aug",
    financial: 3, // Add your financial data for Aug here
    color: charts.ColorUtil.fromDartColor(Colors.orange), // Add your desired color for Aug here
  ),
  BarChartModel(
    year: "Sep",
    financial: 1, // Add your financial data for Sep here
    color: charts.ColorUtil.fromDartColor(Colors.teal), // Add your desired color for Sep here
  ),
  BarChartModel(
    year: "Oct",
    financial: 4, // Add your financial data for Oct here
    color: charts.ColorUtil.fromDartColor(Colors.deepOrange), // Add your desired color for Oct here
  ),
  BarChartModel(
    year: "Nov",
    financial: 0, // Add your financial data for Nov here
    color: charts.ColorUtil.fromDartColor(Colors.indigo), // Add your desired color for Nov here
  ),
  BarChartModel(
    year: "Dec",
    financial: 0, // Add your financial data for Dec here
    color: charts.ColorUtil.fromDartColor(Colors.lime), // Add your desired color for Dec here
  ),
];



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
 
  
 
   @override
  void initState() {
    super.initState();
    getAllWorkers();
    getAlluserss();
    getgw();
    getgu();
   
 
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
          Center(child:Text("statistics",style: TextStyle(fontSize:25,fontWeight: FontWeight.bold ),)),
         SizedBox(height: 10,),
          Center(child:Text(" نسبة المُستخدمين و العُمال الفَنيين لهذا التطبيق ",style: TextStyle(fontSize: 18),)),
        
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
          Center(child:Text("عـدد الطَـلـبـات بـالـشـهـر ",style: TextStyle(fontSize: 18),)),
      
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
          Center(child:Text("  الـخـدَمـات الـمـطـلـوبـة ",style: TextStyle(fontSize: 18),)),
  
         Center(
          child: PieChart(
            dataMap: dataMap1,
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
          Center(child:Text("   نسبة العُمال من الذكور والإناث ",style: TextStyle(fontSize: 18),)),
         
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
          Center(child:Text("   نسبة المُستخدمين من الذكور والإناث ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
        
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
