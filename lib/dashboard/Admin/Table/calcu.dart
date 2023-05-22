
import 'package:faniweb/main.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'bar_chart_model.dart';

  Map<String, double> dataMap = {
    "العُمال الفَنين": workers.length as double,
    "المُستخدمين":  users.length as double,
  };
final List<BarChartModel> data = [
    BarChartModel(
      year: "2014",
      financial: 250,
      color: charts.ColorUtil.fromDartColor(Colors.blueGrey),
    ),
    BarChartModel(
      year: "2015",
      financial: 300,
      color: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    BarChartModel(
      year: "2016",
      financial: 100,
      color: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    BarChartModel(
      year: "2017",
      financial: 450,
      color: charts.ColorUtil.fromDartColor(Colors.yellow),
    ),
    BarChartModel(
      year: "2018",
      financial: 630,
      color: charts.ColorUtil.fromDartColor(Colors.lightBlueAccent),
    ),
    BarChartModel(
      year: "2019",
      financial: 950,
      color: charts.ColorUtil.fromDartColor(Colors.pink),
    ),
    BarChartModel(
      year: "2020",
      financial: 400,
      color: charts.ColorUtil.fromDartColor(Colors.purple),
    ),
  ];


class maths extends StatefulWidget {
  @override
  _mathsState createState() => _mathsState();
}
class _mathsState extends State<maths> {

 
   @override
  void initState() {
    super.initState();
   
 
  }

  Widget build(BuildContext context) {
    List<charts.Series<BarChartModel, String>> series = [
      charts.Series(
        id: "financial",
        data: data,
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
            dataMap: dataMap,
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
          Center(child:Text("عـدد الطَـلـبـات بـالـشـهـر ",style: TextStyle(fontSize: 18),)),
      
         Center(
          child:
          SizedBox(
            height: 500,
            width: 500,
            child:charts.BarChart(
          series,
          animate: true,
               ) ,
          )
         ),
             SizedBox(height: 35,),
          Center(child:Text("  الـخـدَمـات الـمـطـلـوبـة ",style: TextStyle(fontSize: 18),)),
  
         Center(
          child: PieChart(
            dataMap: dataMap,
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
            dataMap: dataMap,
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
          Center(child:Text("   نسبة المُستخدمين من الذكور والإناث ",style: TextStyle(fontSize: 18),)),
        
         Center(
          child: PieChart(
            dataMap: dataMap,
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
