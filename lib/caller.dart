import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as https;
import 'DB.dart';
import 'HomePageBackground.dart';

class Caller extends StatefulWidget {
  Caller({Key key}) : super(key: key);

  @override
  _BingoState createState() => _BingoState();
}

class _BingoState extends State<Caller> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  var myColor = Color(0xFF1c1863);
  int colorIndex = -1;
  bool isScrached = false;
  int started1 = 0;
  int started2 = 0;
  int started3 = 0;
  int bingoIndex = 0;
  double width = 0;
  int bingo = -1;
  int backIndex = 1;
  bool isGold = false;
  Widget con() {}
  List toucheIndexs = new List();
  List toucheIndexs2 = new List();
  List toucheIndexs3 = new List();
  bool hasData = false;
  bool hasWinner = false;
  var jsonData;
  List<int> scratched = new List();
  bool back = false;

  DatabaseHelper dbHelper;
  int playedValue = 0;
  int over = 1;

  @override
  void initState() {
    super.initState();
    random();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });
    controller.forward();
    dbHelper = DatabaseHelper.instance;
    getAmount();
  }

  getAmount() {
    dbHelper.queryAllRows1().then((value) {
      setState(() {
        row = value;
        print(value.toString());
        playedValue = row[0]['amount'];
        over = row[0]['over'];
        print(row[0]['over'].toString());
      });
    });
  }

  maxLimit() {
    getAmount();
    if (over - playedValue > 0) {
      return "የጥሪ ካርድ\n CALLER'S CARD";
    }
    return "You have played $over games\n\n contact ${row[0]['agent']}"
    ;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _update(amount) async {
    Map<String, dynamic> passwordMap = {
      "id": 1,
      "name": row[0]['name'],
      "amount": amount,
      "over": row[0]['over'],
      "bale": row[0]['bale'],
      "phone_number": row[0]['phone_number'],
      "birr": row[0]['birr'],
      "house": row[0]['house'],
      "agent": row[0]['agent']
    };
    final rowsAffected = await dbHelper.update1(passwordMap).then(
        (value) => print("updateeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"));
    //intent();

    //_delet("p181");
  }

  searchScratched(int indext) {
    if (scratched != null) {
      for (int i = 0; i < scratched.length; i++) {
        if (indext == scratched[i]) {
          return Colors.grey;
        }
      }
    }
    return myColor;
  }

  Future getDataFromApi() async {
    var response = await https.get(
        "http://national-lottery.herokuapp.com/api/bingo",
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      hasData = true;
      hasWinner = jsonDecode(response.body)["hasWinner"];
      print(hasWinner.toString());
      //print(jsonDecode(response.body).toString());
      jsonData = jsonDecode(response.body);
      return jsonDecode(response.body);
    }
  }

  List<int> callerRandom = new List();
  List<int> bingoNumbers2 = new List();
  int min;
  int max;
  int r;
  Random rnd;
  List<String> bingoCaller = new List();
  int setIndext() {
    min = 0;
    max = 75;
    rnd = new Random();
    r = min + rnd.nextInt(max - min);
    if (scratched != null) {
      if (scratched.length != 0) {
        for (int j = 0; j < scratched.length; j++) {
          if (r == scratched[j]) {
            setIndext();
          }
        }
      }
    }

    return r;
  }

  random() {
    for (int i = 1; i <= 15; i++) {
      bingoCaller.add("B-$i");
    }
    for (int i = 16; i <= 30; i++) {
      bingoCaller.add("I-$i");
    }
    for (int i = 31; i <= 45; i++) {
      bingoCaller.add("N-$i");
    }
    for (int i = 46; i <= 60; i++) {
      bingoCaller.add("G-$i");
    }
    for (int i = 61; i <= 75; i++) {
      bingoCaller.add("O-$i");
    }
  }

  Widget emoji() {
    return hasWinner && bingoIndex >= 25
        ? AnimatedContainer(
            duration: Duration(seconds: 2),
            // Provide an optional curve to make the animation feel smoother.
            curve: Curves.easeInOutQuad,
            child: Image.asset("assets/celebrating.gif"),
          )
        : AnimatedContainer(
            duration: Duration(seconds: 2),
            // Provide an optional curve to make the animation feel smoother.
            curve: Curves.easeInOutQuad,
            child: Image.asset("assets/oops.gif"),
          );
  }

  Future takeData() async {
    if (hasData == false) {
      return getDataFromApi();
    }
    hasData = true;
    return jsonData;
  }

  Widget winerAnimation() {
    return hasWinner && bingoIndex >= 25 && started1 > 1
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Container(
                  width: MediaQuery.of(context).size.width / 4,
                  height: 100,
                  //color: Colors.white,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: 100,
                          height: 100,
                          child: Stack(children: <Widget>[
                            Positioned(
                              left: 0,
                              top: 0,
                              child: SpinKitPulse(
                                color: Color(0xfff4b938),
                                size: 20,
                                duration: Duration(seconds: 2),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 5,
                              child: SpinKitPulse(
                                color: Color(0xfff4b938),
                                size: 28,
                                duration: Duration(seconds: 3),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 5,
                              child: Container(
                                child: SpinKitPulse(
                                  color: Color(0xfff4b938),
                                  size: 20,
                                  duration: Duration(seconds: 2),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 5,
                              child: Container(
                                child: SpinKitPulse(
                                  color: Color(0xfff4b938),
                                  size: 30,
                                  duration: Duration(seconds: 3),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 0,
                        child: Container(
                          width: 100,
                          height: 100,
                          child: Stack(children: <Widget>[
                            Positioned(
                              left: 0,
                              top: 0,
                              child: SpinKitPulse(
                                color: Color(0xfff4b938),
                                size: 20,
                                duration: Duration(seconds: 2),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 5,
                              child: SpinKitPulse(
                                color: Color(0xfff4b938),
                                size: 18,
                                duration: Duration(seconds: 3),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 5,
                              child: Container(
                                child: SpinKitPulse(
                                  color: Color(0xfff4b938),
                                  size: 20,
                                  duration: Duration(seconds: 2),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 5,
                              child: Container(
                                child: SpinKitPulse(
                                  color: Color(0xfff4b938),
                                  size: 30,
                                  duration: Duration(seconds: 3),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 20,
                        child: Container(
                          width: 200,
                          height: 200,
                          child: Stack(children: <Widget>[
                            Positioned(
                              left: 0,
                              top: 0,
                              child: SpinKitPulse(
                                color: Color(0xfff4b938),
                                size: 20,
                                duration: Duration(seconds: 2),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 5,
                              child: SpinKitPulse(
                                color: Color(0xfff4b938),
                                size: 18,
                                duration: Duration(seconds: 3),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 5,
                              child: Container(
                                child: SpinKitPulse(
                                  color: Color(0xfff4b938),
                                  size: 20,
                                  duration: Duration(seconds: 2),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 5,
                              child: Container(
                                child: SpinKitPulse(
                                  color: Color(0xfff4b938),
                                  size: 30,
                                  duration: Duration(seconds: 3),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 20,
                        child: Container(
                          width: 200,
                          height: 200,
                          child: Stack(children: <Widget>[
                            Positioned(
                              left: 0,
                              top: 0,
                              child: SpinKitPulse(
                                color: Color(0xfff4b938),
                                size: 40,
                                duration: Duration(seconds: 2),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 5,
                              child: SpinKitPulse(
                                color: Color(0xfff4b938),
                                size: 48,
                                duration: Duration(seconds: 3),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 5,
                              child: Container(
                                child: SpinKitPulse(
                                  color: Color(0xfff4b938),
                                  size: 50,
                                  duration: Duration(seconds: 2),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                child: Container(
                  width: MediaQuery.of(context).size.width / 4,
                  height: 100,
                  //color: Colors.white,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: 200,
                          height: 200,
                          child: Stack(children: <Widget>[
                            Positioned(
                              left: 0,
                              top: 0,
                              child: SpinKitPulse(
                                color: Color(0xfff4b938),
                                size: 20,
                                duration: Duration(seconds: 3),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 5,
                              child: SpinKitPulse(
                                color: Color(0xfff4b938),
                                size: 28,
                                duration: Duration(seconds: 3),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 5,
                              child: Container(
                                child: SpinKitPulse(
                                  color: Color(0xfff4b938),
                                  size: 20,
                                  duration: Duration(seconds: 3),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 5,
                              child: Container(
                                child: SpinKitPulse(
                                  color: Color(0xfff4b938),
                                  size: 30,
                                  duration: Duration(seconds: 3),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 0,
                        child: Container(
                          width: 200,
                          height: 200,
                          child: Stack(children: <Widget>[
                            Positioned(
                              left: 0,
                              top: 0,
                              child: SpinKitPulse(
                                color: Color(0xfff4b938),
                                size: 20,
                                duration: Duration(seconds: 3),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 5,
                              child: SpinKitPulse(
                                color: Color(0xfff4b938),
                                size: 18,
                                duration: Duration(seconds: 3),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 5,
                              child: Container(
                                child: SpinKitPulse(
                                  color: Color(0xfff4b938),
                                  size: 20,
                                  duration: Duration(seconds: 3),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 5,
                              child: Container(
                                child: SpinKitPulse(
                                  color: Color(0xfff4b938),
                                  size: 30,
                                  duration: Duration(seconds: 3),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 20,
                        child: Container(
                          width: 200,
                          height: 200,
                          child: Stack(children: <Widget>[
                            Positioned(
                              left: 0,
                              top: 0,
                              child: SpinKitPulse(
                                color: Color(0xfff4b938),
                                size: 20,
                                duration: Duration(seconds: 2),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 5,
                              child: SpinKitPulse(
                                color: Color(0xfff4b938),
                                size: 18,
                                duration: Duration(seconds: 3),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 5,
                              child: Container(
                                child: SpinKitPulse(
                                  color: Color(0xfff4b938),
                                  size: 20,
                                  duration: Duration(seconds: 2),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 5,
                              child: Container(
                                child: SpinKitPulse(
                                  color: Color(0xfff4b938),
                                  size: 30,
                                  duration: Duration(seconds: 3),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 20,
                        child: Container(
                          width: 200,
                          height: 200,
                          child: Stack(children: <Widget>[
                            Positioned(
                              left: 0,
                              top: 0,
                              child: SpinKitPulse(
                                color: Color(0xfff4b938),
                                size: 40,
                                duration: Duration(seconds: 2),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 5,
                              child: SpinKitPulse(
                                color: Color(0xfff4b938),
                                size: 48,
                                duration: Duration(seconds: 3),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 5,
                              child: Container(
                                child: SpinKitPulse(
                                  color: Color(0xfff4b938),
                                  size: 50,
                                  duration: Duration(seconds: 2),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 4,
                height: 100,
//color: Colors.white,
                alignment: Alignment.center,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        width: 200,
                        height: 200,
                        child: Stack(children: <Widget>[
                          Positioned(
                            left: 0,
                            top: 0,
                            child: SpinKitPulse(
                              color: Color(0xfff4b938),
                              size: 20,
                              duration: Duration(seconds: 2),
                            ),
                          ),
                          Positioned(
                            left: 5,
                            top: 5,
                            child: SpinKitPulse(
                              color: Color(0xfff4b938),
                              size: 28,
                              duration: Duration(seconds: 3),
                            ),
                          ),
                          Positioned(
                            left: 5,
                            top: 5,
                            child: Container(
                              child: SpinKitPulse(
                                color: Color(0xfff4b938),
                                size: 20,
                                duration: Duration(seconds: 2),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 5,
                            top: 5,
                            child: Container(
                              child: SpinKitPulse(
                                color: Color(0xfff4b938),
                                size: 30,
                                duration: Duration(seconds: 3),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 0,
                      child: Container(
                        width: 200,
                        height: 200,
                        child: Stack(children: <Widget>[
                          Positioned(
                            left: 0,
                            top: 0,
                            child: SpinKitPulse(
                              color: Color(0xfff4b938),
                              size: 20,
                              duration: Duration(seconds: 2),
                            ),
                          ),
                          Positioned(
                            left: 5,
                            top: 5,
                            child: SpinKitPulse(
                              color: Color(0xfff4b938),
                              size: 18,
                              duration: Duration(seconds: 3),
                            ),
                          ),
                          Positioned(
                            left: 5,
                            top: 5,
                            child: Container(
                              child: SpinKitPulse(
                                color: Color(0xfff4b938),
                                size: 20,
                                duration: Duration(seconds: 3),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 5,
                            top: 5,
                            child: Container(
                              child: SpinKitPulse(
                                color: Color(0xfff4b938),
                                size: 30,
                                duration: Duration(seconds: 4),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 20,
                      child: Container(
                        width: 200,
                        height: 200,
                        child: Stack(children: <Widget>[
                          Positioned(
                            left: 0,
                            top: 0,
                            child: SpinKitPulse(
                              color: Color(0xfff4b938),
                              size: 20,
                              duration: Duration(seconds: 4),
                            ),
                          ),
                          Positioned(
                            left: 5,
                            top: 5,
                            child: SpinKitPulse(
                              color: Color(0xfff4b938),
                              size: 18,
                              duration: Duration(seconds: 4),
                            ),
                          ),
                          Positioned(
                            left: 5,
                            top: 5,
                            child: Container(
                              child: SpinKitPulse(
                                color: Color(0xfff4b938),
                                size: 20,
                                duration: Duration(seconds: 4),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 5,
                            top: 5,
                            child: Container(
                              child: SpinKitPulse(
                                color: Color(0xfff4b938),
                                size: 30,
                                duration: Duration(seconds: 4),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 20,
                      child: Container(
                        width: 200,
                        height: 200,
                        child: Stack(children: <Widget>[
                          Positioned(
                            left: 0,
                            top: 0,
                            child: SpinKitPulse(
                              color: Color(0xfff4b938),
                              size: 40,
                              duration: Duration(seconds: 4),
                            ),
                          ),
                          Positioned(
                            left: 5,
                            top: 5,
                            child: SpinKitPulse(
                              color: Color(0xfff4b938),
                              size: 48,
                              duration: Duration(seconds: 4),
                            ),
                          ),
                          Positioned(
                            left: 5,
                            top: 5,
                            child: Container(
                              child: SpinKitPulse(
                                color: Color(0xfff4b938),
                                size: 50,
                                duration: Duration(seconds: 4),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        : Container();
  }

  bool touched({int index, int touchIndex, int box}) {
    toucheIndexs.add(touchIndex);
    for (int i = 0; i < toucheIndexs.length; i++) {
      if (index == toucheIndexs[i]) {
        return true;
      }
    }

    return false;
  }

  bool touchedBox1({int index, int touchIndex, int box}) {
    //started2++;
    toucheIndexs2.add(touchIndex);
    for (int i = 0; i < toucheIndexs2.length; i++) {
      if (index == toucheIndexs2[i]) {
        return true;
      }
    }
    return false;
  }

// this si
  bool touchedBox2({int index, int touchIndex, int box}) {
    //started3++;
    toucheIndexs3.add(touchIndex);
    for (int i = 0; i < toucheIndexs3.length; i++) {
      if (index == toucheIndexs3[i]) {
        return true;
      }
    }
    return false;
  }

  BoxDecoration setGold(index, int box) {
    if (box == 2) {
      //started2++;
      for (int i = 0; i < bingo2.length; i++) {
        if (100 == bingo2[i]) {
          isGold = true;
          return BoxDecoration(
              color: setColor(index, 2)
                  ? Color(0xfff4b938)
                  : Colors.black.withOpacity(0.8));
        }
      }
    } else if (box == 1) {
      //started1++;
      for (int i = 0; i < bingos.length; i++) {
        if (100 == bingo2[i]) {
          isGold = true;
          return BoxDecoration(
              color: setColor(index, 1)
                  ? Color(0xfff4b938)
                  : Colors.black.withOpacity(0.8));
        }
      }
      {
        return BoxDecoration(
          color: touchedBox1(index: index)
              ? Colors.white.withOpacity(0.7)
              : Colors.black.withOpacity(0.8),
        );
      }
    } else if (box == 3) {
      for (int i = 0; i < bingo3.length; i++) {
        if (100 == bingo2[i]) {
          isGold = true;
          return BoxDecoration(
              color: setColor(index, 3)
                  ? Color(0xfff4b938)
                  : Colors.black.withOpacity(0.8));
        }
      }
      {
        return BoxDecoration(
          color: touchedBox2(index: index)
              ? Colors.white.withOpacity(0.7)
              : Colors.black.withOpacity(0.8),
        );
      }
    }
    {
      return BoxDecoration(
        color: touched(index: index)
            ? Colors.white.withOpacity(0.7)
            : Colors.black.withOpacity(0.8),
      );
    }
  }

  bool setColor(int index, int cardNumber) {
    if (cardNumber == 1) {
      for (int i = 0; i < bingos.length; i++) {
        if (index == bingos[i]) {
          return true;
        }
      }
    }
    if (cardNumber == 2) {
      for (int i = 0; i < bingo2.length; i++) {
        if (index == bingo2[i]) {
          return true;
        }
      }
    }
    if (cardNumber == 3) {
      for (int i = 0; i < bingo3.length; i++) {
        if (index == bingo3[i]) {
          return true;
        }
      }
    }
    return false;
  }

  List bingos = new List();
  List bingo2 = new List();
  List bingo3 = new List();
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();

  // }

  var cardData;
  List indexOFCallerBingo = new List();
  List indexOFPlayingBox1 = new List();
  List row = new List();

  void onClick(int index, int bingoNumber) {
    setState(() {
      // for (int k = 0; k < indexOFCallerBingo.length; k++) {
      //   if (bingoIndex == indexOFCallerBingo[k]) {
      //     print(bingoIndex);
      //     for (int t = 0; t < 25; t++) {
      //       if (carddata["caller_number"][bingoIndex]
      //           .toString()
      //           .contains(carddata['playing_box_1'][t].toString())) {
      //         bingos.add(t);
      //       }
      //       if (carddata["caller_number"][bingoIndex]
      //           .toString()
      //           .contains(carddata['playing_box_2'][t].toString())) {
      //         bingo2.add(t);
      //       }
      //       if (carddata["caller_number"][bingoIndex]
      //           .toString()
      //           .contains(carddata['playing_box_3'][t].toString())) {
      //         bingo3.add(t);
      //       }
      //     }
      //     // bingos.add(indexOFPlayingBox1[k]);
      //     print(
      //         "4444444444444444444444444444444444444444444444444444444444444444444444");
      //     bingo = indexOFPlayingBox1[k];
      //     print(bingo.toString());
      //   }
      // }
      bingoIndex++;
      isScrached = true;
      //myColor = Colors.black;
      colorIndex = setIndext();
      scratched.add(colorIndex);
      if (scratched.length == 5) {
        dbHelper.queryAllRows1().then((value) {
          setState(() {
            row = value;
            print("${row[0]['amount']}");
            //    playedValue = value.toInt();
            //  print("from $value" );
            _update(row[0]['amount'] + 1);
          });
        });
      }
      if (scratched.length > 5) {
        dbHelper.queryAllRows().then((value) {
          setState(() {
            print(value.toString());
          });
        });
      }

      print(bingoIndex.toString());
      print(
          "111111111111111111111111111111111111111111111111111111111111111111");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          //color: Color(0xFF1c1863),
          // height: MediaQuery.of(context).size.height,
          // margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          // width: MediaQuery.of(context).size.width,
          child: Stack(children: <Widget>[
            new HomePageBacground(
                screenHeight: MediaQuery.of(context).size.height / 2.5),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
              child: Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  child: Card(
                    elevation: 0,
                    color: Color(0xFF1c1863),
                    child: Stack(children: <Widget>[
                      Center(
                        child: Column(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    //padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: EdgeInsets.all(2),
                                      color: Colors.yellow,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.9,
                                      width: MediaQuery.of(context).size.width *
                                          0.82,
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.95,
                                          width: MediaQuery.of(context).size.width *
                                          0.84,
                                          color: Color(0xFF1c1863),
                                          child: Stack(
                                            children: <Widget>[
                                              GridView.builder(
                                                // physics:
                                                //     new NeverScrollableScrollPhysics(),
                                                itemCount: bingoCaller.length,
                                                gridDelegate:
                                                    new SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 5,
                                                  childAspectRatio: (3 / 2),
                                                ),
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return FadeTransition(
                                                    opacity: animation,
                                                    child: Card(
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      child: AnimatedContainer(
                                                        duration: Duration(
                                                            milliseconds: 90),
                                                        // Provide an optional curve to make the animation feel smoother.
                                                        curve:
                                                            Curves.easeInCirc,
                                                        //Curves.fastOutSlowIn,
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 5),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: !back
                                                              ? index ==
                                                                      scratched[
                                                                          scratched.length -
                                                                              1]
                                                                  ? Colors.red
                                                                  : searchScratched(
                                                                      index)
                                                              : index ==
                                                                      scratched[
                                                                          scratched.length -
                                                                              backIndex]
                                                                  ? Colors.green
                                                                  : searchScratched(
                                                                      index),
                                                        ),
                                                        child: Text(
                                                            bingoCaller[index]
                                                                .toString(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              color: index !=
                                                                      colorIndex
                                                                  ? myColor
                                                                  : Colors
                                                                      .black,
                                                            )),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              AnimatedContainer(
                                                width: isScrached == true
                                                    ? 0
                                                    : MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.9,
                                                duration: Duration(seconds: 2),
                                                //Provide an optional curve to make the animation feel smoother.
                                                //curve: Curves.easeOut,

                                                color: isScrached == false
                                                    ? Color(0xFF1c1863)
                                                        .withOpacity(1)
                                                    : Color(0xFF1c1863)
                                                        .withOpacity(1),
                                                child: Center(
                                                  child: Container(
                                                    child: Text(
                                                      maxLimit(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      //maxLines: 1,
                                                      softWrap: false,
                                                      style: TextStyle(
                                                          color: Colors.yellow,
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontStyle:
                                                              FontStyle.normal),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                            // padding: const EdgeInsets.all(.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        height: 45,
                        width: 85,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFF54864),
                        ),
                        child: Container(
                          child: IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (scratched.length - backIndex > 0) {
                                    backIndex = backIndex + 1;
                                    back = true;
                                  }
                                });
                              }),
                        )),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 15, 1, 5),
                      child: SizedBox(
                        height: 50,
                        width: 90,
                        child: Container(
                          height: 40,
                          width: 80,
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: FloatingActionButton(
                            elevation: 40,
                            splashColor: Colors.black,
                            onPressed: () {
                              back = false;
                              backIndex = 1;
                              over - playedValue != 0 ? onClick(0, 0) : null;
                            },
                            backgroundColor: Color(0xFFF54864),
                            child: const Text(
                              'ፋቅ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
