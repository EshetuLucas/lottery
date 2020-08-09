import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:Lottery/Explore.dart';
import 'package:Lottery/bingo.dart';
import 'package:Lottery/birr.dart';
import 'package:Lottery/drawerPage.dart';
import 'package:Lottery/normalbirr.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'DB.dart';
import 'package:http/http.dart' as http;
import 'HomePageBackground.dart';
import 'fetan.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

List<String> menu = new List(2);

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController controller;
  bool istaped = false;
  DatabaseHelper dbHelper;
  bool dbCheck = false;
  List row;
  List usersList;
  int played = -1;
  bool account = false;
  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 2);
    dbHelper = DatabaseHelper.instance;
    dbHelper.queryAllRows1().then((value) {
      setState(() {
        print(value.toString());
        row = value;
      });
    });
    dbHelper.isDBnull().then((value) {
      setState(() {
        dbCheck = value;
      });
      print(value.toString());
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _update(amount) async {
    Map<String, dynamic> passwordMap = {
      "id": 1,
      "name": row[0]["name"],
      "amount": 0,
      "over": amount,
      "bale": 0,
      "phone_number": row[0]['phone_number'],
    };
    final rowsAffected = await dbHelper.update1(passwordMap).then((value) {
      print("updateeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      setState(() {
        message = "your bingo is rechared with $amount games";
        isUpdated = true;
         Navigator.of(context).pop(false);
      createAlert1(context);
      });
     
      isUpdated = true;
    });
    //intent();
    /// thi
    ///  je
    /// the ami idea
    /// teh
    ///
    ///

    //_delet("p181");

    // the ami
  }

  // recharge() {
  //   createAlert1(context);
  //   Connectivity().checkConnectivity().then((value) {
  //     if (value == ConnectivityResult.mobile ||
  //         value == ConnectivityResult.wifi) {
  //       try {
  //         http.get("https://newdayshotel.com/demo/api.php",
  //             headers: {"Accept": "application/json"}).then(
  //           (value) {
  //             if (value.statusCode == 200) {
  //               usersList = jsonDecode(value.body);
  //               //print(value.toString());
  //               //print(usersList.toString());
  //               usersList.forEach((element) {
  //                 if (element['phone_number'].toString() ==
  //                     row[0]['phone_number'].toString()) {
  //                   if (element['caller_amount'].toString() != "1") {
  //                     http.post("https://newdayshotel.com/demo/update.php",
  //                         body: {
  //                           "phone_number": "${row[0]['phone_number']}",
  //                         }).then((value) {
  //                       if (value.statusCode == 200) {
  //                         print(value.body.toString());

  //                         _update(element["caller_amount"]);
  //                       }
  //                     });
  //                   } else {
  //                     setState(() {
  //                       isUpdated = true;
  //                       message = "Your bingo is already recharged!";
  //                     Navigator.of(context).pop(false);
  //                     createAlert1(context);
                      
  //                     });
                      
  //                   }
  //                   // print("dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd")
  //                 }
  //               });
  //             } else {
  //               print(value.statusCode.toString());
  //             }
  //           },
  //         );
  //       } catch (e) {}
  //     } else {
  //       setState(() {
  //         isUpdated = true;
  //       });
  //       //Navigator.of(context).pop(false);
  //       //createAlert1(context);
  //     }
  //     //  http.get(
  //     //     "https://newdayshotel.com/demo/api.php",
  //     //     headers: {"Accept": "application/json"})
  //   });
  // }
  bool isUpdated = false;
  String message = "No internet";
  createAlert1(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white10,
            title: isUpdated
                ? Container(
                    //color: Colors.black,
                    child: Center(
                        child: Text(message,
                            style:
                                TextStyle(fontSize: 20, color: Colors.white))),
                  )
                : SpinKitCircle(
                    size: 40,
                    color: Colors.white,
                  ),
          );
        });
  }

  createAlert(BuildContext context, String dropDown) {
    dbHelper.queryAllRows1().then((value) {
      setState(() {
        row = value;
        istaped = true;
        played = row[0]['amount'];
        print("${row[0]['amount']}");
        //    playedValue = value.toInt();
        //  print("from $value" );

        return dropDown == "Check"
            ? showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.white10,
                    title: istaped == true
                        ? Container(
                            //color: Colors.black,
                            child: Center(
                                child: Text("$played",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white))),
                          )
                        : Center(
                            child: SpinKitCircle(
                              color: Colors.white,
                              size: 60,
                            ),
                          ),
                  );
                })
            : showDialog(
                context: context,
                builder: (context) => Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.transparent,
                  child: AlertDialog(
                    title: Text(
                      'Are you sure?',
                      style: TextStyle(
                          fontFamily: "Raleway", fontWeight: FontWeight.bold),
                    ),
                    content: Text(
                      'Do you want to clear history?',
                      style: TextStyle(fontFamily: "Raleway"),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        /*Navigator.of(context).pop(true)*/
                        child: Text(
                          'No',
                          style: TextStyle(fontFamily: "Raleway"),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                           isUpdated = false;
                          Navigator.of(context).pop(false);
                          createAlert1(context);
                          if(row.length>1)
                          {for (int i = 2; i <= row.length; i++) {
                            dbHelper.delete1(i).then((value) {
                              if (i == row.length) {
                                message = "done!";
                                Navigator.of(context).pop(false);
                                createAlert1(context);
                                isUpdated = true;
                              }
                              // istaped = false;
                            });
                          }
                          }
                          else{
                             message = "done!";
                                Navigator.of(context).pop(false);
                                createAlert1(context);
                                isUpdated = true;
                          }
                        },
                        child: Text(
                          'Yes',
                          style: TextStyle(
                            fontFamily: "Raleway",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
        // showDialog(
        //     context: context,
        //     builder: (context) {
        //       for(int i = 2;i<=row.length;i++)
        //       {
        //         dbHelper.delete1(i).then((value) {
        //             istaped = false;
        //         });

        //       }
        //       return AlertDialog(
        //         backgroundColor: Colors.white10,
        //         title: istaped == true
        //             ? Container(
        //                 //color: Colors.black,
        //                 child: Center(
        //                     child: Text("done!",
        //                         style: TextStyle(
        //                             fontSize: 20, color: Colors.white))),
        //               )
        //             : Center(
        //                 child:  SpinKitCircle(
        //                         color: Colors.white,
        //                         size: 60,
        //                       ),
        //               ),
        //       );
        //     });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    void popUp() {
      showDialog(
        context: context,
        builder: (context) => Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.transparent,
          child: AlertDialog(
            title: Text(
              'Are you sure?',
              style:
                  TextStyle(fontFamily: "Raleway", fontWeight: FontWeight.bold),
            ),
            content: Text(
              'Do you want to exit the App?',
              style: TextStyle(fontFamily: "Raleway"),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'No',
                  style: TextStyle(fontFamily: "Raleway"),
                ),
              ),
              FlatButton(
                onPressed: () => exit(0),
                /*Navigator.of(context).pop(true)*/
                child: Text(
                  'Yes',
                  style: TextStyle(fontFamily: "Raleway"),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // void setting() {
    //   isUpdated = false;
    //   showDialog(
    //       context: context,
    //       builder: (context) => Container(
    //             color: Colors.transparent,
    //             child: Center(
    //               child: Container(
    //                 // color: Colors.pink,
    //                 height: MediaQuery.of(context).size.height * 0.7,
    //                 width: MediaQuery.of(context).size.width * 0.8,
    //                 child: Scaffold(
    //                   appBar: AppBar(
    //                     backgroundColor: Color(0xFF1c1863),
    //                     title: Text("Setting"),
    //                   ),
    //                   body: Column(children: <Widget>[
    //                     SizedBox(height: 45),
    //                     GestureDetector(
    //                       onTap: () {
    //                         createAlert(context, "Check");
    //                       },
    //                       child: Padding(
    //                         padding:
    //                             const EdgeInsets.only(left: 20, bottom: 15),
    //                         child: Row(
    //                           children: <Widget>[
    //                             Icon(Icons.check,
    //                                 color: Color(0xFF1c1863), size: 30),
    //                             SizedBox(width: 20),
    //                             Text(
    //                               "Check ",
    //                               style: TextStyle(
    //                                 fontSize: 17,
    //                                 fontFamily: "Raleway",
    //                               ),
    //                             )
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                     SizedBox(height: 15),
    //                     GestureDetector(
    //                       onTap: () {
    //                         createAlert(context, "Erase");
    //                       },
    //                       child: Padding(
    //                         padding:
    //                             const EdgeInsets.only(left: 20, bottom: 15),
    //                         child: Row(
    //                           children: <Widget>[
    //                             Icon(Icons.delete, color: Colors.red, size: 30),
    //                             SizedBox(width: 20),
    //                             Text(
    //                               "Erase",
    //                               style: TextStyle(
    //                                   fontSize: 17, fontFamily: "RaleWay"),
    //                             )
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                     SizedBox(height: 15),
    //                     GestureDetector(
    //                       onTap: () {
    //                         recharge();
    //                       },
    //                       child: Padding(
    //                         padding:
    //                             const EdgeInsets.only(left: 20, bottom: 15),
    //                         child: Row(
    //                           children: <Widget>[
    //                             Icon(Icons.update,
    //                                 color: Color(0xFF1c1863), size: 30),
    //                             SizedBox(width: 20),
    //                             Text(
    //                               "Recharge",
    //                               style: TextStyle(
    //                                 fontSize: 17,
    //                                 fontFamily: "Raleway",
    //                               ),
    //                             )
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                     SizedBox(height: 15),
                        
    //                     // GestureDetector(
    //                     //   onTap: () {
    //                     //     Navigator.of(context).push(new MaterialPageRoute(
    //                     //         builder: (BuildContext context) {
    //                     //       return About("About");
    //                     //     }));
    //                     //   },
    //                     //   child: Padding(
    //                     //     padding: const EdgeInsets.only(left: 20, bottom: 15),
    //                     //     child: Row(
    //                     //       children: <Widget>[
    //                     //         Icon(Icons.error, color: Colors.pink, size: 30),
    //                     //         SizedBox(width: 20),
    //                     //         Text(
    //                     //           "About",
    //                     //           style: TextStyle(
    //                     //             fontSize: 17,
    //                     //             fontFamily: "Raleway",
    //                     //           ),
    //                     //         )
    //                     //       ],
    //                     //     ),
    //                     //   ),
    //                     // ),
    //                     SizedBox(height: 20),
    //                   ]),
    //                 ),
    //               ),
    //             ),
    //           ));
    // }

    return WillPopScope(
      onWillPop: () {
        popUp();
      },
      child: Scaffold(
          //rbackgroundColor: Colors.white38,
          appBar: GradientAppBar(
            elevation: 0,
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFF1c1863),
                Color(0xFF1c1863),
              ],
            ),
            title: Container(
              child: Row(
                children: <Widget>[
                  Expanded(child: Container(child: Text("Vegas"))),
                  PopupMenuButton<String>(
                    padding: EdgeInsets.all(0),
                    onSelected: (String choice) {
                      switch (choice) {
                        case "Setting":
                         // setting();
                          break;
                        case "Check":
                          createAlert(context, choice);
                          Timer(Duration(seconds: 3), () {
                            setState(() {});
                          });
                          break;
                        case "About":
                          //recharge();
                          // setting();
                          break;
                      }
                      if (choice == "Log out") {}

                      print(choice);
                    },
                    itemBuilder: (BuildContext context) {
                     // menu[0] = "Setting";
                      menu[0] = "About";
                      menu[1] = "Check";

                      return menu.map((String choice) {
                        print(menu[0]);
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  )
                ],
              ),
            ),
            bottom: TabBar(
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              controller: controller,
              unselectedLabelColor: Colors.white30,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.all(0),
              labelPadding: EdgeInsets.fromLTRB(1, 1, 10, 0),
              indicatorColor: Colors.white,
              tabs: <Tab>[
                Tab(
                  text: ('Lottery'),
                ),
                Tab(
                  text: ('Other'),
                ),
              ],
            ),
          ),
          drawer: DrawerPage(),
          body: Stack(
            children: <Widget>[
              new HomePageBacground(
                  screenHeight: MediaQuery.of(context).size.height * 0.99),
              new TabBarView(
                controller: controller,
                children: <Widget>[
                  new Explore(),
                  //  new Explore(birr: "birr"),
                  new Birr()

                  //new ForMe(),
                ],
              ),
            ],
          )),
    );
  }
}
