import 'dart:async';

import 'package:Lottery/DB.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BirrNormal extends StatefulWidget {
  BirrNormal({Key key}) : super(key: key);

  @override
  _BirrState createState() => _BirrState();
}

class _BirrState extends State<BirrNormal> {
  int amount = 3;
  int rowCount = 1;
  int crossAxis = 9;
  double paddingChanger = 1;
  int currentIndex = 1;
  int playerAmount = 0;
  int players = 0;
  int numberOfPlayer = 0;
  bool add = false;
  int winner = -1;
  int loss = -1;
  List lossIndex = new List();
  int over = 0;
  checkLoss(int index) {
    for (int i = 0; i < lossIndex.length; i++) {
      if (index == lossIndex[i]) {
        return true;
      }
    }
    return false;
  }

  calculate(bool winner) {
    playerAmount = amount * (players - 2);
    if (winner == false) {
      Map<String, dynamic> passwordMap = {
        "id": 1,
        "name": allData[0]['name'],
        "amount": allData[0]['amount'] - amount,
        "over": 0,
        "bale": amount,
        "player": players,
      };
      update(row: passwordMap);
      getData();
    } else {
      Map<String, dynamic> passwordMap = {
        "id": 1,
        "name": allData[0]['name'],
        "amount": allData[0]['amount'] + playerAmount,
        "over": 0,
        "bale": amount,
        "player": players,
      };
      update(row: passwordMap);
      getData();
    }

    getData();
  }

 changeAmount(String increase) {
    setState(() {
      if (increase == "increas") {
        amount++;
        Map<String, dynamic> passwordMap = {
          "id": 1,
          "name": allData[0]['name'],
          "amount": allData[0]['amount'],
          "over": 0,
          "bale": amount,
          "player": players,
        };
        update(row: passwordMap);
        getData();
      } else {
        amount--;
          Map<String, dynamic> passwordMap = {
          "id": 1,
          "name": allData[0]['name'],
          "amount": allData[0]['amount'],
          "over": 0,
          "bale": amount,
          "player": players,
        };
        update(row: passwordMap);
        getData();

      }
    });
    // print(amount.toString());
  }

 changePlayers(String increase) {
    setState(() {
      if (increase == "increas") {
        players++;
        Map<String, dynamic> passwordMap = {
          "id": 1,
          "name": allData[0]['name'],
          "amount": allData[0]['amount'],
          "over": 0,
          "bale": amount,
          "player": players,
        };
        update(row: passwordMap);
        getData();
      } else {
        players--;
          Map<String, dynamic> passwordMap = {
          "id": 1,
          "name": allData[0]['name'],
          "amount": allData[0]['amount'],
          "over": 0,
          "bale": amount,
          "player": players,
        };
        update(row: passwordMap);
        getData();

      }
    });
    // print(amount.toString());
  }

