
import 'package:faniweb/main.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

  Map<String, double> dataMap = {
    "العُمال الفَنين": workers.length as double,
    "المُستخدمين":  users.length as double,
  };


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
          SizedBox(height: 10,),
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
         )
         
        ],)
    );
}
}
