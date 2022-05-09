import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_tts/flutter_tts.dart';

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
  List abcdlist=[];
  int cnt = 0;
  int rtu = 0;
  String abcd="";
  late Uint8List audiobytes;

  AudioPlayer player = AudioPlayer();

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

    spelling = imagepath.split("/")[1].split("\.")[0].toUpperCase(); // apple
    print(spelling);

    answerlist = spelling.split(""); // [a, p, p, l, e]
    print(answerlist);

    toplist = List.filled(answerlist.length, ""); // [, , , , ]
    print(toplist);

    // String abcd = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    abcd = "abcdefghijklmnopqrstuvwxyz".toUpperCase();

    abcdlist = abcd.split(
        ""); //[a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z]
    print(abcdlist);

    abcdlist.shuffle(); //[b, n, h, k, j, z, p, s, i, q, r, m, y, l, f, c, w, a, u, e, t, o, v, g, x, d]
    print(abcdlist);

    bottomlist=abcdlist.getRange(0, 10-answerlist.length).toList();

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
                      alignment: Alignment.center,
                       margin: EdgeInsets.all(bodyheight*0.02),
                      // margin: EdgeInsets.fromLTRB(bodyheight * 0.05,
                      //     bodyheight * 0.02, bodyheight * 0.05, 0),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
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
                                  color: ans,
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
                                style: TextStyle(
                                  fontSize: bodyheight * 0.03,
                                  // decoration: TextDecoration.lineThrough
                                ),
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
                        checkbottomlist[index] = bottomlist[index];
                        for (cnt = 0; cnt < toplist.length; cnt++) {
                          if (toplist[cnt] == "") {
                            toplist[cnt] = bottomlist[index];
                            flutterTts0.speak("${bottomlist[index]}");
                            bottomlist[index] = "";
                            cnt++;
                            win();

                          }
                        }
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
                InkWell(
                  onTap: () {
                    showAnimatedDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return Stack(
                          children: [
                            AlertDialog(
                            backgroundColor: Color(0xf8010410),
                            actions: [
                              Container(
                                height: bodyheight * 0.10,
                                width: twidth,
                                margin: EdgeInsets.all(bodyheight * 0.01),
                                decoration: BoxDecoration(
                                  // color: Color(0xf8010410),
                                  image: DecorationImage(
                                      image:
                                      AssetImage("Images/dialog_heading.png"),
                                      fit: BoxFit.fill),
                                  // color: Colors.red,
                                ),
                                child: Center(
                                  child: Text(
                                    "HINT",
                                    style: TextStyle(
                                        fontSize: bodyheight * 0.04,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: ()   {

                                // await Future.delayed(Duration(seconds: 3)).then((value){
                                //   int result = await player.playBytes(audiobytes);
                                //   player.playBytes(audiobytes);
                                // });




                                },
                                child: Container(
                                  height: bodyheight * 0.10,
                                  margin: EdgeInsets.all(bodyheight * 0.01),
                                  width: twidth,
                                  decoration: BoxDecoration(
                                      color: Color(0xffd5baba),
                                      borderRadius: BorderRadius.circular(
                                          bodyheight * 0.01)),
                                  // decoration: BoxDecoration(color: Colors.yellow),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.yellow),
                                        child: Icon(
                                          Icons.hearing,
                                          size: bodyheight * 0.04,
                                        ),
                                      ),
                                      Text(
                                        "WORD PRONOUNCE",
                                        style: TextStyle(
                                            fontSize: bodyheight * 0.03,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  height: bodyheight * 0.10,
                                  margin: EdgeInsets.all(bodyheight * 0.01),
                                  width: twidth,
                                  decoration: BoxDecoration(
                                      color: Color(0xffd5baba),
                                      borderRadius: BorderRadius.circular(
                                          bodyheight * 0.01)),
                                  // decoration: BoxDecoration(color: Colors.yellow),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.yellow),
                                        child: Icon(
                                          Icons.record_voice_over,
                                          size: bodyheight * 0.04,
                                        ),
                                      ),
                                      Text(
                                        "LETTER PRONOUNCE",
                                        style: TextStyle(
                                            fontSize: bodyheight * 0.03,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  height: bodyheight * 0.10,
                                  margin: EdgeInsets.all(bodyheight * 0.01),
                                  width: twidth,
                                  decoration: BoxDecoration(
                                      color: Color(0xffd5baba),
                                      borderRadius: BorderRadius.circular(
                                          bodyheight * 0.01)),
                                  // decoration: BoxDecoration(color: Colors.yellow),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.yellow),
                                        child: Icon(
                                          Icons.spellcheck,
                                          size: bodyheight * 0.04,
                                        ),
                                      ),
                                      Text(
                                        " RANDOM LETTER      ",
                                        style: TextStyle(
                                            fontSize: bodyheight * 0.03,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                            Positioned(
                              top: 170,
                              right: 30,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: CircleAvatar(
                                    radius: 14.0,
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.close, color: Colors.red),
                                  ),
                                ),
                              ),
                            ),

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
                                  style: TextStyle(
                                      fontSize: bodyheight * 0.04,
                                      color: Colors.white),
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
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      setState(() {

                                        // bottomlist= List.from(answerlist);
                                        // bottomlist.shuffle();
                                        // win();

                                        removelist = abcdlist.getRange(0, 10-answerlist.length).toList();
                                        for(int i=0;i<removelist.length;i++)
                                          {
                                            int pending=bottomlist.indexOf(removelist[i]);
                                            bottomlist[pending]="";
                                          }
                                        
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(bodyheight * 0.02),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  bodyheight * 0.01)),
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
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(bodyheight * 0.02),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  bodyheight * 0.01)),
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
        ans = Colors.green;
        win1 = true;
        speak();
        msg = "Win.....";
        print("=====${answerlist}");
        sound();

        Future.delayed(Duration(seconds: 2)).then((value) {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return onepic();
            },
          ));
        });
      });
    }
    // else{
    //
    //     if(toplist.isNotEmpty)
    //       {
    //
    //         if(toplist.toString() !=answerlist.toString())
    //           {
    //             setState(() {
    //               msg="try again";
    //             });
    //           }
    //       }
    // }
  }

  Color ans = Colors.white;
  bool win1 = false;
  String msg = "";
  FlutterTts flutterTts0 = FlutterTts();
  List answer = [];
  List removelist=[];

  void speak() {
    flutterTts0.speak("${spelling}");
  }

  Future<void> sound() async {

    String audioasset = "audio/totcoisou.wav";
    ByteData bytes = await rootBundle.load(audioasset); //load audio from assets
    Uint8List audiobytes = bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    player.playBytes(audiobytes);
  }




}
