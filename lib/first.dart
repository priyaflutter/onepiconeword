import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:onepiconeword/main.dart';

class onepic extends StatefulWidget {
  const onepic({Key? key}) : super(key: key);

  @override
  State<onepic> createState() => _onepicState();
}

class _onepicState extends State<onepic> {
  List imagepathlist = [];
  List answerlist = [];
  List bottomlist = [];
  List checkbottomlist = List.filled(10, "");
  String imagepath = "";
  String spelling = "";
  int a = 0;
  List toplist = [];
  int cnt = 0;
  int rtu = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initImages();
  }

  Future initImages() async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('Images/'))
        .where((String key) => key.contains('.webp'))
        .toList();

    setState(() {
      imagepathlist = imagePaths;
      print(imagePaths);
    });

    a = Random().nextInt(imagepathlist.length);
    imagepath = imagepathlist[a];

    imagepathlist.shuffle();

    // imagepath = "Images/apple.webp";
    // print(imagepath);

    // List<String> list1 = imagepath.split("/"); //[Images, apple.webp]
    // print(list1);
    //
    // String s1=list1[1]; //apple.webp
    // print(s1);
    //
    // List<String> list2 = s1.split("\."); //[apple, webp]
    // print(list2);
    //
    // String s2=list2[0]; //apple
    // print(s2);

    spelling = imagepath.split("/")[1].split("\.")[0]; // apple
    print(spelling);

    answerlist = spelling.split(""); // [a, p, p, l, e]
    print(answerlist);

    toplist = List.filled(answerlist.length, ""); // [, , , , ]
    print(toplist);

    String abcd = "abcdefghijklmnopqrstuvwxyz";
    List abcdlist = abcd.split(
        ""); //[a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z]
    print(abcdlist);

    abcdlist
        .shuffle(); //[b, n, h, k, j, z, p, s, i, q, r, m, y, l, f, c, w, a, u, e, t, o, v, g, x, d]
    print(abcdlist);

    bottomlist =
        abcdlist.getRange(0, 10 - answerlist.length).toList(); //[q, c, y, v, o]
    print(bottomlist);

    bottomlist.addAll(answerlist);
    bottomlist.shuffle(); //[b, a, p, p, k, e, l, p, j, s]

    print(bottomlist);
  }

  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;
    double twidth = MediaQuery.of(context).size.width;
    double tappbar = kToolbarHeight;
    double tstatusbar = MediaQuery.of(context).padding.top;
    double navigatorbar = MediaQuery.of(context).padding.bottom;

    double bodyheight = theight - tstatusbar - navigatorbar;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: bodyheight * 0.06,
            decoration: BoxDecoration(color: Color(0xffe5c266)),
          ),
          Container(
            height: bodyheight * 0.40,
            decoration: BoxDecoration(color: Colors.yellow),
            child: Stack(
              children: [
                Container(
                  height: bodyheight * 0.38,
                  width: twidth,
                  decoration: BoxDecoration(),
                  child: Image(
                      image: AssetImage("Images/dialog_heading.png"),
                      fit: BoxFit.fill),
                ),
                Column(
                  children: [
                    Container(
                      height: bodyheight * 0.20,
                      width: twidth,
                      padding: EdgeInsets.all(bodyheight * 0.02),
                      margin: EdgeInsets.fromLTRB(bodyheight * 0.13,
                          bodyheight * 0.05, bodyheight * 0.13, 0),
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.all(
                              Radius.circular(bodyheight * 0.03))),
                      child: Image(
                        image: AssetImage("${imagepath}"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      height: bodyheight * 0.06,
                      width: twidth,
                      margin: EdgeInsets.fromLTRB(bodyheight * 0.05,
                          bodyheight * 0.02, bodyheight * 0.05, 0),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: toplist.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                if (toplist[index].toString().isNotEmpty) {
                                  rtu = checkbottomlist.indexOf(toplist[index]);
                                  bottomlist[rtu] = toplist[index];
                                  toplist[index] = "";
                                  cnt--;
                                  print(cnt);
                                }
                              });
                            },
                            child: Container(
                              height: bodyheight * 0.08,
                              width: bodyheight * 0.04,
                              margin: EdgeInsets.all(bodyheight * 0.01),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Color(0x66B3B2B2)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0x66B3B2B2),
                                        blurRadius: 2,
                                        spreadRadius: 2,
                                        offset: Offset(1, 0))
                                  ]),
                              child: Center(
                                  child: Text(
                                "${toplist[index]}",
                                style: TextStyle(fontSize: bodyheight * 0.03),
                              )),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: bodyheight * 0.25,
            child: Text(
              "${msg}",
              style: TextStyle(fontSize: bodyheight * 0.10),
            ),
          ),
          Container(
            height: bodyheight * 0.20,
            width: twidth * 0.60,
            // decoration: BoxDecoration(color: Colors.green),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: bottomlist.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      if (bottomlist[index].toString().isNotEmpty) {
                        toplist[cnt] = bottomlist[index];
                        checkbottomlist[index] = bottomlist[index];
                        flutterTts0.speak("${bottomlist[index]}");
                        bottomlist[index] = "";
                        cnt++;
                        win();
                      }
                    });
                  },
                  child: Container(
                    height: bodyheight * 0.05,
                    margin: EdgeInsets.all(bodyheight * 0.01),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0x66B3B2B2)),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x66B3B2B2),
                              blurRadius: 2,
                              spreadRadius: 5,
                              offset: Offset(1, 0))
                        ]),
                    child: Center(
                        child: Text(
                      "${bottomlist[index]}",
                      style: TextStyle(fontSize: bodyheight * 0.03),
                    )),
                  ),
                );
              },
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
            ),
          ),
          Container(
            height: bodyheight * 0.10,
            width: bodyheight * 0.20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(color: Color(0x66B3B2B2)),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x66B3B2B2),
                            blurRadius: 2,
                            spreadRadius: 5,
                            offset: Offset(1, 0))
                      ]),
                  child: Icon(
                    Icons.lightbulb,
                    color: Colors.white,
                    size: bodyheight * 0.05,
                  ),
                ),
                InkWell(
                  onTap: () {
                    showAnimatedDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          actions: [
                            Container(
                              height: bodyheight * 0.06,
                              width: twidth,
                              decoration: BoxDecoration(
                                  // color: Colors.red,
                                  boxShadow: [
                                BoxShadow(
                                    color: Color(0xFD0E010E),
                                    blurRadius: 2,
                                    spreadRadius: 2,
                                    offset: Offset(2, 2)),
                              ]),
                              child: Center(
                                child: Text(
                                  "Remove Extra Letters",
                                  style: TextStyle(fontSize: bodyheight * 0.04,color: Colors.white),
                                ),
                              ),
                            ),
                            Container(
                              height: bodyheight * 0.20,
                              // decoration: BoxDecoration(color: Colors.yellow),
                              child: Center(
                                child: Text(
                                  "Delete Some Letters Which are Not Part of the Solutions...Are your Sure Delete...!!!",
                                  style: TextStyle(fontSize: bodyheight * 0.03),
                                ),
                              ),
                            ),
                            Container(
                              height: bodyheight * 0.10,
                              // decoration: BoxDecoration(color: Colors.green),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(onTap: () {
                                    Navigator.of(context).pop();
                                    setState(() {

                                      bottomlist=List.from(answerlist);
                                      bottomlist.shuffle();
                                      win();

                                    });
                                  },
                                    child: Container(
                                      margin: EdgeInsets.all(bodyheight*0.02),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                        Radius.circular(bodyheight * 0.01)),
                                          boxShadow: [
                                        BoxShadow(
                                            color: Color(0x66B3B2B2),
                                            blurRadius: 2,
                                            spreadRadius: 2,
                                            offset: Offset(2, 2)),
                                      ]),
                                      child: Text(
                                        "Yes",
                                        style: TextStyle(
                                            fontSize: bodyheight * 0.04,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  InkWell(onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                    child: Container(
                                      margin: EdgeInsets.all(bodyheight*0.02),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.all(
                                          Radius.circular(bodyheight * 0.01)),
                                          boxShadow: [
                                        BoxShadow(
                                            color: Color(0x66B3B2B2),
                                            blurRadius: 2,
                                            spreadRadius: 2,
                                            offset: Offset(2, 2)),
                                      ]),
                                      child: Text(
                                        "No",
                                        style: TextStyle(
                                            fontSize: bodyheight * 0.04,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            )
                          ],
                        );
                      },
                      animationType: DialogTransitionType.slideFromBottomFade,
                      curve: Curves.fastOutSlowIn,
                      duration: Duration(seconds: 1),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border.all(color: Color(0x66B3B2B2)),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x66B3B2B2),
                              blurRadius: 2,
                              spreadRadius: 5,
                              offset: Offset(1, 0))
                        ]),
                    child: Icon(
                      Icons.close_sharp,
                      color: Colors.white,
                      size: bodyheight * 0.05,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void win() {
    if (listEquals(toplist, answerlist) == true) {
      setState(() {
        win1 = true;
        msg = "Win.....";
        print("=====${answerlist}");
        voice();
        Navigator.push(context, MaterialPageRoute(builder: (context) {

            return first1();
        },)) ;
      });
    }
  }

  bool win1 = false;
  String msg = "";
  FlutterTts flutterTts0 = FlutterTts();
  List answer = [];

  void voice() {
    flutterTts0.speak("${spelling}");
  }

}
