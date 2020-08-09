import 'dart:math';

import 'package:Lottery/bingo.dart';
import 'package:Lottery/bingo_normal.dart';
import 'package:Lottery/bingo_tab.dart';
import 'package:Lottery/birr.dart';
import 'package:Lottery/caller.dart';
import 'package:flutter/material.dart';
import 'DB.dart';
import 'bingo.dart';
import 'package:http/http.dart' as http;

class Explore extends StatefulWidget {
  // Explore({Key key}) : super(key: key);
  String birr;
  Explore({this.birr});

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  int five = 5;

  int rand;
sendData()
  {
    // http.post("https://newdayshotel.com/demo/get.php",body:{
    //         "name": "admin",
    //         "phone_number": "",
           
    //       })
     http.get(
        "https://newdayshotel.com/demo/api.php",
        headers: {"Accept": "application/json"})
        .then(
      (value) {
        if (value.statusCode == 200) {
          print(value.body.toString());
        //  Navigator.of(context).pop(false);
          print(
              "mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
        } else {
          print(value.statusCode.toString());
        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 20, 0, 7),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Caller',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                        color: Color(0xFFF78361),
                                        fontWeight: FontWeight.w800,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5.0, vertical: 0),
                        child: Container(
                          height: 00,
                          width: double.infinity,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      )
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: new BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0))),
                    //padding: const EdgeInsets.fromLTRB(0, 0, right, bottom),
                    height: 240,
                    //color: Colors.transparent,
                     /// this in snot the rath t
                     /// 
                    child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        addAutomaticKeepAlives: false,
                        padding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal:
                                MediaQuery.of(context).size.width * 0.2),
                        itemCount: 1,
                        gridDelegate:
                            new SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: (240 / 190),
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10, 8, 0, 4),
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              color: Colors.transparent,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.all(
                                      Radius.circular(10))),
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
                                    onTap: () {
                                      sendData();
                                      Navigator.of(context).push(
                                          new MaterialPageRoute(
                                              builder: (BuildContext context) {
                                        {
                                          int min = 1;
                                          int max = 21;
                                          Random rnd = new Random();
                                          rand = min + rnd.nextInt(max - min);
                                        }
                                        return Caller();
                                      }));
                                    },
                                    child: Hero(
                                      tag: "tag$index 1",
                                      child: Image.asset('assets/bingo5.jpg',
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
