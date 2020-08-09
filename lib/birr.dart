import 'dart:async';

import 'package:Lottery/DB.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Birr extends StatefulWidget {
  Birr({Key key}) : super(key: key);

  @override
  _BirrState createState() => _BirrState();
}

class _BirrState extends State<Birr> {
  int amount = 3;
  int calculateTouch = 0;
  int rowCount = 1;
  int crossAxis = 9;
  double paddingChanger = 1;
  int currentIndex = 1;
  double playerAmount = 0;
  int numberOfPlayer = 0;
  bool add = false;
  int winner = -1;
  int loss = -1;
  List lossIndex = new List();
  int over = 0;
  List history;
  List historyData = new List();
  int queryRow = 0;
  bool isDoubleTapped = false;
  var histValue;
  List winners = new List();
  checkWinners(int index) {
    if (winners != null) {
      // {winners.forEach((element) {
      //   if(element==index)
      //   { return true;}

      // });
      for (int i = 0; i < winners.length; i++) {
        if (index == winners[i]) return true;
      }
    }
    return false;
  }

  checkLoss(int index) {
    for (int i = 0; i < lossIndex.length; i++) {
      if (index == winners[i]) {
        return true;
      }
    }
    return false;
  }

  calculate() {
    if (isDoubleTapped) {
      calculateTouch = history[0]['birr'] + 1;
      Map<String, dynamic> passwordMapUpdate = {
        "id": 1,
        "name": history[0]['name'],
        "amount": history[0]['amount'],
        "over": history[0]['over'],
        "bale": amount,
        "phone_number": history[0]['phone_number'],
        "birr": calculateTouch
      };
      dbHelper
          .update1(passwordMapUpdate)
          .then((value) => print(value.toString()));
      // createAlert(context);
      for (int i = 0; i < allData.length; i++) {
        historyData.add(allData[i]['amount']);
      }
      String amountText = historyData.join(',');
      Map<String, dynamic> passwordMap = {
        "id": queryRow + 1,
        "name": amountText,
        "amount": 0,
        "over": 0,
        "bale": amount,
        "phone_number": "0",
        "birr": "0"
      };
      dbHelper.insert1(passwordMap).then((value) => print(value.toString()));
      dbHelper.queryAllRows1().then((value) {
        print(value.toString());
        histValue = value[2]['name'].toString().split(",");
        print(histValue[0].toString());
      });
      playerAmount =
        double.parse(((amount * (numberOfPlayer - winners.length) - history[0]['house']) / winners.length).toStringAsFixed(2)) ;
      for (int i = 0; i < allData.length; i++) {
        if (!checkWinners(i) &&
            allData[i]['over'] == 0 &&
            allData[i]['name'] != "n") {
             // double amountChop =  double.parse((allData[i]['amount'] + playerAmount).toStringAsFixed(2));
          Map<String, dynamic> passwordMap = {
            "id": i + 1,
            "name": allData[i]['name'],
            "amount": allData[i]['amount'] - amount,
            "over": allData[i]['over'],
            "bale": amount,
            "phone_number": "0",
          };
          update(row: passwordMap);
        } else if (checkWinners(i)) {
        double amountChop =  double.parse((allData[i]['amount'] + playerAmount).toStringAsFixed(2));
          Map<String, dynamic> passwordMap = {
            "id": i + 1,
            "name": allData[i]['name'],
            "amount": amountChop,
            "over": allData[i]['over'],
            "bale": amount,
            "phone_number": "0",
          };
          update(row: passwordMap);
        }
        isDoubleTapped = false;
      }

      createAlert(context);
      //Navigator.of(context).pop(false);

      getData();
      initState();
    }
  }

