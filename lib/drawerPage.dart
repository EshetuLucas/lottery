import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'DB.dart';
class DrawerPage extends StatefulWidget {
  DrawerPage({Key key}) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  bool istaped = true;

  bool isSettingTapped = false;
  final String logeIn = "in";
  final bool disableAdds = false;
  final String ads = "ads";
  bool isFirstTime = true;
  bool checkBoxValue1 = true;

  /// ------------------------------------------------------------
  /// Method that returns the user decision to allow notifications
  /// ------------------------------------------------------------
  Future<bool> getAllowsNotifications() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(ads);
  }

  Future<bool> getLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(logeIn) == "in" ?? false;
  }
  Future<bool> setAllowsNotifications({bool value, String login}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(ads, value);
    prefs.setString(logeIn, login);
  }
 
  DatabaseHelper dbHelper;
  bool dbCheck = false;
  List row;
  List usersList;
  int played = -1;
  bool account = false;
  @override
  void initState() {
    super.initState();
  isUpdated = false;
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
      "name": row[0]['name'],
      "amount": 0,
      "over": amount,
      "bale": row[0]['bale'],
      "phone_number": row[0]['phone_number'],
      "birr": row[0]['birr'],
      "house": row[0]['house'],
      "agent": row[0]['agent'],
    };
    final rowsAffected = await dbHelper.update1(passwordMap).then((value) {
      print("updateeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      setState(() {
        message = "your bingo is rechared with $amount games";
        isUpdated = true;
      });
      Navigator.of(context).pop(false);
      createAlert1(context);
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

  recharge() {
    createAlert1(context);
    Connectivity().checkConnectivity().then((value) {
      if (value == ConnectivityResult.mobile ||
          value == ConnectivityResult.wifi) {
        try {
          http.get("https://newdayshotel.com/demo/api.php",
              headers: {"Accept": "application/json"}).then(
            (value) {
              if (value.statusCode == 200) {
                usersList = jsonDecode(value.body);
                print(value.toString());
                //print(usersList.toString());
                usersList.forEach((element) {
                  if (element['phone_number'].toString() ==
                      row[0]['phone_number'].toString()) {
                    if (element['caller_amount'].toString() != "0") {
                      http.post("https://newdayshotel.com/demo/update.php",
                          body: {
                            "phone_number": "${row[0]['phone_number']}",
                          }).then((value) {
                        if (value.statusCode == 200) {
                          print(value.body.toString());
                          _update(element["caller_amount"]);
                        }
                      });
                    } else {
                      setState(() {
                        isUpdated = true;
                        message = "Your bingo is already recharged!";
                      Navigator.of(context).pop(false);
                      createAlert1(context);
                      });
                    }
                  }
                });
              } else {
                print(value.statusCode.toString());
              }
            },
          );
        } catch (e) {
        }
      } else {
        setState(() {
          isUpdated = true;
        });
        //Navigator.of(context).pop(false);
        //createAlert1(context);
      }
      //  http.get(
      //     "https://newdayshotel.com/demo/api.php",
      //     headers: {"Accept": "application/json"})
    });
  }
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
 

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      color: Color(0xFF1c1863),
                      height: 200,
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 35,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
                                height: 150,
                                width: 150,
                                child: Image.asset(
                                  "assets/logo.png",
                                  fit: BoxFit.contain,
                                  // color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 45),
                   
                     GestureDetector(
                          onTap: () {
                            createAlert(context, "Check");
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 15),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.check,
                                    color: Color(0xFF1c1863), size: 30),
                                SizedBox(width: 20),
                                Text(
                                  "Check ",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: "Raleway",
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                   
                       
                        
                        SizedBox(height: 15),
                     
                        GestureDetector(
                          onTap: () {
                            createAlert(context, "Erase");
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 15),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.delete, color: Colors.red, size: 30),
                                SizedBox(width: 20),
                                Text(
                                  "Erase",
                                  style: TextStyle(
                                      fontSize: 17, fontFamily: "RaleWay"),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        GestureDetector(
                          onTap: () {
                            recharge();
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 15),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.update,
                                    color: Color(0xFF1c1863), size: 30),
                                SizedBox(width: 20),
                                Text(
                                  "Recharge",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: "Raleway",
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                         GestureDetector(
                      onTap: () {
                        // createAlert(context);
                        setState(() {
                          if (isSettingTapped)
                            isSettingTapped = false;
                          else
                            isSettingTapped = true;
                        });

                        // Navigator.of(context).push(new MaterialPageRoute(
                        //     builder: (BuildContext context) {
                        //   return Setting();
                        // }));

                        //  Navigator.of(context).push(new MaterialPageRoute(
                        //     builder: (BuildContext context) {
                        //   return About("Check for Update");
                        // }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 15),
                        child: Row(
                          children: <Widget>[
                           Icon(Icons.account_circle,
                                    color: Color(0xFF1c1863), size: 30),
                                SizedBox(width: 20),
                                Text(
                                  "My Account",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: "Raleway",
                                  ),
                                )
                          ],
                        ),
                      ),
                    ),
                    isSettingTapped
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(70, 0, 0, 4),
                            child: Container(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: GestureDetector(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                "Name:  ${row[0]['name']}",
                                                style: TextStyle(
                                                    color: Color(0xFF1c1863),
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "RaleWay"),
                                              ),
                                             
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Phone number: ${row[0]['phone_number']}",
                                          style: TextStyle(
                                              color: Color(0xFF1c1863),
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "RaleWay"),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Remained bingo: ${row[0]['over']-row[0]['amount']}",
                                          style: TextStyle(
                                              color:Color(0xFF1c1863),
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "RaleWay"),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                          )
                        : Container(),
                    SizedBox(height: 20),
                    
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Powered by ',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Raleway",
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: 'DukaTechs',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
