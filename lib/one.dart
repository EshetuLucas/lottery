import 'dart:convert';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:http/http.dart' as https;
import 'HomePageBackground.dart';

class One extends StatefulWidget {
  int cardNumber;

  One(this.cardNumber);

  @override
  _BingoState createState() => _BingoState();
}

class _BingoState extends State<One>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
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
          if (r == bingoNumbers[j*5]) {
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
  checkIn(int index)
  {
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
                  : Colors.black.withOpacity(0.85));
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
                  : Colors.black.withOpacity(0.85));
        }
      }
      {
        return BoxDecoration(
          color: touchedBox1(index: index)
              ? Colors.white.withOpacity(0.95)
              : Colors.black.withOpacity(0.85),
        );
      }
    } else if (box == 3) {
      for (int i = 0; i < bingo3.length; i++) {
        if (100 == bingo2[i]) {
          isGold = true;
          return BoxDecoration(
              color: setColor(index, 3)
                  ? Color(0xfff4b938)
                  : Colors.black.withOpacity(0.85));
        }
      }
      {
        return BoxDecoration(
          color: touchedBox2(index: index)
              ? Colors.white.withOpacity(0.95)
              : Colors.black.withOpacity(0.85),
        );
      }
    }
    {
      return BoxDecoration(
        color: touched(index: index)
            ? Colors.white.withOpacity(0.95)
            : Colors.black.withOpacity(0.85),
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
    return Padding(
                                                      padding:
                                                          const EdgeInsets
                                                              .all(0.0),
                                                      child: FittedBox(
                                                        //padding: const EdgeInsets.all(8.0),
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.all(
                                                                  4),
                                                          color: Color(0xfff4b938),
                                                          child: Container(
                                                            margin: EdgeInsets
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
                                                                      (BuildContext
                                                                              context,
                                                                          int index) {
                                                                    return index !=
                                                                            12
                                                                        ? GestureDetector(
                                                                            onTap: () {
                                                                              setState(() {
                                                                                newValue = fake[index];
                                                                                bingoNumbers[currentValueIndex] = newValue;
                                                                                print(newValue.toString());
                                                                                pop = 0;
                                                                              });

                                                                              Navigator.of(context).pop(false);

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
                                                                                        fake[index].toString(),
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
                                                    );
  }
}