  changeAmount(String increase) {
    setState(() {
      if (increase == "increas") {
        amount++;
        Map<String, dynamic> passwordMap = {
          "id": 1,
          "name": history[0]['name'],
          "amount": history[0]['amount'],
          "over": history[0]['over'],
          "bale": amount,
          "phone_number": history[0]['phone_number'],
          "birr": history[0]['birr'],
          "house": history[0]['house'],
          "agent": history[0]['agent']
        };

        dbHelper.update1(passwordMap).then((value) {
          setState(() {
             Navigator.of(context).pop(false);
            getData();
            // isUpdated = true;

            //createAlert(context);
          });
        });
        //getData();
      } else {
        amount--;
        Map<String, dynamic> passwordMap = {
          "id": 1,
          "name": allData[0]['name'],
          "amount": allData[0]['amount'],
          "over": allData[0]['over'],
          "bale": amount,
          "phone_number": allData[0]['phone_number'],
          "birr": history[0]['birr'],
          "house": history[0]['house'],
          "agent": history[0]['agent']
        };
        dbHelper.update1(passwordMap).then((value) {
          setState(() {
            // Navigator.of(context).pop(false);
            getData();
            // isUpdated = true;
            //createAlert(context);
          });
        });
        //  getData();
      }
    });
    //print(amount.toString());
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
    dbHelper.queryRowCount1().then((value) {
      queryRow = value;
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
  String name = 'Name';
  int birr;
  List allData;
  bool isDataNull = true;
  bool isUpdated = false;
  insert() {
    Map<String, dynamic> passwordMap = {
      "id": rowCount + 1,
      "name": name,
      "amount": birr,
      "over": 0,
      "bale": amount,
      "phone_number": "0",
    };

    dbHelper.insert(passwordMap).then((value) {
      setState(() {
        getData();
        isUpdated = true;
        Navigator.of(context).pop(false);
        createAlert(context);
        //  createAlert(context);
      });
    });
  }

  delete(int id) {
    dbHelper.delete(id).then((value) {
      setState(() {
        getData();
        isUpdated = true;
        Navigator.of(context).pop(false);
        createAlert(context);
        //initState();
      });
    });
  }

  update({Map row, index}) {
    Map<String, dynamic> passwordMap = {
      "id": index,
      "name": name,
      "amount": birr,
      "over": 0,
      "bale": amount,
      "phone_number": "0",
    };
    if (row == null) {
      dbHelper.update(passwordMap).then((value) {
        setState(() {
          Navigator.of(context).pop(false);
          getData();
          isUpdated = true;

          createAlert(context);
        });
      });
    } else {
      dbHelper.update(row).then((value) {
        setState(() {
          getData();
          isUpdated = true;
          Navigator.of(context).pop(false);
          createAlert(context);
        });
      });
    }
  }

  int maxLimit = 0;

  getData() {
    // if(allData!=null)
    // allData.clear();
    int counter = 0;
    dbHelper.queryAllRows1().then((value) {
      //print(value.toString());
      // histValue = value[2]['name'].toString().split(",");
      setState(() {
        history = value;
        amount = value[0]['bale'];
        maxLimit = value[0]['amount'];
        over = value[0]['over'];
        print(maxLimit.toString());
      });

      print(histValue[0].toString());
    });
    dbHelper.queryRowCount().then((value) {
      setState(() {
        rowCount = value;
        crossAxis = rowCount;
        paddingChanger = value.toDouble();
      });
    });
    dbHelper.queryAllRows().then((value) {
      setState(() {
        allData = value;

        isDataNull = false;
        for (int i = 0; i < allData.length; i++) {
          if (allData[i]['over'] == 1 || allData[i]['name'] == "n") {
            counter++;
          }
          if (allData[i]['over'] == 1) {
            lossIndex.add(i);
          }
        }
        numberOfPlayer = allData.length - counter;
        //print(value.toString());
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
              title: isUpdated
                  ? Container(
                      //color: Colors.black,
                      child: Center(
                          child: Text("done!",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.white))),
                    )
                  : SpinKitCircle(size: 40, color: Colors.white));
        });
  }

  @override
  Widget build(BuildContext context) {
    void popUp(add) {
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
                    Text(add ? 'New Player' : name),
                    !add
                        ? FlatButton(
                            onPressed: () => delete(currentIndex),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              width: 90,
                              //height: 50,r
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Remove',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container()
                  ],
                )),
            content: Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Padding(
                padding: EdgeInsets.all(2.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        controller: text,
                        onChanged: (input) {
                          setState(() {
                            validate = false;
                          });
                          name = input;
                          if (input.isEmpty) {
                            name = !add
                                ? allData[currentIndex - 1]['name']
                                : "name";
                          }
                        },
                        decoration: InputDecoration(
                          errorText:
                              validate ? "This field can't be empty" : null,
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          // prefixIcon: Padding(
                          //   padding:
                          //       const EdgeInsetsDirectional.only(end: 15.0),
                          //   child: Icon(Icons.person, color: Colors.black),
                          // ),
                          labelText: name,
                        ),
                      ),
                    ),
                    Expanded(
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
                    //createAlert(context);
                    if (add)
                      insert();
                    else
                      update(index: currentIndex);

                    // Navigator.of(context).pop(false);
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
                    Text(data=='amount'?'Amount':"House"),
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
                            labelText: 'birr',
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
                    //createAlert(context);
                   if(data!="amount")
                   { Map<String, dynamic> passwordMap = {
                      "id": 1,
                      "name": history[0]['name'],
                      "amount": history[0]['amount'],
                      "over": history[0]['over'],
                      "bale": history[0]['bale'],
                      "phone_number": history[0]['phone_number'],
                      "birr": history[0]['birr'],
                      "house": birr
                    };
                    dbHelper.update1(passwordMap).then((value) {
                      setState(() {
                         Navigator.of(context).pop(false);
                        getData();
                        // isUpdated = true;
                        isUpdated = true;
                        createAlert(context);
                      });
                    });
                   }
                   else
                  {
                    Map<String, dynamic> passwordMap = {
                      "id": 1,
                      "name": history[0]['name'],
                      "amount": history[0]['amount'],
                      "over": history[0]['over'],
                      "bale": birr,
                      "phone_number": history[0]['phone_number'],
                      "birr": history[0]['birr'],
                      "house": history[0]['house'],
                      "agent": history[0]['agent']
                    };
                    dbHelper.update1(passwordMap).then((value) {
                      setState(() {
                         Navigator.of(context).pop(false);
                        getData();
                        // isUpdated = true;
                        isUpdated = true;
                        createAlert(context);
                      });
                    });
                  }

                    

                    // Navigator.of(context).pop(false);
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

    return Stack(children: <Widget>[
      Column(
        children: <Widget>[
          SizedBox(height: 10),
          FittedBox(
            child: Container(
              padding: EdgeInsets.all(1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Column(children: <Widget>[
                    Row(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Players   ",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            // gradient: LinearGradient(
                            //   colors: <Color>[
                            //     Color(0xFF1c1863),
                            //     Color(0xFF1c1863),
                            //   ],
                            // ),
                          ),
                          width: 60,
                          padding: EdgeInsets.all(8.0),
                          child: Text("$numberOfPlayer",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ]),
                    Row(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Amount  ",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap:  () => houseUpdate("amount"),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              // gradient: LinearGradient(
                              //   colors: <Color>[
                              //     Color(0xFF1c1863),
                              //     Color(0xFF1c1863),
                              //   ],
                              // ),
                            ),
                            width: 60,
                            padding: EdgeInsets.all(8.0),
                            child: history!=null?Text("${history[0]['bale']}",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                )):Container(),
                          ),
                        ),
                      ),
                    ]),
                    Row(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "House   ",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () => houseUpdate("house"),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              // gradient: LinearGradient(
                              //   colors: <Color>[
                              //     Color(0xFF1c1863),
                              //     Color(0xFF1c1863),
                              //   ],
                              // ),
                            ),
                            width: 60,
                            padding: EdgeInsets.all(8.0),
                            child: history!=null? Text("${history[0]['house']}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                )):Container(),
                          ),
                        ),
                      ),
                    ]),
                  ]),
                  
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
                    child: ButtonTheme(
                      minWidth: 80,
                      height: 30,
                      child: RaisedButton(
                        onPressed: () {
                          calculate();
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFF1c1863),
                                Color(0xFF1c1863),
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(0.0),
                          child: const Text(
                            'Calculate',
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
                  Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ButtonTheme(
                        minWidth: 80,
                        height: 30,
                        child: RaisedButton(
                          onPressed: () {
                            add = true;
                            popUp(true);
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
                              border: Border.all(color: Colors.green, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              gradient: LinearGradient(
                                colors: <Color>[
                                  Colors.green,
                                  Colors.green,
                                  Colors.green
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.all(0.0),
                            child: const Text(
                              '+Add',
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
                  ]),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          allData != null
              ? Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 60,
                          child: GridView.builder(
                              scrollDirection: Axis.vertical,
                              addAutomaticKeepAlives: false,
                              itemCount: crossAxis,
                              gridDelegate:
                                  new SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxis,
                                childAspectRatio: (200 / 190),
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onLongPress: () {
                                    currentIndex = index + 1;
                                    name = allData[currentIndex - 1]['name'];
                                    popUp(false);
                                  },
                                  onDoubleTap: () {
                                    setState(() {
                                      winners.add(index);
                                      winner = index;
                                      //checkWinners(index);
                                      isDoubleTapped = true;
                                    });
                                  },
                                  onVerticalDragStart: (onVerticalDragStart) {
                                    setState(() {
                                      createAlert(context);
                                      Map<String, dynamic> passwordMap = {
                                        "id": index + 1,
                                        "name": allData[index]['name'],
                                        "amount": allData[index]['amount'],
                                        "over":
                                            allData[index]['over'] == 0 ? 1 : 0,
                                        "bale": amount,
                                        "phone_number": "0",
                                      };

                                      dbHelper
                                          .update(passwordMap)
                                          .then((value) {
                                        getData();
                                      });

                                      getData();
                                    });
                                    print(
                                        "ddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
                                  },
                                  child: Container(
                                    height: 30,
                                    //  width: MediaQuery.of(context).size.width / 10,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: allData[index]['over'] == 1
                                              ? Colors.red
                                              : Colors.black,
                                          width: allData[index]['over'] == 1
                                              ? 1
                                              : 1),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Material(
                                        clipBehavior: Clip.antiAlias,
                                        shadowColor: Colors.white,
                                        //color: Colors.black,
                                        borderRadius: new BorderRadius.only(
                                          topLeft: Radius.circular(0),
                                          topRight: Radius.circular(0),
                                        ),
                                        child: InkWell(
                                          // this is not the ture idea
                                          onTap: () {
                                            //   Navigator.of(context).push(
                                            //       new MaterialPageRoute(
                                            //           builder: (BuildContext context) {
                                            //     {
                                            //       int min = 1;
                                            //       int max = 21;
                                            //       Random rnd = new Random();
                                            //       rand = min + rnd.nextInt(max - min);
                                            //     }
                                            //     return widget.birr==null? Caller():Birr();
                                            //   }));
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 0, left: 0),
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: checkWinners(index)
                                                    ? Colors.green
                                                    : Colors.white,
                                              ),
                                              child: FittedBox(
                                                child: Text(
                                                    allData[index]['name'],
                                                    maxLines: 1,
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18),
                                                    textAlign:
                                                        TextAlign.center),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        //over - maxLimit != 0?
                        Container(
                          height: MediaQuery.of(context).size.height / 8,
                          child: GridView.builder(
                              scrollDirection: Axis.vertical,
                              addAutomaticKeepAlives: false,
                              itemCount: crossAxis,
                              gridDelegate:
                                  new SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxis,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 10,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 0.5),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Material(
                                        clipBehavior: Clip.antiAlias,
                                        shadowColor: Colors.white,
                                        //color: Colors.black,
                                        borderRadius: new BorderRadius.only(
                                          topLeft: Radius.circular(0),
                                          topRight: Radius.circular(0),
                                        ),
                                        child: InkWell(
                                          // this is not the ture idea
                                          onTap: () {
                                            //   Navigator.of(context).push(
                                            //       new MaterialPageRoute(
                                            //           builder: (BuildContext context) {
                                            //     {
                                            //       int min = 1;
                                            //       int max = 21;
                                            //       Random rnd = new Random();
                                            //       rand = min + rnd.nextInt(max - min);
                                            //     }
                                            //     return widget.birr==null? Caller():Birr();
                                            //   }));
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 0, left: 0),
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(),
                                              child: FittedBox(
                                                child: Text(
                                                    allData[index]['amount']
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18),
                                                    textAlign:
                                                        TextAlign.center),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 2,
                            child: Column(children: <Widget>[
                              SizedBox(height: 50),
                              GestureDetector(
                                onTap: () {
                                  // createAlert(context);
                                  // for (int i = 0; i < history.length; i++) {
                                  //   dbHelper.delete1(i++).then((value) {
                                  //     setState(() {
                                  //       isUpdated = true;
                                  //       Navigator.of(context).pop(false);
                                  //       createAlert(context);

                                  //       getData();
                                  //     });
                                  //   });
                                  // }
                                },
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    "History",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                )),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 5),
                                child: Container(
                                  height: 1,
                                  width: double.infinity,
                                  color: Colors.black,
                                ),
                              ),
                              history != null
                                  ? Container(
                                      child: Expanded(
                                        child: ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            addAutomaticKeepAlives: false,
                                            itemCount: history.length - 1,
                                            itemBuilder: (BuildContext context,
                                                int indexOfList) {
                                              return Container(
                                                height: 35.99,
                                                child: GridView.builder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    addAutomaticKeepAlives:
                                                        false,
                                                    itemCount: crossAxis,
                                                    gridDelegate:
                                                        new SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: crossAxis,
                                                    ),
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return Container(
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              10,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black,
                                                                width: 0.5),
                                                          ),
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.0),
                                                            child: Material(
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              shadowColor:
                                                                  Colors.white,
                                                              //color: Colors.black,
                                                              borderRadius:
                                                                  new BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        0),
                                                              ),
                                                              child: InkWell(
                                                                // this is not the ture idea
                                                                onTap: () {
                                                                  //   Navigator.of(context).push(
                                                                  //       new MaterialPageRoute(
                                                                  //           builder: (BuildContext context) {
                                                                  //     {
                                                                  //       int min = 1;
                                                                  //       int max = 21;
                                                                  //       Random rnd = new Random();
                                                                  //       rand = min + rnd.nextInt(max - min);
                                                                  //     }
                                                                  //     return widget.birr==null? Caller():Birr();
                                                                  //   }));
                                                                },
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          bottom:
                                                                              0,
                                                                          left:
                                                                              0),
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(5),
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child:
                                                                        FittedBox(
                                                                      child: Text(
                                                                          history[indexOfList + 1]['name'].toString().split(",")[
                                                                              index],
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 18),
                                                                          textAlign: TextAlign.center),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              );
                                            }),
                                      ),
                                    )
                                  : Container()
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container()
        ],
      ),
      over - maxLimit <= 0 || history[0]["birr"] > over - maxLimit + 10
          ? Container(
              height: MediaQuery.of(context).size.height / 2,
              color: Colors.black45,
              child: Center(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
                child: Container(
                  child: FittedBox(
                    child: Text(
                      "You have played $over games",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                      //maxLines: 1,
                      softWrap: false,
                      style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                ),
              )),
            )
          : Container()
    ]);
  }
}
