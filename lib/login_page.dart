import 'dart:async';
import 'dart:ui';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'DB.dart';
import 'home_page.dart';

class Login_page extends StatefulWidget {
  Login_page({Key key}) : super(key: key);

  @override
  _Login_pageState createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  DatabaseHelper dbHelper;
  String errorMessage = "user name or password is not corret";
  @override
  void initState() {
    //TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });
    controller.forward();
    dbHelper = DatabaseHelper.instance;
  }
  String userNameInput;
  String phone_number;
  bool error = false;
  final String logeIn = "in";
  final bool disableAdds = false;
  final String ads = "";
  String wokil = "0916740322";
  String agentName = "0916740322";

  /// ------------------------------------------------------------
  /// Method that returns the user decision to allow notifications
  /// ------------------------------------------------------------

  //  Future<bool> getLogin() async {
  // final SharedPreferences prefs = await SharedPreferences.getInstance();

  // 	return prefs.getString(logeIn)=="in"?? false;
  // }
  /// ----------------------------------------------------------
  /// Method that saves the user decision to allow notifications
  /// ----------------------------------------------------------
  Future<bool> setLogin(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool("loginVegas", value).then((value) {});
  }

  bool isUpdated = false;
  createAlert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white10,
            title: isUpdated
                ? Container(
                    //color: Colors.black,
                    child: Center(
                        child: Text("No internet",
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

  sendData() {
    Connectivity().checkConnectivity().then((value) {
      if (value == ConnectivityResult.mobile ||
          value == ConnectivityResult.wifi) {
        try {
          http.post("https://newdayshotel.com/demo/get.php", body: {
            "name": "$userNameInput",
            "phone_number": "$phone_number",
          })
              //  http.get(
              //     "https://newdayshotel.com/demo/api.php",
              //     headers: {"Accept": "application/json"})
              .then(
            (value) {
              if (value.statusCode == 200) {
                if (value.body.toString() != "duplicate") {
                  setLogin(true);
                  Map<String, dynamic> passwordMap = {
                    "id": 1,
                    "name": userNameInput,
                    "amount": 0,
                    "over": 2,
                    "bale": 4,
                    "phone_number": phone_number,
                    "birr": 0,
                    "house": 3,
                    "agent": wokil
                  };
                  dbHelper
                      .insert1(passwordMap)
                      .then((value) => print(value.toString()));
                  for (int i = 1; i <= 10; i++) {
                    Map<String, dynamic> passwordMap = {
                      "id": i,
                      "name": "n",
                      "amount": 0,
                      "over": 1,
                      "bale": 3,
                      "phone_number": "0",
                    };
                    dbHelper.insert(passwordMap).then((value) {});
                  }
                  setLogin(true);
                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (BuildContext context) {
                    return HomePage();
                  }));
                } else {
                  Navigator.of(context).pop(false);
                  setState(() {
                    errorMessage = "phone number already exist";
                    error = true;
                  });
                }
                print(value.body.toString());
                //  Navigator.of(context).pop(false);
                print(
                    "mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
              } else if (value.persistentConnection) {
                setState(() {
                  isUpdated = true;
                });
                Navigator.of(context).pop(false);
                createAlert(context);
              } else {
                print(value.statusCode.toString());
                setState(() {
                  isUpdated = true;
                });
                Navigator.of(context).pop(false);
                createAlert(context);
              }
            },
          );
        } catch (e) {}
      } else {
        setState(() {
          isUpdated = true;
        });
        Navigator.of(context).pop(false);
        createAlert(context);
      }
    });
  }
  Widget build(BuildContext context) {
     void houseUpdate(data) {
      showDialog(
        context: context,
        builder: (context) => Container(
          color: Colors.transparent,
          child: AlertDialog(
            title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(data=='Agent Name'?'Agent Name':"House"),
                  ],
                )),
            content: Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Padding(
                padding: EdgeInsets.all(2.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextField(
                          keyboardType: TextInputType.numberWithOptions(),
                         // controller: text2,
                          onChanged: (input) {
                            setState(() {
                             // validate2 = false;
                            });
                            agentName = input;
                          },
                          decoration: InputDecoration(
                            // errorText:
                            //     validate2 ? "This field can't be empty" : null,
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                            // prefixIcon: Padding(
                            //   padding:
                            //       const EdgeInsetsDirectional.only(end: 15.0),
                            //   child: Icon(Icons.person, color: Colors.black),
                            // ),
                            labelText: 'Phone number',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: RaisedButton(
                  onPressed: () {
                   wokil = agentName;
                   Navigator.of(context).pop(false);
                        
                  },
                  padding: const EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    width: 90,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF1c1863),
                          Color(0xFF1c1863),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: const Text(
                      'Save',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF1c1863), width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  width: 90,
                  //height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Exit',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF1c1863),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      //  backgroundColor: Colors.pink,
      appBar: AppBar(
        backgroundColor: Color(0xFF1c1863),
        title: Padding(
          padding: EdgeInsets.all(8),
          child: Text("Login"),
        ),
      ),
      body: Center(
        child: FadeTransition(
          opacity: animation,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Card(
                clipBehavior: Clip.antiAlias,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  elevation: 60,
                  shadowColor: Colors.black45,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        color: Color(0xFF1c1863),
                        child: GestureDetector(
                          onDoubleTap: (){
                            houseUpdate("Agent Name");
                          },
                                                  child: Container(
                            // duration: Duration(seconds: 3),
                            //curve: Curves.easeIn,
                            height: 100,
                            width: 100,
                            child: Center(
                              child: Image.asset("assets/logo.png"),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(50, 5, 50, 30),
                              child: GestureDetector(
                                onDoubleTap: () {
                                 houseUpdate("Agent Name");

                                },
                                child: Container(
                                  width: double.infinity,
                                  child: Text(
                                    "LOGIN",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: FadeTransition(
                                opacity: animation,
                                child: TextField(
                                  onChanged: (input) {
                                    setState(() {
                                      error = false;
                                    }
                                    );
                                    userNameInput = input;
                                  },
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          end: 15.0),
                                      child: Icon(Icons.person,
                                          color: Colors.black),
                                    ),
                                    labelText: 'User name',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: FadeTransition(
                                opacity: animation,
                                child: TextField(
                                  // obscureText: true,
                                  keyboardType:
                                      TextInputType.numberWithOptions(),
                                  onChanged: (input) {
                                    setState(() {
                                      error = false;
                                    });
                                    phone_number = input;
                                  },
                                  decoration: InputDecoration(
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      prefixIcon: Padding(
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                                end: 15.0),
                                        child: Icon(Icons.phone,
                                            color: Colors.black),
                                      ),
                                      labelText: 'Phone number'),
                                ),
                              ),
                            ),
                            error
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 2),
                                    child: GestureDetector(
                                      onTap: () {
                                        print("onTap called.");
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        child: Text(
                                          errorMessage,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              height: 1,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 80, vertical: 8),
                              child: RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    if (phone_number
                                            .toString()
                                            .contains("09") &&
                                        phone_number.toString().length == 10 &&
                                        userNameInput.isNotEmpty) {
                                      createAlert(context);
                                      sendData();
                                    } else
                                      error = true;
                                  });
                                },
                                padding: const EdgeInsets.all(0.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                child: Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    gradient: LinearGradient(
                                      colors: <Color>[
                                        Color(0xFF1c1863),
                                        Color(0xFF1c1863),
                                      ],
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(10.0),
                                  child: const Text(
                                    'Login',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                      // Transform.rotate(
                      //   angle: pi,
                      //   child: Login_page_background_bottom(
                      //       screenHeight:
                      //           MediaQuery.of(context).size.height /
                      //               3.5),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
