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
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  children: [
                    TextSpan(text: "Hello World"),
                    TextSpan(
                        text: "New Web site",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ])),
              SizedBox(
                height: 10,
              ),
              Text(
                  " An example of the Lorem ipsum placeholder\n text on a green ans white webpage. \nUsing Lorem ipsum to focus attention on graphic \n elements in a webpage design proposal ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                "Read More..",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
              )
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
