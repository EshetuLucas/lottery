import 'package:flutter/material.dart';

import 'DB.dart';
class History extends StatefulWidget {
  const History({Key key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
    int amount = 3;
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
    getData() {
    // if(allData!=null)
    // allData.clear();
    int counter = 0;
    dbHelper.queryAllRows1().then((value) {
      //print(value.toString());
      // histValue = value[2]['name'].toString().split(",");
      setState(() {
        history = value;
        // maxLimit = value[0]['amount'];
        // over = value[0]['over'];
        // print(maxLimit.toString());
      });

      print(histValue[0].toString());
    });
    // dbHelper.queryAllRows().then((value) {
    //   setState(() {
    //     allData = value;
    //     isDataNull = false;
    //     for (int i = 0; i < allData.length; i++) {
    //       if (allData[i]['over'] == 1 || allData[i]['name'] == "n") {
    //         counter++;
    //       }
    //       if (allData[i]['over'] == 1) {
    //         lossIndex.add(i);
    //       }
    //     }
    //     numberOfPlayer = allData.length - counter;
    //     //print(value.toString());
    //   });
    // });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  history != null
                            ? Container(
                              child: Expanded(
                                  child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      addAutomaticKeepAlives: false,
                                       physics:
                                                    NeverScrollableScrollPhysics(),
                                      itemCount: history.length - 1,
                                      itemBuilder:
                                          (BuildContext context, int indexOfList) {
                                        return Container(
                                          height: 58,
                                          child: GridView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              addAutomaticKeepAlives: false,
                                              itemCount: crossAxis,
                                              gridDelegate:
                                                  new SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: crossAxis,
                                              ),
                                              itemBuilder: (BuildContext context,
                                                  int index) {
                                                return Container(
                                                  child: Container(
                                                    width: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        10,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black,
                                                          width: 0.5),
                                                    ),
                                                    clipBehavior: Clip.antiAlias,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(2.0),
                                                      child: Material(
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        shadowColor: Colors.white,
                                                        //color: Colors.black,
                                                        borderRadius:
                                                            new BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(0),
                                                          topRight:
                                                              Radius.circular(0),
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
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom: 0,
                                                                    left: 0),
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .all(20 -
                                                                      paddingChanger),
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child: FittedBox(
                                                                child: Text(
                                                                    history[indexOfList +
                                                                                    1]
                                                                                ['name']
                                                                            .toString()
                                                                            .split(
                                                                                ",")[
                                                                        index],
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            16),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center),
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
                            : Container(),
    );
  }
}