  DatabaseHelper dbHelper;
  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper.instance;
    dbHelper.queryRowCount().then((value) {
      setState(() {
        rowCount = value;
        crossAxis = rowCount;
        paddingChanger = value.toDouble();
      });
    });
    getData();
  }

  final text = TextEditingController();
  final text2 = TextEditingController();
  final text3 = TextEditingController();
  bool validate = false;
  bool validate2 = false;
  bool validate3 = false;
  double lat = 0;
  double long = 0;
  bool enabled = false;
  String name;
  int birr;
  List allData;
  bool isDataNull = true;
  insert() {
    Map<String, dynamic> passwordMap = {
      "id": rowCount + 1,
      "name": name,
      "amount": birr,
      "over": 0,
    };

    dbHelper.insert(passwordMap).then((value) {
      setState(() {
        istaped = true;
        //  createAlert(context);
      });
    });
  }

  update({Map row, index}) {
    Map<String, dynamic> passwordMap = {
      "id": index,
      "name": name,
      "amount": birr,
      "over": over,
      "bale": amount,
      "player": players,
    };
    if (row == null) {
      dbHelper.update(passwordMap).then((value) {
        setState(() {
          istaped = true;
          Navigator.pop(context);
          createAlert(context);
        });
      });
    } else {
      dbHelper.update(row).then((value) {
        setState(() {
          istaped = true;
        });
      });
    }
  }

  getData() {
    int counter = 0;
    dbHelper.queryAllRows().then((value) {
      setState(() {
        allData = value;
        isDataNull = false;
        for (int i = 0; i < allData.length; i++) {
          if (allData[i]['name'] == "Name") {
            counter++;
          }
          if (allData[i]['over'] == 1) {
            lossIndex.add(i);
          }
        }
        amount = allData[0]['bale'];
        players = allData[0]['player'];
        numberOfPlayer = allData.length - counter;
        print(value.toString());
      });
    });
  }

  bool istaped = false;

  createAlert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white10,
            title: istaped == true
                ? Container(
                    //color: Colors.black,
                    child: Center(
                        child: Text("done!",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white))),
                  )
                : Center(
                    child: SpinKitCircle(
                    color: Colors.black,
                    size: 60,
                  )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    void popUp() {
      showDialog(
        context: context,
        builder: (context) => Container(
          color: Colors.transparent,
          child: AlertDialog(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Account'),
            ),
            content: Container(
              height: MediaQuery.of(context).size.height / 7,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Padding(
                padding: EdgeInsets.all(2.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextField(
                          keyboardType: TextInputType.numberWithOptions(),
                          controller: text2,
                          onChanged: (input) {
                            setState(() {
                              validate2 = false;
                            });
                            birr = int.parse(input);
                          },
                          decoration: InputDecoration(
                            errorText:
                                validate2 ? "This field can't be empty" : null,
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                            // prefixIcon: Padding(
                            //   padding:
                            //       const EdgeInsetsDirectional.only(end: 15.0),
                            //   child: Icon(Icons.person, color: Colors.black),
                            // ),
                            labelText: 'Birr',
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
                    if (add)
                      insert();
                    else
                      update(index: 1);
                    createAlert(context);
                    Navigator.of(context).pop(false);
                    Timer(Duration(seconds: 3), () {
                      setState(() {
                        getData();
                        initState();
                      });

                      //  Navigator.of(context).push(
                      //                     new MaterialPageRoute(
                      //                         builder: (BuildContext context) {
                      //                   return Birr();
                      //                 }));
                    });
                    //  var reponse = await http.post("https://newdayshotel.com/demo/get.php",body:{
                    //                "name": "hello",
                    //                         });
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

    return Column(
      children: <Widget>[
        FittedBox(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Amount",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      // gradient: LinearGradient(
                      //   colors: <Color>[
                      //     Color(0xFF1c1863),
                      //     Color(0xFF1c1863),
                      //   ],
                      // ),
                    ),
                    width: 40,
                    padding: EdgeInsets.all(8.0),
                    child: Text(allData!=null?"${allData[0]['bale']}":"$amount",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        )),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 80,
                      child: FittedBox(
                        child: Column(children: <Widget>[
                          GestureDetector(
                            onTap: () => changeAmount("increas"),
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                // gradient: LinearGradient(
                                //   colors: <Color>[
                                //     Color(0xFF1c1863),
                                //     Color(0xFF1c1863),
                                //   ],
                                // ),
                              ),
                              child: Icon(
                                Icons.arrow_drop_up,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () => changeAmount("decreas"),
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                // gradient: LinearGradient(
                                //   colors: <Color>[
                                //     Color(0xFF1c1863),
                                //     Color(0xFF1c1863),
                                //   ],
                                // ),
                              ),
                              child: Icon(Icons.arrow_drop_down,
                                  color: Colors.white),
                            ),
                          )
                        ]),
                      ),
                    )),
                SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Players",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      // gradient: LinearGradient(
                      //   colors: <Color>[
                      //     Color(0xFF1c1863),
                      //     Color(0xFF1c1863),
                      //   ],
                      // ),
                    ),
                    width: 40,
                    padding: EdgeInsets.all(8.0),
                    child: Text(allData!=null?"${allData[0]['player']}":"$players",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        )),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 80,
                      child: FittedBox(
                        child: Column(children: <Widget>[
                          GestureDetector(
                            onTap: () => changePlayers("increas"),
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                // gradient: LinearGradient(
                                //   colors: <Color>[
                                //     Color(0xFF1c1863),
                                //     Color(0xFF1c1863),
                                //   ],
                                // ),
                              ),
                              child: Icon(
                                Icons.arrow_drop_up,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () => changePlayers("decreas"),
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                // gradient: LinearGradient(
                                //   colors: <Color>[
                                //     Color(0xFF1c1863),
                                //     Color(0xFF1c1863),
                                //   ],
                                // ),
                              ),
                              child: Icon(Icons.arrow_drop_down,
                                  color: Colors.white),
                            ),
                          )
                        ]),
                      ),
                    )),
                SizedBox(width: 20)
              ],
            ),
          ),
        ),
        FittedBox(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ButtonTheme(
                    minWidth: 80,
                    height: 30,
                    child: RaisedButton(
                      onPressed: () {
                        calculate(true);
                      },
                      padding: const EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        width: 90,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          gradient: LinearGradient(
                            colors: <Color>[Colors.green, Colors.green],
                          ),
                        ),
                        padding: const EdgeInsets.all(0.0),
                        child: const Text(
                          'Win',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontFamily: "Raleway",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ButtonTheme(
                    minWidth: 80,
                    height: 30,
                    child: RaisedButton(
                      onPressed: () {
                        calculate(false);
                      },
                      padding: const EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        width: 90,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          gradient: LinearGradient(
                            colors: <Color>[Colors.red, Colors.red],
                          ),
                        ),
                        padding: const EdgeInsets.all(0.0),
                        child: const Text(
                          'Lose',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontFamily: "Raleway",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20)
              ],
            ),
          ),
        ),
        SizedBox(height: 30),
        allData != null
            ? Expanded(
                          child: Center(
                  child: GestureDetector(
                  onDoubleTap: () {
                    popUp();
                  },
                  child: Container(
                      child: Card(
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              alignment: Alignment.center,
                              width: 80,
                              height: 80,
                              child: FittedBox(
                                child: Text(
                                  allData[0]['amount'].toString(),
                                  style: TextStyle(fontSize: 70),
                                ),
                              ),
                            ),
                          ))),
                )),
            )
            : Container(),
            Expanded(child: SizedBox(height: 100)),
      ],
    );
  }
}
