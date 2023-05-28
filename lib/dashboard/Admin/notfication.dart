import 'package:faniweb/main.dart';
import 'package:flutter/material.dart';

class Notfication extends StatefulWidget {
  @override
  _NotficationState createState() => _NotficationState();
}

class _NotficationState extends State<Notfication> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: lb, borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text.rich(TextSpan(
                 style: TextStyle( color: Colors.black, fontFamily: 'Arial'),
                    children: [
                      TextSpan(
                          text: "تـطـبـيـق فَّـنّـي",
                                             style: TextStyle(
                                              fontWeight: FontWeight.bold,
fontSize: 25,
color: Colors.black,
fontFamily: 'Montserrat',
),)
                    ])),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "تطبيق يساعد على ربط المستخدمين بالعُمال الفَّنين",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
fontSize: 12,
color: Colors.black,
fontFamily: 'Noto Kufi Arabic',
),),
  SizedBox(
                  height: 5,
                ),
 Text(
                    "يسهل على المستخدمين الحصول على خدمات صيانة المنزل ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
fontSize: 12,
color: Colors.black,
fontFamily: 'Noto Kufi Arabic',
),),
  SizedBox(
                  height: 5,
                ),
 Text(
                    "توفير العديد من فرص العمل للشباب والعمال الفنين الفلسطينين",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
fontSize: 11,
color: Colors.black,
fontFamily: 'Noto Kufi Arabic',
),),
                SizedBox(
                  height: 10,
                ),
              ],
          
          ),
          if (MediaQuery.of(context).size.width >= 673) ...{
            Spacer(),
            Image.asset(
              "images/1.png",
              height: 150,
            )
          },
        ],
      ),
    );
  }
}
