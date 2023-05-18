import 'package:faniweb/chat/chat_screen.dart';
import 'package:faniweb/main.dart';
import 'package:faniweb/menu_controller.dart';
import 'package:faniweb/dashboard/Tech/profiles/foraTech.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

var imag = NetworkImage(
    'https://firebasestorage.googleapis.com/v0/b/fani-2.appspot.com/o/imagesprofiles%2Fuser.png?alt=media&token=30236ccb-7cb1-44f9-b200-4dc2a661c2a5');

class TmsgsU extends StatefulWidget {
  @override
  _TmsgsUState createState() => _TmsgsUState();
}

class _TmsgsUState extends State<TmsgsU> {
  List<Map<String, dynamic>> filteredWorkers = [...users];

  void filterWorkers(String query) {
    setState(() {
      filteredWorkers = users
          .where((w) =>
              w['name'].toLowerCase().contains(query.toLowerCase().trim()))
          .toList();
    });
  }

  Widget builimg(String workn) {
    return Container(
      width: MediaQuery.of(context).size.width / 5.5,
      height: MediaQuery.of(context).size.height / 10.5,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: lb,
          width: 0.0,
        ),
        image: DecorationImage(
          image: imag,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 246, 246, 246),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    i = 6;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                              create: (context) => MenuControllerr())
                        ],
                        child: TechPage(),
                      ),
                    ),
                  );
                },
                child: Text(
                  ' تواصل مع العامل',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    decoration: i == 6 ? TextDecoration.underline : null,
                    color: i == 6 ? Colors.blue : null,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    i = 9;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                              create: (context) => MenuControllerr())
                        ],
                        child: TechPage(),
                      ),
                    ),
                  );
                },
                child: Text(
                  'تواصل مع الزبون',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    decoration: i == 9 ? TextDecoration.underline : null,
                    color: i == 9 ? Colors.blue : null,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    i = 10;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                              create: (context) => MenuControllerr())
                        ],
                        child: TechPage(),
                      ),
                    ),
                  );
                },
                child: Text(
                  'تواصل مع المُدير',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    decoration: i == 10 ? TextDecoration.underline : null,
                    color: i == 10 ? Colors.blue : null,
                  ),
                ),
              ),
          
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                onChanged: (value) => filterWorkers(value),
                decoration: InputDecoration(
                  hintText: 'ابحث من خلال اسم الزَبون',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              SizedBox(height: 10),
              if (filteredWorkers.isEmpty)
                Center(child: Text('لا يوجد مستخدمين بهذا الاسم'))
              else
                Column(
                  children: filteredWorkers.map((user) {
                    return Column(
                      children: [
                        employee(user['name'], user['image']),
                        Divider(thickness: 0.5, color: Colors.grey),
                      ],
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget employee(text, img) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(img),
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(text),
                  Text("تواصل مع $text",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: IconButton(
              icon: Icon(
                Icons.chat,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatScreen(
                            senderName: WorW['name'],
                            receverName: text,
                          )),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
