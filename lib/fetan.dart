import 'dart:math';

import 'package:flutter/material.dart';

class Fetan extends StatefulWidget {
  Fetan({Key key}) : super(key: key);

  @override
  _BingoState createState() => _BingoState();
}

class _BingoState extends State<Fetan> {
  final double radius = 60;
  final double dotRadius = 60;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Card(
            elevation: 10,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height,
                //color: Color(0xFF1c1863),
                color: Colors.white,
                child: Center(
                  child:
                      // child: Stack(
                      //   children: <Widget>[
                      //     Positioned(
                      //       top: MediaQuery.of(context).size.height * 0.4,
                      //       left: MediaQuery.of(context).size.width * 0.4,
                      //       child: Container(
                      //         width: 60,
                      //         height: 100,
                      //         decoration: BoxDecoration(
                      //           color: Colors.white,
                      //           borderRadius: BorderRadius.only(
                      //               bottomRight: Radius.circular(100.0),
                      //               bottomLeft: Radius.circular(100)),
                      //         ),
                      //       ),
                      //     ),
                      //     Positioned(
                      //       top: MediaQuery.of(context).size.height * 0.361,
                      //       left: MediaQuery.of(context).size.width * 0.543,
                      //       child: Transform.rotate(
                      //         angle: -pi / 4,
                      //         child: Container(
                      //           width: 60,
                      //           height: 100,
                      //           decoration: BoxDecoration(
                      //             color: Colors.white,
                      //             borderRadius: BorderRadius.only(
                      //                 bottomRight: Radius.circular(100.0),
                      //                 bottomLeft: Radius.circular(100)),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     Positioned(
                      //       top: MediaQuery.of(context).size.height * 0.267,
                      //       left: MediaQuery.of(context).size.width * 0.603,
                      //       child: Transform.rotate(
                      //         angle: -pi / 2,
                      //         child: Container(
                      //           width: 60,
                      //           height: 100,
                      //           decoration: BoxDecoration(
                      //             color: Colors.white,
                      //             borderRadius: BorderRadius.only(
                      //                 bottomRight: Radius.circular(100.0),
                      //                 bottomLeft: Radius.circular(100)),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     Positioned(
                      //       top: MediaQuery.of(context).size.height * 0.182,
                      //       left: MediaQuery.of(context).size.width * 0.564,
                      //       child: Transform.rotate(
                      //         angle: -pi / 1.5,
                      //         child: Container(
                      //           width: 60,
                      //           height: 100,
                      //           decoration: BoxDecoration(
                      //             color: Colors.white,
                      //             borderRadius: BorderRadius.only(
                      //                 bottomRight: Radius.circular(100.0),
                      //                 bottomLeft: Radius.circular(100)),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Stack(
                    children: <Widget>[
                      new Transform.translate(
                        offset: Offset(0.0, 0.0),
                        child: Container(
                          width: 60,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(100.0),
                                bottomLeft: Radius.circular(100)),
                          ),
                        ),
                      ),
                      new Transform.translate(
                        child: Transform.rotate(
                          angle: -pi / 4,
                          child: Material(
                            
                            shape: Border(
                              right: BorderSide(
                                width: 1,
                                color: Colors.black,
                              ),
                              left: BorderSide(
                                width: 1,
                                color: Colors.black,
                              ),
                              bottom: BorderSide(
                                width: 1,
                                color: Colors.black,
                              ),
                              top: BorderSide(
                                width: 1,
                                color: Colors.white,
                              ),
                            ),
                            child: Container(
                              width: 60,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        offset: Offset(
                          86,
                          -36,
                        ),
                      ),
                      // new Transform.translate(
                      //   child: Container(
                      //     width: 60,
                      //     height: 100,
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.only(
                      //           bottomRight: Radius.circular(100.0),
                      //           bottomLeft: Radius.circular(100)),
                      //     ),
                      //   ),
                      //   offset: Offset(
                      //     radius * cos(0.0 + 1 * pi / 4),
                      //     radius * sin(0.0 + 1 * pi / 4),
                      //   ),
                      // ),
                      // new Transform.translate(
                      //   child: Container(
                      //     width: 60,
                      //     height: 100,
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.only(
                      //           bottomRight: Radius.circular(100.0),
                      //           bottomLeft: Radius.circular(100)),
                      //     ),
                      //   ),
                      //   offset: Offset(
                      //     radius * cos(0.0 + 2 * pi / 4),
                      //     radius * sin(0.0 + 2 * pi / 4),
                      //   ),
                      // ),
                      // new Transform.translate(
                      //   child: Container(
                      //     width: 60,
                      //     height: 100,
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.only(
                      //           bottomRight: Radius.circular(100.0),
                      //           bottomLeft: Radius.circular(100)),
                      //     ),
                      //   ),
                      //   offset: Offset(
                      //     radius * cos(0.0 + 3 * pi / 4),
                      //     radius * sin(0.0 + 3 * pi / 4),
                      //   ),
                      // ),
                      // new Transform.translate(
                      //   child: Container(
                      //     width: 60,
                      //     height: 100,
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.only(
                      //           bottomRight: Radius.circular(100.0),
                      //           bottomLeft: Radius.circular(100)),
                      //     ),
                      //   ),
                      //   offset: Offset(
                      //     radius * cos(0.0 + 4 * pi / 4),
                      //     radius * sin(0.0 + 4 * pi / 4),
                      //   ),
                      // ),
                      // new Transform.translate(
                      //   child: Container(
                      //     width: 60,
                      //     height: 100,
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.only(
                      //           bottomRight: Radius.circular(100.0),
                      //           bottomLeft: Radius.circular(100)),
                      //     ),
                      //   ),
                      //   offset: Offset(
                      //     radius * cos(0.0 + 5 * pi / 4),
                      //     radius * sin(0.0 + 5 * pi / 4),
                      //   ),
                      // ),
                      // new Transform.translate(
                      //   child: Container(
                      //     width: 60,
                      //     height: 100,
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.only(
                      //           bottomRight: Radius.circular(100.0),
                      //           bottomLeft: Radius.circular(100)),
                      //     ),
                      //   ),
                      //   offset: Offset(
                      //     radius * cos(0.0 + 6 * pi / 4),
                      //     radius * sin(0.0 + 6 * pi / 4),
                      //   ),
                      // ),
                      // new Transform.translate(
                      //   child: Dot(
                      //     radius: dotRadius,
                      //     color: Colors.blueAccent,
                      //   ),
                      //   offset: Offset(
                      //     radius * cos(0.0 + 7 * pi / 4),
                      //     radius * sin(0.0 + 7 * pi / 4),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}


// var myColor = Color(0xFF1c1863);

//  Container(
//                                                     padding: EdgeInsets.all(10),
//                                                     height: 40,
//                                                     width: 54,
//                                                     decoration: BoxDecoration(
//                                                       color: myColor,
//                                                       border: Border(),
//                                                     ),
//                                                     child: GestureDetector(
//                                                       onTapDown: (TapDownDetails
//                                                           details) {
//                                                         setState(() {
//                                                           myColor = Colors
//                                                               .transparent;
//                                                         });
//                                                       },
//                                                       // onTap: () {
//                                                       //   setState(() {
//                                                       //     myColor = Colors
//                                                       //         .transparent;
//                                                       //   });
//                                                       // },
//                                                       // onPanUpdate:
//                                                       //     (DragUpdateDetails
//                                                       //         details) {
//                                                       //   setState(() {
//                                                       //     myColor = Colors
//                                                       //         .transparent;
//                                                       //   });
//                                                       // },
//                                                     ),
//                                                   ),




 