import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as https;
import 'HomePageBackground.dart';

class Bingo extends StatefulWidget {
  Bingo({Key key}) : super(key: key);

  @override
  _BingoState createState() => _BingoState();
}

class _BingoState extends State<Bingo> with SingleTickerProviderStateMixin {
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
  bool isGold = false;
  Widget con() {}
  List toucheIndexs = new List();
  List toucheIndexs2 = new List();
  List toucheIndexs3 = new List();
  bool hasData = false;
  bool hasWinner = false;
  var jsonData;

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });
    controller.forward();
  }

  var cardData;
  List indexOFCallerBingo = new List();
  List indexOFPlayingBox1 = new List();

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
      colorIndex++;
      print("22222222222222222222222222222222222222222222222222222222222222");
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
           
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 90, 10, 0),
                child: Card(
                  child: Padding(
                 padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    child: Card(
                      elevation: 0,
                      color: Color(0xFF1c1863),
                      child: FutureBuilder(
                          future: takeData(),
                          builder: (context, snapshot) {
                            //
                            // print(snapshot.data.toString());
                            var data = snapshot.data;

                            {
                              hasData = true;
                            }

                            if (!snapshot.hasData ||
                                snapshot.data == null) {
                              return Container(
                                height: MediaQuery.of(context).size.height,
                                color: Color(0xFF1c1863),
                                child: Center(
                                    child: SpinKitCircle(
                                        color: Colors.white, size: 40)),
                              );
                            }
                            // print(snapshot.data.toString());
                            cardData = data;
                            data.toString();
                            for (int j = 0; j < 25; j++) {
                              for (int i = 0; i < 25; i++) {
                                if (data["caller_number"][j]
                                        .toString()
                                        .contains(data["playing_box_1"]
                                                [i]
                                            .toString()) ||
                                    data["caller_number"][j]
                                        .toString()
                                        .contains(data["playing_box_2"][i]
                                            .toString()) ||
                                    data["caller_number"][j]
                                        .toString()
                                        .contains(data["playing_box_3"][i]
                                            .toString())) {
                                  int toogle = 1;
                                  for (int t = 0;
                                      t < indexOFCallerBingo.length;
                                      t++) {
                                    if (j == indexOFCallerBingo[t]) {
                                      toogle = 0;
                                    }
                                  }
                                  if (toogle == 1) {
                                    indexOFCallerBingo.add(j);
                                    //toogle = 0;

                                  }
                                }
                              }
                            }
                            for (int j = 0; j < 25; j++) {
                              for (int i = 0; i < 25; i++) {
                                if (data["caller_number"][j]
                                    .toString()
                                    .contains(data["playing_box_1"][i]
                                        .toString())) {
                                  // indexOFCallerBingo.add(j);
                                  indexOFPlayingBox1.add(i);
                                  print(
                                      data["playing_box_1"][i].toString());
                                }
                              }
                            }
                            // print(data.toString());
                            return Stack(
                              children: <Widget>[
                                Container(
                                  //width: MediaQuery.of(context).size.width / 2,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        color: Color(0xFF1c1863),
                                        child: Row(
                                          // th
                                          children: <Widget>[
                                            Expanded(
                                              flex: 2,
                                              child: FadeTransition(
                                                opacity: animation,
                                                child: Container(
                                                  width:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2,
                                                  child: bingoIndex >= 25 &&
                                                          started1 > 1
                                                      ? emoji()
                                                      : AnimatedContainer(
                                                          duration:
                                                              Duration(
                                                                  seconds:
                                                                      1),
                                                          // Provide an optional curve to make the animation feel smoother.
                                                          curve: Curves
                                                              .easeInOutQuad,
                                                          child: Image.asset(
                                                              "assets/newb.png"),
                                                        ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: FittedBox(
                                                child: Column(
                                                  children: <Widget>[
                                                    Container(
                                                      child: hasWinner
                                                          ? Text(
                                                              "ቢንጎ   ሎተሪ",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      26,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .white),
                                                            )
                                                          : Text(
                                                              "ቢንጎ ሎተሪ",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      26,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets
                                                              .all(8.0),
                                                      child: FittedBox(
                                                        //padding: const EdgeInsets.all(8.0),
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets
                                                                  .all(4),
                                                          color:
                                                              Colors.yellow,
                                                          child: Container(
                                                            height: 232,
                                                            width: 290,
                                                            color: Color(
                                                                0xFF1c1863),
                                                            child: Stack(
                                                              children: <
                                                                  Widget>[
                                                                GridView
                                                                    .builder(
                                                                  physics:
                                                                      new NeverScrollableScrollPhysics(),
                                                                  itemCount:
                                                                      25,
                                                                  gridDelegate:
                                                                      new SliverGridDelegateWithFixedCrossAxisCount(
                                                                    crossAxisCount:
                                                                        5,
                                                                    childAspectRatio:
                                                                        (25 /
                                                                            20),
                                                                  ),
                                                                  itemBuilder:
                                                                      (BuildContext context,
                                                                          int index) {
                                                                    return FadeTransition(
                                                                      opacity:
                                                                          animation,
                                                                      child:
                                                                          Card(
                                                                        clipBehavior:
                                                                            Clip.antiAlias,
                                                                        child:
                                                                            AnimatedContainer(
                                                                          duration: Duration(seconds: 2),
                                                                          // Provide an optional curve to make the animation feel smoother.
                                                                          curve: Curves.easeInCirc,
                                                                          //Curves.fastOutSlowIn,
                                                                          padding: EdgeInsets.only(top: 10),
                                                                          decoration: BoxDecoration(
                                                                            color: index > colorIndex ? myColor : Colors.grey,
                                                                          ),
                                                                          child: Text(data["caller_number"][index].toString(),
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                fontSize: 16,
                                                                                color: index > colorIndex ? myColor : Colors.black,
                                                                              )),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                                FadeTransition(
                                                                  opacity:
                                                                      animation,
                                                                  child:
                                                                      AnimatedContainer(
                                                                    width: isScrached ==
                                                                            true
                                                                        ? 0
                                                                        : 290,

                                                                    duration:
                                                                        Duration(seconds: 2),
                                                                    //Provide an optional curve to make the animation feel smoother.
                                                                    //curve: Curves.easeOut,

                                                                    color: isScrached ==
                                                                            false
                                                                        ? Color(0xFF1c1863).withOpacity(0.9)
                                                                        : Color(0xFF1c1863).withOpacity(0.5),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Container(
                                                                        child:
                                                                            Text(
                                                                          "የጥሪ ካርድ\n CALLER'S CARD",
                                                                          textAlign: TextAlign.center,
                                                                          overflow: TextOverflow.clip,
                                                                          //maxLines: 1,
                                                                          softWrap: false,
                                                                          style: TextStyle(color: Colors.yellow, fontSize: 30, fontWeight: FontWeight.w700, fontStyle: FontStyle.normal),
                                                                        ),
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
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      FittedBox(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              child: Text(
                                                "የመጫወቻ ቁጥሮች Play Numbers  ",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 15, 15, 15),
                                              child: SizedBox(
                                                height: 60,
                                                width: 100,
                                                child: Container(
                                                  height: 50,
                                                  width: 100,
                                                  padding:
                                                      EdgeInsets.all(2),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white,
                                                  ),
                                                  child:
                                                      FloatingActionButton(
                                                    elevation: 40,
                                                    splashColor:
                                                        Colors.black,
                                                    onPressed: () {
                                                      onClick(0, 0);
                                                    },
                                                    backgroundColor:
                                                        Color(0xFFF54864),
                                                    child: const Text(
                                                      'ፋቅ',
                                                      textAlign:
                                                          TextAlign.center,
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
                                       Container(
                                            width:
                                                MediaQuery.of(context).size.width,
                                            child: FittedBox(
                                              child: Wrap(
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    margin:
                                                        EdgeInsets.only(right: 5),
                                                    width: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.3,
                                                    height: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.35,
                                                    color: Colors.white,
                                                    child: Column(
                                                      children: <Widget>[
                                                        Container(
                                                            //padding: EdgeInsets.symmetric(horizontal: 20),
                                                            //  height: 22,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.36,
                                                            color: Colors.black,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: <Widget>[
                                                                Text(
                                                                  'B',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          37,
                                                                      color: Colors
                                                                          .white,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .normal,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                                Text(
                                                                  'I ',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          37,
                                                                      color: Colors
                                                                          .white,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .normal,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                                Text(
                                                                  'N ',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          37,
                                                                      color: Colors
                                                                          .white,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .normal,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                                Text(
                                                                  'G ',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          37,
                                                                      color: Colors
                                                                          .white,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .normal,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                                Text(
                                                                  'O',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          37,
                                                                      color: Colors
                                                                          .white,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .normal,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ],
                                                            )),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0.0),
                                                            child: FittedBox(
                                                              //padding: const EdgeInsets.all(8.0),
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .all(4),
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.7),
                                                                child: Container(
                                                                  margin:
                                                                      EdgeInsets
                                                                          .all(0),
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.36,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.36,
                                                                  // //color: Color(0xFF1c1863),
                                                                  child: Stack(
                                                                    children: <
                                                                        Widget>[
                                                                      GridView
                                                                          .builder(
                                                                        physics:
                                                                            new NeverScrollableScrollPhysics(),
                                                                        itemCount:
                                                                            25,
                                                                        gridDelegate:
                                                                            new SliverGridDelegateWithFixedCrossAxisCount(
                                                                          crossAxisCount:
                                                                              5,
                                                                          //childAspectRatio: (18 / 20),
                                                                        ),
                                                                        itemBuilder:
                                                                            (BuildContext context,
                                                                                int index) {
                                                                          return index !=
                                                                                  12
                                                                              ? GestureDetector(
                                                                                  onTap: () {
                                                                                    started1++;
                                                                                    setState(() {
                                                                                      touchedBox1(touchIndex: index, box: 1);
                                                                                    });

                                                                                  //  print("7777777777777777777777777777777777777777777777777777777777777777");
                                                                                  },
                                                                                  child: Card(
                                                                                    clipBehavior: Clip.antiAlias,
                                                                                    child: FadeTransition(
                                                                                      opacity: animation,
                                                                                      child: AnimatedContainer(
                                                                                        alignment: Alignment.center,
                                                                                        duration: Duration(seconds: 2),
                                                                                        // Provide an optional curve to make the animation feel smoother.
                                                                                        curve: Curves.easeInOutQuad,
                                                                                        //Curves.fastOutSlowIn,
                                                                                        padding: EdgeInsets.only(top: 0),
                                                                                        decoration: setGold(index, 1),
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.all(2.5),
                                                                                          child: FittedBox(
                                                                                            child: AutoSizeText(
                                                                                              data["playing_box_1"][index].toString(),
                                                                                              maxLines: 2,
                                                                                              textAlign: TextAlign.center,
                                                                                              style: TextStyle(
                                                                                                fontSize: 25,
                                                                                                color: Colors.black,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              : Card(
                                                                                  clipBehavior: Clip.antiAlias,
                                                                                  child: FadeTransition(
                                                                                    opacity: animation,
                                                                                    child: AnimatedContainer(
                                                                                      alignment: Alignment.center,
                                                                                      duration: Duration(seconds: 2),
                                                                                      // Provide an optional curve to make the animation feel smoother.
                                                                                      curve: Curves.easeInOutQuad,
                                                                                      //Curves.fastOutSlowIn,
                                                                                      padding: EdgeInsets.only(top: 0),
                                                                                      decoration: BoxDecoration(
                                                                                        color: isGold ? Color(0xfff4b938) : Colors.white.withOpacity(1),
                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.all(2.5),
                                                                                        child: FittedBox(
                                                                                          child: AutoSizeText(
                                                                                            'Free',
                                                                                            maxLines: 2,
                                                                                            textAlign: TextAlign.center,
                                                                                            style: TextStyle(
                                                                                              fontSize: 25,
                                                                                              color: Colors.black,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                        },
                                                                      ),
                                                                      // FadeTransition(
                                                                      //   opacity: animation,
                                                                      //   child: AnimatedContainer(
                                                                      //     width: isScrached == true
                                                                      //         ? 0
                                                                      //         : 290,

                                                                      //     duration: Duration(seconds: 2),
                                                                      //     // Provide an optional curve to make the animation feel smoother.
                                                                      //     // curve: Curves.easeOut,

                                                                      //     color: isScrached == false
                                                                      //         ? Color(0xFF1c1863)
                                                                      //             .withOpacity(0.9)
                                                                      //         : Color(0xFF1c1863)
                                                                      //             .withOpacity(0.5),

                                                                      //   ),
                                                                      // )
                                                                    ],
                                                                    // padding: const EdgeInsets.all(.0),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.only(right: 5),
                                                    width: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.3,
                                                    height: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.35,
                                                    color: Colors.white,
                                                    child: Column(
                                                      children: <Widget>[
                                                        Container(
                                                            //padding: EdgeInsets.symmetric(horizontal: 20),
                                                            //  height: 22,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.36,
                                                            color: Colors.black,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: <Widget>[
                                                                Text(
                                                                  'B',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          37,
                                                                      color: Colors
                                                                          .white,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .normal,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                                Text(
                                                                  'I ',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          37,
                                                                      color: Colors
                                                                          .white,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .normal,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                                Text(
                                                                  'N ',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          37,
                                                                      color: Colors
                                                                          .white,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .normal,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                                Text(
                                                                  'G ',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          37,
                                                                      color: Colors
                                                                          .white,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .normal,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                                Text(
                                                                  'O',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          37,
                                                                      color: Colors
                                                                          .white,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .normal,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ],
                                                            )),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0.0),
                                                            child: FittedBox(
                                                              //padding: const EdgeInsets.all(8.0),
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .all(4),
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.7),
                                                                child: Container(
                                                                  margin:
                                                                      EdgeInsets
                                                                          .all(0),
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.36,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.36,
                                                                  // //color: Color(0xFF1c1863),
                                                                  child: Stack(
                                                                    children: <
                                                                        Widget>[
                                                                      GridView
                                                                          .builder(
                                                                        physics:
                                                                            new NeverScrollableScrollPhysics(),
                                                                        itemCount:
                                                                            25,
                                                                        gridDelegate:
                                                                            new SliverGridDelegateWithFixedCrossAxisCount(
                                                                          crossAxisCount:
                                                                              5,
                                                                          //childAspectRatio: (20 / 20),
                                                                        ),
                                                                        itemBuilder:
                                                                            (BuildContext context,
                                                                                int index) {
                                                                          return index !=
                                                                                  12
                                                                              ? GestureDetector(
                                                                                  onTap: () {
                                                                                    started1++;
                                                                                    setState(() {
                                                                                      touched(touchIndex: index, box: 2);
                                                                                    });
                                                                                  },
                                                                                  child: Card(
                                                                                    clipBehavior: Clip.antiAlias,
                                                                                    child: FadeTransition(
                                                                                      opacity: animation,
                                                                                      child: AnimatedContainer(
                                                                                        alignment: Alignment.center,
                                                                                        duration: Duration(seconds: 4),
                                                                                        // Provide an optional curve to make the animation feel smoother.
                                                                                        curve: Curves.easeInOutQuad,
                                                                                        //Curves.fastOutSlowIn,
                                                                                        padding: EdgeInsets.only(top: 0),
                                                                                        decoration: setGold(index, 2),
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.all(2.5),
                                                                                          child: FittedBox(
                                                                                            child: AutoSizeText(
                                                                                              data["playing_box_2"][index].toString(),
                                                                                              maxLines: 2,
                                                                                              textAlign: TextAlign.center,
                                                                                              style: TextStyle(
                                                                                                fontSize: 25,
                                                                                                color: Colors.black,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              : Card(
                                                                                  clipBehavior: Clip.antiAlias,
                                                                                  child: FadeTransition(
                                                                                    opacity: animation,
                                                                                    child: AnimatedContainer(
                                                                                      alignment: Alignment.center,
                                                                                      duration: Duration(seconds: 2),
                                                                                      // Provide an optional curve to make the animation feel smoother.
                                                                                      curve: Curves.easeInOutQuad,
                                                                                      //Curves.fastOutSlowIn,
                                                                                      padding: EdgeInsets.only(top: 0),
                                                                                      decoration: BoxDecoration(
                                                                                        color: isGold ? Color(0xfff4b938) : Colors.white.withOpacity(1),
                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.all(2.5),
                                                                                        child: FittedBox(
                                                                                          child: AutoSizeText(
                                                                                            'Free',
                                                                                            maxLines: 2,
                                                                                            textAlign: TextAlign.center,
                                                                                            style: TextStyle(
                                                                                              fontSize: 25,
                                                                                              color: Colors.black,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                        },
                                                                      ),
                                                                      // FadeTransition(
                                                                      //   opacity: animation,
                                                                      //   child: AnimatedContainer(
                                                                      //     width: isScrached == true
                                                                      //         ? 0
                                                                      //         : 290,

                                                                      //     duration: Duration(seconds: 2),
                                                                      //     // Provide an optional curve to make the animation feel smoother.
                                                                      //     // curve: Curves.easeOut,

                                                                      //     color: isScrached == false
                                                                      //         ? Color(0xFF1c1863)
                                                                      //             .withOpacity(0.9)
                                                                      //         : Color(0xFF1c1863)
                                                                      //             .withOpacity(0.5),

                                                                      //   ),
                                                                      // )
                                                                    ],
                                                                    // padding: const EdgeInsets.all(.0),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                 
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: FittedBox(
                                        child: Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                             Container(width: 4,),
                                            Container(
                                              margin: EdgeInsets.only(right: 5),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.35,
                                              color: Colors.white,
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                      //padding: EdgeInsets.symmetric(horizontal: 20),
                                                      //  height: 22,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.36,
                                                      color: Colors.black,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          Text(
                                                            'B',
                                                            textAlign:
                                                                TextAlign.center,
                                                            style: TextStyle(
                                                                fontSize: MediaQuery.of(context).size.width/37,
                                                                color:
                                                                    Colors.white,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          Text(
                                                            'I ',
                                                            textAlign:
                                                                TextAlign.center,
                                                            style: TextStyle(
                                                                fontSize: MediaQuery.of(context).size.width/37,
                                                                color:
                                                                    Colors.white,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          Text(
                                                            'N ',
                                                            textAlign:
                                                                TextAlign.center,
                                                            style: TextStyle(
                                                                fontSize: MediaQuery.of(context).size.width/37,
                                                                color:
                                                                    Colors.white,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          Text(
                                                            'G ',
                                                            textAlign:
                                                                TextAlign.center,
                                                            style: TextStyle(
                                                                fontSize: MediaQuery.of(context).size.width/37,
                                                                color:
                                                                    Colors.white,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          Text(
                                                            'O',
                                                            textAlign:
                                                                TextAlign.center,
                                                            style: TextStyle(
                                                                fontSize: MediaQuery.of(context).size.width/37,
                                                                color:
                                                                    Colors.white,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ],
                                                      )),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0.0),
                                                      child: FittedBox(
                                                        //padding: const EdgeInsets.all(8.0),
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.all(4),
                                                          color: Colors.black
                                                              .withOpacity(0.7),
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.all(0),
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.36,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.36,
                                                            // //color: Color(0xFF1c1863),
                                                            child: Stack(
                                                              children: <Widget>[
                                                                GridView.builder(
                                                                  physics:
                                                                      new NeverScrollableScrollPhysics(),
                                                                  itemCount: 25,
                                                                  gridDelegate:
                                                                      new SliverGridDelegateWithFixedCrossAxisCount(
                                                                    crossAxisCount:
                                                                        5,
                                                                    //childAspectRatio: (20 / 20),
                                                                  ),
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          int index) {
                                                                    return index !=
                                                                            12
                                                                        ? GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                started1++;
                                                                                touchedBox2(touchIndex: index, box: 3);
                                                                              });

                                                                              print("7777777777777777777777777777777777777777777777777777777777777777");
                                                                            },
                                                                            child:
                                                                                Card(
                                                                              clipBehavior:
                                                                                  Clip.antiAlias,
                                                                              child:
                                                                                  FadeTransition(
                                                                                opacity: animation,
                                                                                child: AnimatedContainer(
                                                                                  alignment: Alignment.center,
                                                                                  duration: Duration(seconds: 3),
                                                                                  // Provide an optional curve to make the animation feel smoother.
                                                                                  curve: Curves.easeInOutQuad,
                                                                                  //Curves.fastOutSlowIn,
                                                                                  padding: EdgeInsets.only(top: 0),
                                                                                  decoration: setGold(index, 3),
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.all(2.5),
                                                                                    child: FittedBox(
                                                                                      child: AutoSizeText(
                                                                                        data["playing_box_3"][index].toString(),
                                                                                        maxLines: 2,
                                                                                        textAlign: TextAlign.center,
                                                                                        style: TextStyle(
                                                                                          fontSize: 25,
                                                                                          color: Colors.black,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : Card(
                                                                            clipBehavior:
                                                                                Clip.antiAlias,
                                                                            child:
                                                                                FadeTransition(
                                                                              opacity:
                                                                                  animation,
                                                                              child:
                                                                                  AnimatedContainer(
                                                                                alignment: Alignment.center,
                                                                                duration: Duration(seconds: 2),
                                                                                // Provide an optional curve to make the animation feel smoother.
                                                                                curve: Curves.easeInOutQuad,
                                                                                //Curves.fastOutSlowIn,
                                                                                padding: EdgeInsets.only(top: 0),
                                                                                decoration: BoxDecoration(
                                                                                  color: isGold ? Color(0xfff4b938) : Colors.white.withOpacity(1),
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(2.5),
                                                                                  child: FittedBox(
                                                                                    child: AutoSizeText(
                                                                                      'Free',
                                                                                      maxLines: 2,
                                                                                      textAlign: TextAlign.center,
                                                                                      style: TextStyle(
                                                                                        fontSize: 25,
                                                                                        color: Colors.black,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          );
                                                                  },
                                                                ),
                                                                // FadeTransition(
                                                                //   opacity: animation,
                                                                //   child: AnimatedContainer(
                                                                //     width: isScrached == true
                                                                //         ? 0
                                                                //         : 290,

                                                                //     duration: Duration(seconds: 2),
                                                                //     // Provide an optional curve to make the animation feel smoother.
                                                                //     // curve: Curves.easeOut,

                                                                //     color: isScrached == false
                                                                //         ? Color(0xFF1c1863)
                                                                //             .withOpacity(0.9)
                                                                //         : Color(0xFF1c1863)
                                                                //             .withOpacity(0.5),

                                                                //   ),
                                                                // )
                                                              ],
                                                              // padding: const EdgeInsets.all(.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(width: 10,),
                                            Container(
                                              margin: EdgeInsets.only(right: 5),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.35,
                                              color: Color(0xFF1c1863),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                          // Container(
                                          //   width: MediaQuery.of(context).size.width,
                                          //   child: FittedBox(
                                          //     child: Wrap(
                                          //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //       children: <Widget>[
                                          //         Container(
                                          //           margin: EdgeInsets.only(right: 5),
                                          //           width: MediaQuery.of(context)
                                          //                   .size
                                          //                   .width *
                                          //               0.3,
                                          //           height: MediaQuery.of(context)
                                          //                   .size
                                          //                   .width *
                                          //               0.35,
                                          //           color: Colors.white,
                                          //           child: Column(
                                          //             children: <Widget>[
                                          //               Container(
                                          //                   //padding: EdgeInsets.symmetric(horizontal: 20),
                                          //                   //  height: 22,
                                          //                   width:
                                          //                       MediaQuery.of(context)
                                          //                               .size
                                          //                               .width *
                                          //                           0.36,
                                          //                   color: Colors.black,
                                          //                   child: Row(
                                          //                     mainAxisAlignment:
                                          //                         MainAxisAlignment
                                          //                             .spaceEvenly,
                                          //                     children: <Widget>[
                                          //                       Text(
                                          //                         'B',
                                          //                         textAlign:
                                          //                             TextAlign.center,
                                          //                         style: TextStyle(
                                          //                             fontSize: MediaQuery.of(context).size.width/37,
                                          //                             color:
                                          //                                 Colors.white,
                                          //                             fontStyle:
                                          //                                 FontStyle
                                          //                                     .normal,
                                          //                             fontWeight:
                                          //                                 FontWeight
                                          //                                     .w500),
                                          //                       ),
                                          //                       Text(
                                          //                         'I ',
                                          //                         textAlign:
                                          //                             TextAlign.center,
                                          //                         style: TextStyle(
                                          //                             fontSize: MediaQuery.of(context).size.width/37,
                                          //                             color:
                                          //                                 Colors.white,
                                          //                             fontStyle:
                                          //                                 FontStyle
                                          //                                     .normal,
                                          //                             fontWeight:
                                          //                                 FontWeight
                                          //                                     .w500),
                                          //                       ),
                                          //                       Text(
                                          //                         'N ',
                                          //                         textAlign:
                                          //                             TextAlign.center,
                                          //                         style: TextStyle(
                                          //                             fontSize: MediaQuery.of(context).size.width/37,
                                          //                             color:
                                          //                                 Colors.white,
                                          //                             fontStyle:
                                          //                                 FontStyle
                                          //                                     .normal,
                                          //                             fontWeight:
                                          //                                 FontWeight
                                          //                                     .w500),
                                          //                       ),
                                          //                       Text(
                                          //                         'G ',
                                          //                         textAlign:
                                          //                             TextAlign.center,
                                          //                         style: TextStyle(
                                          //                             fontSize: MediaQuery.of(context).size.width/37,
                                          //                             color:
                                          //                                 Colors.white,
                                          //                             fontStyle:
                                          //                                 FontStyle
                                          //                                     .normal,
                                          //                             fontWeight:
                                          //                                 FontWeight
                                          //                                     .w500),
                                          //                       ),
                                          //                       Text(
                                          //                         'O',
                                          //                         textAlign:
                                          //                             TextAlign.center,
                                          //                         style: TextStyle(
                                          //                             fontSize: MediaQuery.of(context).size.width/37,
                                          //                             color:
                                          //                                 Colors.white,
                                          //                             fontStyle:
                                          //                                 FontStyle
                                          //                                     .normal,
                                          //                             fontWeight:
                                          //                                 FontWeight
                                          //                                     .w500),
                                          //                       ),
                                          //                     ],
                                          //                   )),
                                          //               Expanded(
                                          //                 child: Padding(
                                          //                   padding:
                                          //                       const EdgeInsets.all(
                                          //                           0.0),
                                          //                   child: FittedBox(
                                          //                     //padding: const EdgeInsets.all(8.0),
                                          //                     child: Container(
                                          //                       margin:
                                          //                           EdgeInsets.all(4),
                                          //                       color: Colors.black
                                          //                           .withOpacity(0.7),
                                          //                       child: Container(
                                          //                         margin:
                                          //                             EdgeInsets.all(0),
                                          //                         height: MediaQuery.of(
                                          //                                     context)
                                          //                                 .size
                                          //                                 .width *
                                          //                             0.36,
                                          //                         width: MediaQuery.of(
                                          //                                     context)
                                          //                                 .size
                                          //                                 .width *
                                          //                             0.36,
                                          //                         // //color: Color(0xFF1c1863),
                                          //                         child: Stack(
                                          //                           children: <Widget>[
                                          //                             GridView.builder(
                                          //                               physics:
                                          //                                   new NeverScrollableScrollPhysics(),
                                          //                               itemCount: 25,
                                          //                               gridDelegate:
                                          //                                   new SliverGridDelegateWithFixedCrossAxisCount(
                                          //                                 crossAxisCount:
                                          //                                     5,
                                          //                                 //childAspectRatio: (20 / 20),
                                          //                               ),
                                          //                               itemBuilder:
                                          //                                   (BuildContext
                                          //                                           context,
                                          //                                       int index) {
                                          //                                 return index !=
                                          //                                         12
                                          //                                     ? GestureDetector(
                                          //                                         onTap:
                                          //                                             () {
                                          //                                           setState(() {
                                          //                                             touchedBox2(touchIndex: index, box: 3);
                                          //                                           });

                                          //                                           print("7777777777777777777777777777777777777777777777777777777777777777");
                                          //                                         },
                                          //                                         child:
                                          //                                             Card(
                                          //                                           clipBehavior:
                                          //                                               Clip.antiAlias,
                                          //                                           child:
                                          //                                               FadeTransition(
                                          //                                             opacity: animation,
                                          //                                             child: AnimatedContainer(
                                          //                                               alignment: Alignment.center,
                                          //                                               duration: Duration(seconds: 4),
                                          //                                               // Provide an optional curve to make the animation feel smoother.
                                          //                                               curve: Curves.easeInOutQuad,
                                          //                                               //Curves.fastOutSlowIn,
                                          //                                               padding: EdgeInsets.only(top: 0),
                                          //                                               decoration: setGold(index, 3),
                                          //                                               child: Padding(
                                          //                                                 padding: const EdgeInsets.all(2.5),
                                          //                                                 child: FittedBox(
                                          //                                                   child: AutoSizeText(
                                          //                                                     data["playing_box_3"][index].toString(),
                                          //                                                     maxLines: 2,
                                          //                                                     textAlign: TextAlign.center,
                                          //                                                     style: TextStyle(
                                          //                                                       fontSize: 25,
                                          //                                                       color: Colors.black,
                                          //                                                     ),
                                          //                                                   ),
                                          //                                                 ),
                                          //                                               ),
                                          //                                             ),
                                          //                                           ),
                                          //                                         ),
                                          //                                       )
                                          //                                     : Card(
                                          //                                         clipBehavior:
                                          //                                             Clip.antiAlias,
                                          //                                         child:
                                          //                                             FadeTransition(
                                          //                                           opacity:
                                          //                                               animation,
                                          //                                           child:
                                          //                                               AnimatedContainer(
                                          //                                             alignment: Alignment.center,
                                          //                                             duration: Duration(seconds: 2),
                                          //                                             // Provide an optional curve to make the animation feel smoother.
                                          //                                             curve: Curves.easeInOutQuad,
                                          //                                             //Curves.fastOutSlowIn,
                                          //                                             padding: EdgeInsets.only(top: 0),
                                          //                                             decoration: BoxDecoration(
                                          //                                               color: isGold ? Color(0xfff4b938) : Colors.white.withOpacity(1),
                                          //                                             ),
                                          //                                             child: Padding(
                                          //                                               padding: const EdgeInsets.all(2.5),
                                          //                                               child: FittedBox(
                                          //                                                 child: AutoSizeText(
                                          //                                                   'Free',
                                          //                                                   maxLines: 2,
                                          //                                                   textAlign: TextAlign.center,
                                          //                                                   style: TextStyle(
                                          //                                                     fontSize: 25,
                                          //                                                     color: Colors.black,
                                          //                                                   ),
                                          //                                                 ),
                                          //                                               ),
                                          //                                             ),
                                          //                                           ),
                                          //                                         ),
                                          //                                       );
                                          //                               },
                                          //                             ),
                                          //                             // FadeTransition(
                                          //                             //   opacity: animation,
                                          //                             //   child: AnimatedContainer(
                                          //                             //     width: isScrached == true
                                          //                             //         ? 0
                                          //                             //         : 290,

                                          //                             //     duration: Duration(seconds: 2),
                                          //                             //     // Provide an optional curve to make the animation feel smoother.
                                          //                             //     // curve: Curves.easeOut,

                                          //                             //     color: isScrached == false
                                          //                             //         ? Color(0xFF1c1863)
                                          //                             //             .withOpacity(0.9)
                                          //                             //         : Color(0xFF1c1863)
                                          //                             //             .withOpacity(0.5),

                                          //                             //   ),
                                          //                             // )
                                          //                           ],
                                          //                           // padding: const EdgeInsets.all(.0),
                                          //                         ),
                                          //                       ),
                                          //                     ),
                                          //                   ),
                                          //                 ),
                                          //               )
                                          //             ],
                                          //           ),
                                          //         ),
                                          //         Container(
                                          //           margin: EdgeInsets.only(right: 5),
                                          //           width: MediaQuery.of(context)
                                          //                   .size
                                          //                   .width *
                                          //               0.3,
                                          //           height: MediaQuery.of(context)
                                          //                   .size
                                          //                   .width *
                                          //               0.35,
                                          //           color: Color(0xFF1c1863),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // ),
                                          Container(
                                            height: 30,
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 50,
                                      left: 3000,
                                      child: hasWinner && bingoIndex >= 25
                                          ? AnimatedContainer(
                                              duration: Duration(seconds: 2),
                                              // Provide an optional curve to make the animation feel smoother.
                                              curve: Curves.easeInOutQuad,
                                              child:
                                                  Image.asset("assets/gold.gif"),
                                            )
                                          : AnimatedContainer(
                                              duration: Duration(seconds: 2),
                                              // Provide an optional curve to make the animation feel smoother.
                                              curve: Curves.easeInOutQuad,
                                            ),
                                    ),
                                    Positioned(
                                      top: 50,
                                      left: 0,
                                      child: hasWinner && bingoIndex >= 25 && started1>1
                                          ? AnimatedContainer(
                                              duration: Duration(seconds: 2),
                                              // Provide an optional curve to make the animation feel smoother.
                                              curve: Curves.easeInOutQuad,
                                              child:
                                                  Image.asset("assets/gold.gif"),
                                            )
                                          : AnimatedContainer(
                                              duration: Duration(seconds: 2),
                                              // Provide an optional curve to make the animation feel smoother.
                                              curve: Curves.easeInOutQuad,
                                            ),
                                    ),
                                    Positioned(
                                      top: 50,
                                      left: -100,
                                      child: hasWinner && bingoIndex >= 25 && started1>1
                                          ? AnimatedContainer(
                                              duration: Duration(seconds: 2),
                                              // Provide an optional curve to make the animation feel smoother.
                                              curve: Curves.easeInOutQuad,
                                              child:
                                                  Image.asset("assets/gold.gif"),
                                            )
                                          : AnimatedContainer(
                                              duration: Duration(seconds: 2),
                                              // Provide an optional curve to make the animation feel smoother.
                                              curve: Curves.easeInOutQuad,
                                            ),
                                    ),
                                     Positioned(
                                      top: 50,
                                      left: 100,
                                      child: hasWinner && bingoIndex >= 25 && started1>1
                                          ? AnimatedContainer(
                                              duration: Duration(seconds: 2),
                                              // Provide an optional curve to make the animation feel smoother.
                                              curve: Curves.easeInOutQuad,
                                              child:
                                                  Image.asset("assets/gold.gif"),
                                            )
                                          : AnimatedContainer(
                                              duration: Duration(seconds: 2),
                                              // Provide an optional curve to make the animation feel smoother.
                                              curve: Curves.easeInOutQuad,
                                            ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      child: winerAnimation(),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: 70,
                                      child: winerAnimation(),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: 110,
                                      child: winerAnimation(),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: 200,
                                      child: winerAnimation(),
                                    ),
                                    winerAnimation(),
                              ],
                            );
                          }),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}


