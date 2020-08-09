import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'HomePageBackground.dart';
import 'one.dart';

class BingoNormal extends StatefulWidget {
  int cardNumber;

  BingoNormal(this.cardNumber);

  @override
  _BingoState createState() => _BingoState();
}

class _BingoState extends State<BingoNormal>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  int randN;
  bool gif = true;
  int pop = 0;
  int pop1 = 0;
  int pop3 = 0;
  int currentValueIndex;
  int newValue = 5;
  changeValue({int index, String val}) {
    if (bingoNumbers[currentValueIndex] < 16 &&
        bingoNumbers[currentValueIndex] > 0) {
      for (int i = 0; i < 25; i++) {
        fake.add(i);
      }
      // for(int i = 16;i<=25;i++)
      // {
      //   fake.add(bingoNumbers[i]);
      // }

    } else if (bingoNumbers[currentValueIndex] < 31 &&
        bingoNumbers[currentValueIndex] > 15) {
    } else if (bingoNumbers[currentValueIndex] < 46 &&
        bingoNumbers[currentValueIndex] > 30) {
    } else if (bingoNumbers[currentValueIndex] < 61 &&
        bingoNumbers[currentValueIndex] > 45) {
    } else if (bingoNumbers[currentValueIndex] < 76 &&
        bingoNumbers[currentValueIndex] > 60) {}
    print("inddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
    // if (val == "0")
    //   bingoNumbers[currentValueIndex] = bingoNumbers[currentValueIndex] + 1;
    // else
    //   bingoNumbers[currentValueIndex] = bingoNumbers[currentValueIndex] - 1;
  }

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

  List<int> bingoNumbers = new List();
  List<int> bingoNumbers2 = new List();
  List<int> fake = new List();
  int min;
  int max;
  int r;
  Random rnd;
  bool isdouble = false;
  checkDouble(int bingoNumber, int min, int max) {
    rnd = new Random();
    r = min + rnd.nextInt(max - min);
  }

  randomNumner(int box) {
    for (int i = 0; i < 5; i++) {
      min = 1;
      max = 16;
      rnd = new Random();
      r = min + rnd.nextInt(max - min);
      print(r);
      if (bingoNumbers.length != 0) {
        for (int j = 0; j < i; j++) {
          if (r == bingoNumbers[j * 5]) {
            min = 1;
            max = 16;
            rnd = new Random();
            r = min + rnd.nextInt(max - min);
            j = -1;
          }
        }

        bingoNumbers.add(r);
      } else {
        bingoNumbers.add(r);
      }

      min = 16;
      max = 31;
      rnd = new Random();
      r = min + rnd.nextInt(max - min);
      if (bingoNumbers.length != 0) {
        for (int j = 0; j < i; j++) {
          if (r == bingoNumbers[j * 5 + 1]) {
            min = 16;
            max = 31;
            rnd = new Random();
            r = min + rnd.nextInt(max - min);
            j = -1;
          }
        }

        bingoNumbers.add(r);
      } else {
        bingoNumbers.add(r);
      }
      min = 31;
      max = 46;
      rnd = new Random();
      r = min + rnd.nextInt(max - min);
      if (bingoNumbers.length != 0) {
        for (int j = 0; j < i; j++) {
          if (r == bingoNumbers[j * 5 + 2]) {
            min = 31;
            max = 46;
            rnd = new Random();
            r = min + rnd.nextInt(max - min);
            j = -1;
          }
        }

        bingoNumbers.add(r);
      } else {
        bingoNumbers.add(r);
      }
      min = 46;
      max = 61;
      rnd = new Random();
      r = min + rnd.nextInt(max - min);
      if (bingoNumbers.length != 0) {
        for (int j = 0; j < i; j++) {
          if (r == bingoNumbers[j * 5 + 3]) {
            min = 46;
            max = 61;
            rnd = new Random();
            r = min + rnd.nextInt(max - min);
            j = -1;
          }
        }

        bingoNumbers.add(r);
      } else {
        bingoNumbers.add(r);
      }
      min = 61;
      max = 76;
      rnd = new Random();
      r = min + rnd.nextInt(max - min);
      if (bingoNumbers.length != 0) {
        for (int j = 0; j < i; j++) {
          if (r == bingoNumbers[j * 5 + 4]) {
            min = 61;
            max = 76;
            rnd = new Random();
            r = min + rnd.nextInt(max - min);
            j = -1;
          }
        }

        bingoNumbers.add(r);
      } else {
        bingoNumbers.add(r);
      }
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

  bool touched({int index, int touchIndex, int box}) {
    toucheIndexs.add(touchIndex);
    for (int i = 0; i < toucheIndexs.length; i++) {
      if (index == toucheIndexs[i]) {
        return true;
      }
    }

    return false;
  }

  checkIn(int index) {
    for (int i = 0; i < toucheIndexs2.length; i++) {
      if (index == toucheIndexs2[i]) {
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
                  : Colors.black.withOpacity(0.86));
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
                  : Colors.black.withOpacity(0.86));
        }
      }
      {
        return BoxDecoration(
          color: touchedBox1(index: index)
              ? Colors.white.withOpacity(0.95)
              : Colors.black.withOpacity(0.86),
        );
      }
    } else if (box == 3) {
      for (int i = 0; i < bingo3.length; i++) {
        if (100 == bingo2[i]) {
          isGold = true;
          return BoxDecoration(
              color: setColor(index, 3)
                  ? Color(0xfff4b938)
                  : Colors.black.withOpacity(0.86));
        }
      }
      {
        return BoxDecoration(
          color: touchedBox2(index: index)
              ? Colors.white.withOpacity(0.95)
              : Colors.black.withOpacity(0.86),
        );
      }
    }
    {
      return BoxDecoration(
        color: touched(index: index)
            ? Colors.white.withOpacity(0.95)
            : Colors.black.withOpacity(0.86),
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
    randomNumner(1);
    randomNumner(2);
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });
    controller.forward();
    int min = 1;
    int max = 21;
    Random rnd = new Random();
    randN = min + rnd.nextInt(max - min);
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
    void popUp() {
      showDialog(
        context: context,
        builder: (context) => Container(
          color: Colors.transparent,
          child: Container(
            //color: Color(0xFF1c1863),
            // height: MediaQuery.of(context).size.height,
            // margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            // width: MediaQuery.of(context).size.width,
            child: Stack(children: <Widget>[
              new HomePageBacground(
                  screenHeight: MediaQuery.of(context).size.height / 2),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 25, 10, 0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 4),
                      child: Card(
                          elevation: 0,
                          color: Color(0xFF1c1863),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                //width: MediaQuery.of(context).size.width / 2,
                                child: Column(
                                  children: <Widget>[
                                    FittedBox(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              pop3++;
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              child: RichText(
                                                text: TextSpan(
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text: 'Vegas ',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xfff4b938),
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                    TextSpan(
                                                        text: ' Bingo',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: FittedBox(
                                        child: Wrap(
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Card(
                                              elevation: 20,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    right: 0, left: 0),
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
                                                                  fontSize: MediaQuery.of(
                                                                              context)
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
                                                                  fontSize: MediaQuery.of(
                                                                              context)
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
                                                            GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  print(
                                                                      "jjjjjjjjjjjjjjjjjjjj");
                                                                  pop++;
                                                                });
                                                              },
                                                              child: Text(
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
                                                            ),
                                                            Text(
                                                              'G ',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: MediaQuery.of(
                                                                              context)
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
                                                            GestureDetector(
                                                              onTap: () {
                                                                changeValue(
                                                                    val: "O");
                                                              },
                                                              child: Text(
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
                                                            ),
                                                          ],
                                                        )),
                                                    Expanded(child: One(1))
                                                  ],
                                                ),
                                              ),
                                            ),

                                            ///iiii
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
                                    Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "Card Number",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
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
                                              padding: EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                              ),
                                              child: FloatingActionButton(
                                                elevation: 40,
                                                splashColor: Colors.black,
                                                onPressed: () {
                                                  //onClick(0, 0);
                                                },
                                                backgroundColor:
                                                    Color(0xFFF54864),
                                                child: Text(
                                                  bingoNumbers2[1].toString(),
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
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 50,
                                left: 100,
                                child: hasWinner &&
                                        bingoIndex >= 25 &&
                                        started1 > 1
                                    ? AnimatedContainer(
                                        duration: Duration(seconds: 2),
                                        // Provide an optional curve to make the animation feel smoother.
                                        curve: Curves.easeInOutQuad,
                                        child: Image.asset(
                                            "assets/celebrating.gif"),
                                      )
                                    : AnimatedContainer(
                                        duration: Duration(seconds: 2),
                                        // Provide an optional curve to make the animation feel smoother.
                                        curve: Curves.easeInOutQuad,
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
                                        child: Image.asset("assets/gold.gif"),
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
                                child: hasWinner &&
                                        bingoIndex >= 25 &&
                                        started1 > 1
                                    ? AnimatedContainer(
                                        duration: Duration(seconds: 2),
                                        // Provide an optional curve to make the animation feel smoother.
                                        curve: Curves.easeInOutQuad,
                                        child: Image.asset("assets/gold.gif"),
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
                                child: hasWinner &&
                                        bingoIndex >= 25 &&
                                        started1 > 1
                                    ? AnimatedContainer(
                                        duration: Duration(seconds: 2),
                                        // Provide an optional curve to make the animation feel smoother.
                                        curve: Curves.easeInOutQuad,
                                        child: Image.asset("assets/gold.gif"),
                                      )
                                    : AnimatedContainer(
                                        duration: Duration(seconds: 2),
                                        // Provide an optional curve to make the animation feel smoother.
                                        curve: Curves.easeInOutQuad,
                                      ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(

           //color: Colors.pink,
          child: Stack(children: <Widget>[
              new HomePageBacground(
                  screenHeight: MediaQuery.of(context).size.height / 1.3),
      Center(
 
              //color: Color(0xFF1c1863),
              // height: MediaQuery.of(context).size.height,
              // margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              // width: MediaQuery.of(context).size.width,
              child: Stack(children: <Widget>[
                // new HomePageBacground(
                //     screenHeight: MediaQuery.of(context).size.height / 2.5),
                SingleChildScrollView(
                              child: Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 10, 0),
                      child: Center(
                        
                        child: Card(
                          elevation: 20,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 4),
                            child: Card(
                                elevation: 0,
                                color: Color(0xFF1c1863),
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      //width: MediaQuery.of(context).size.width / 2,
                                      child: Column(
                                        children: <Widget>[
                                          
                                          FittedBox(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: () {
                                                    // pop3++;
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                              text: 'Vegas ',
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xfff4b938),
                                                                  fontSize: 29,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                          TextSpan(
                                                              text: ' Bingo',
                                                              style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 25,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                gif
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets.all(8.0),
                                                        child: hasWinner
                                                            ? AnimatedContainer(
                                                                height: 50,
                                                                width: 50,
                                                                duration: Duration(
                                                                    seconds: 1),
                                                                // Provide an optional curve to make the animation feel smoother.
                                                                curve: Curves
                                                                    .easeInOutQuad,
                                                                child: Image.asset(
                                                                    "assets/celebrating.gif"),
                                                              )
                                                            : AnimatedContainer(
                                                                height: 50,
                                                                width: 0,
                                                                duration: Duration(
                                                                    seconds: 4),
                                                                // Provide an optional curve to make the animation feel smoother.
                                                                curve: Curves
                                                                    .easeInOutQuad,
                                                                child: Image.asset(
                                                                    "assets/celebrating.gif"),
                                                              ),
                                                      )
                                                    : Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Container(height: 50,
                                                                  width: 50,),
                                                    )
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 0),
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            child: FittedBox(
                                              child: Wrap(
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Card(
                                                    clipBehavior: Clip.antiAlias,
                                                    elevation: 20,
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          right: 0, left: 0),
                                                      width: MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.3,
                                                      height: MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.35,
                                                      color: Color(0xFF1c1863),
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
                                                              color: Colors.black38,
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
                                                                        fontSize: MediaQuery.of(
                                                                                    context)
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
                                                                        fontSize: MediaQuery.of(
                                                                                    context)
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
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      // setState(() {
                                                                      //   print(
                                                                      //       "jjjjjjjjjjjjjjjjjjjj");
                                                                      //   //pop++;
                                                                      // });
                                                                    },
                                                                    child: Text(
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
                                                                  ),
                                                                  Text(
                                                                    'G ',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        fontSize: MediaQuery.of(
                                                                                    context)
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
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      changeValue(
                                                                          val: "O");
                                                                    },
                                                                    child: Text(
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
                                                                  ),
                                                                ],
                                                              )),
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(0.0),
                                                              child: Container(
                                                                color: Colors.black
                                                                    .withOpacity(
                                                                        0.265),
                                                                child: FittedBox(
                                                                  //padding: const EdgeInsets.all(8.0),
                                                                  child: Container(
                                                                    margin: EdgeInsets
                                                                        .all(5),
                                                                    color: Colors
                                                                        .transparent,
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
                                                                                      onDoubleTap: () {
                                                                                        if (pop > 4) {
                                                                                          currentValueIndex = index;
                                                                                          fake.clear();
                                                                                          if (bingoNumbers[index] < 16 && bingoNumbers[index] > 0) {
                                                                                            for (int i = 1; i <= 15; i++) {
                                                                                              fake.add(i);
                                                                                            }
                                                                                            for (int i = 16; i <= 25; i++) {
                                                                                              fake.add(bingoNumbers[i]);
                                                                                            }

                                                                                            // for(int i = 16;i<=25;i++)
                                                                                            // {
                                                                                            //   fake.add(bingoNumbers[i]);
                                                                                            // }

                                                                                          } else if (bingoNumbers[currentValueIndex] < 31 && bingoNumbers[currentValueIndex] > 15) {
                                                                                            for (int i = 16; i <= 30; i++) {
                                                                                              fake.add(i);
                                                                                            }
                                                                                            for (int i = 16; i <= 25; i++) {
                                                                                              fake.add(bingoNumbers[i]);
                                                                                            }
                                                                                          } else if (bingoNumbers[currentValueIndex] < 46 && bingoNumbers[currentValueIndex] > 30) {
                                                                                            for (int i = 31; i <= 45; i++) {
                                                                                              fake.add(i);
                                                                                            }
                                                                                            for (int i = 16; i <= 25; i++) {
                                                                                              fake.add(bingoNumbers[i]);
                                                                                            }
                                                                                          } else if (bingoNumbers[currentValueIndex] < 61 && bingoNumbers[currentValueIndex] > 45) {
                                                                                            for (int i = 46; i <= 60; i++) {
                                                                                              fake.add(i);
                                                                                            }
                                                                                            for (int i = 16; i <= 25; i++) {
                                                                                              fake.add(bingoNumbers[i]);
                                                                                            }
                                                                                          } else if (bingoNumbers[currentValueIndex] < 76 && bingoNumbers[currentValueIndex] > 60) {
                                                                                            for (int i = 61; i <= 75; i++) {
                                                                                              fake.add(i);
                                                                                            }
                                                                                            for (int i = 16; i <= 25; i++) {
                                                                                              fake.add(bingoNumbers[i]);
                                                                                            }
                                                                                          }

                                                                                          popUp();
                                                                                        }
                                                                                        started1++;
                                                                                        setState(() {
                                                                                          touchedBox1(touchIndex: index, box: 1);
                                                                                        });
                                                                                      },
                                                                                      onTap: () {
                                                                                        started1++;
                                                                                        hasWinner = true;
                                                                                        Timer(Duration(seconds: 3), () {
                                                                                          setState(() {
                                                                                            hasWinner = false;
                                                                                          });

                                                                                          //  Navigator.of(context).push(
                                                                                          //                     new MaterialPageRoute(
                                                                                          //                         builder: (BuildContext context) {
                                                                                          //                   return Birr();
                                                                                          //                 }));
                                                                                        });
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
                                                                                            // curve: Curves.easeInOutQuad,
                                                                                            //Curves.fastOutSlowIn,
                                                                                            padding: EdgeInsets.only(top: 0),
                                                                                            decoration: setGold(index, 1),
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.all(2.5),
                                                                                              child: FittedBox(
                                                                                                child: AutoSizeText(
                                                                                                  bingoNumbers[index].toString(),
                                                                                                  maxLines: 2,
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: TextStyle(
                                                                                                    fontSize: 25,
                                                                                                    color: checkIn(index) ? Colors.black : Colors.white70,
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
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                  ///iiii
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
                                          Row(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "Card Number",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 15, 15, 15),
                                                  child: SizedBox(
                                                    height: 40,
                                                    width: 80,
                                                    child: Container(
                                                      height: 50,
                                                      width: 100,
                                                      padding: EdgeInsets.all(2),
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: gif
                                                            ? Color(0xfff4b938)
                                                            : Colors.white,
                                                      ),
                                                      child: FloatingActionButton(
                                                        elevation: 40,
                                                        splashColor: Colors.black,
                                                        onPressed: () {
                                                          setState(() {
                                                            if (gif)
                                                              gif = false;
                                                            else
                                                              gif = true;
                                                          });
                                                        },
                                                        backgroundColor:
                                                            Color(0xFF1c1863),
                                                        child: Text(
                                                          randN.toString(),
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
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: GestureDetector(
                                                  onDoubleTap: () {
                                                    //         Navigator.of(context).pop(false);
                                                    //          int rand ;
                                                    // Navigator.of(context).push(
                                                    //     new MaterialPageRoute(
                                                    //         builder: (BuildContext context) {
                                                    //            {
                                                    //       int min = 1;
                                                    //       int max = 21;
                                                    //       Random rnd = new Random();
                                                    //       rand = min + rnd.nextInt(max - min);
                                                    //     }
                                                    //   return BingoNormal(rand);
                                                    // }));
                                                  },
                                                  onTap: () {
                                                    hasWinner = true;

                                                    setState(() {
                                                      toucheIndexs2.clear();
                                                      bingoNumbers.clear();
                                                      randomNumner(2);
                                                      int min = 1;
                                                      int max = 21;
                                                      Random rnd = new Random();
                                                      randN = min +
                                                          rnd.nextInt(max - min);
                                                    });

                                                    // initState();
                                                    //         Navigator.of(context).pop(false);
                                                    //          int rand ;
                                                    // Navigator.of(context).push(
                                                    //     new MaterialPageRoute(
                                                    //         builder: (BuildContext context) {
                                                    //            {
                                                    //       int min = 1;
                                                    //       int max = 21;
                                                    //       Random rnd = new Random();
                                                    //       rand = min + rnd.nextInt(max - min);
                                                    //     }
                                                    //   return BingoNormal(rand);
                                                    // }));
                                                  },
                                                  child: ButtonTheme(
                                                    minWidth: 80,
                                                    height: 30,
                                                    child: RaisedButton(
                                                      // onPressed: () {
                                                      //   Navigator.of(context)
                                                      //       .pop(false);
                                                      //   Navigator.of(context).push(
                                                      //       new MaterialPageRoute(
                                                      //           builder: (BuildContext
                                                      //               context) {
                                                      //     return BingoNormal(1);
                                                      //   }));
                                                      // },
                                                      padding:
                                                          const EdgeInsets.all(0.0),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            new BorderRadius.circular(
                                                                20.0),
                                                      ),
                                                      child: Container(
                                                        width: 90,
                                                        height: 40,
                                                        alignment: Alignment.center,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors.white,
                                                              width: 2),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0)),
                                                          gradient: LinearGradient(
                                                            colors: <Color>[
                                                              // Color(0xFF1c1863),
                                                              // Color(0xFF1c1863),
                                                              Colors.pink,
                                                              Colors.pink,
                                                            ],
                                                          ),
                                                        ),
                                                        padding:
                                                            const EdgeInsets.all(0.0),
                                                        child: const Text(
                                                          'Reset',
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
                                              ),
                                            ],
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
                                              child: Image.asset("assets/gold.gif"),
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
                                      child: hasWinner &&
                                              bingoIndex >= 25 &&
                                              started1 > 1
                                          ? AnimatedContainer(
                                              duration: Duration(seconds: 2),
                                              // Provide an optional curve to make the animation feel smoother.
                                              curve: Curves.easeInOutQuad,
                                              child: Image.asset("assets/gold.gif"),
                                            )
                                          : AnimatedContainer(
                                              duration: Duration(seconds: 2),
                                              // Provide an optional curve to make the animation feel smoother.
                                              curve: Curves.easeInOutQuad,
                                            ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
              
            ),
            ]),
            
          ),
        ),
      
    );
  }
}
