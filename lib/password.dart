import 'dart:math';

import 'package:Lottery/bingo_normal.dart';
import 'package:Lottery/home_page.dart';
import 'package:flutter/material.dart';

import 'DB.dart';

class Password extends StatefulWidget {
  Password({Key key}) : super(key: key);

  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  String password;
  DatabaseHelper dbHelper;
  int rand;
  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper.instance;
 

    int min = 1;
    int max = 21;
    Random rnd = new Random();
    rand = min + rnd.nextInt(max - min);
    checkDataBase();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isFirstTime = true;
  checkDataBase() {
    dbHelper.queryRowCount().then((value) {
      setState(() {
        if (value > 0) isFirstTime = false;
        print(value.toString());
      });
    });
    dbHelper.queryAllRows().then((value) => print(value.toString()));
  }

  bool enterPassword = false;
  @override
  Widget build(BuildContext context) {
    return isFirstTime
        ? Scaffold(
            backgroundColor: Color(0xFF1c1863),
            body: Container(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: enterPassword
                    ? Center(
                        child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: TextField(
                              obscureText: true,
                              autofocus: true,

                              // controller: text2,
                              onChanged: (input) {
                                setState(() {
                                  password = input;
                                  if (password == ("duka10012345")) {
                                    print(
                                        "ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss");
                                    Map<String, dynamic> passwordMap = {
                                      "id": 1,
                                      "name": "admin",
                                      "amount": 0,
                                      "over": 1,
                                      "bale": 0,
                                      "player": 0,
                                    };
                                    dbHelper.insert1(passwordMap).then(
                                        (value) => print(value.toString()));
                                    for (int i = 1; i <= 10; i++) {
                                      Map<String, dynamic> passwordMap = {
                                        "id": i,
                                        "name": "n",
                                        "amount": 0,
                                        "over": 1,
                                        "bale": 3,
                                        "player": 0,
                                      };
                                      dbHelper
                                          .insert(passwordMap)
                                          .then((value) {});
                                    }
                                  
                                    Navigator.of(context).push(
                                        new MaterialPageRoute(
                                            builder: (BuildContext context) {
                                      
                                      return HomePage();
                                    }));
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                // prefixIcon: Padding(
                                //   padding:
                                //       const EdgeInsetsDirectional.only(end: 15.0),
                                //   child: Icon(Icons.person, color: Colors.black),
                                // ),
                                labelText: ' ',
                              ),
                            )),
                      ))
                    : GestureDetector(
                        onDoubleTap: () {
                          setState(() {
                            enterPassword = true;
                            print(
                                "dddddddddddddddddddddddddddddddddddddddddddddddd");
                          });
                        },
                        child: Container(
                          color: Color(0xFF1c1863),
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                              child: Container(
                                  child: Padding(
                            padding: EdgeInsets.all(0),
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'V',
                                      style: TextStyle(
                                          fontSize: 60,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.yellow)),
                                  TextSpan(
                                      text: 'egas',
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w200,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.yellow)),
                                ],
                              ),
                            ),
                            // Text("Vegas",style: TextStyle(fontSize:30,fontWeight: FontWeight.w600,fontStyle: FontStyle.italic,color: Colors.yellow)),
                          ))),
                        ),
                      ),
              ),
            ))
        : HomePage();
  }
}
