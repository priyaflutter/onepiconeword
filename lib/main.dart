import 'package:flutter/material.dart';

import 'first.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: first1(),
  ));
}

class first1 extends StatefulWidget {
  @override
  State<first1> createState() => _first1State();
}

class _first1State extends State<first1> {
  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;
    double twidth = MediaQuery.of(context).size.width;
    double tappbar = kToolbarHeight;
    double tstatusbar = MediaQuery.of(context).padding.top;
    double navigatorbar = MediaQuery.of(context).padding.bottom;

    double bodyheight = theight - tstatusbar - navigatorbar;

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: bodyheight * 0.07,
            width: twidth,
            decoration: BoxDecoration(color: Color(0xff1d0223)),
            child: Row(
              children: [
                Text(
                  "1 PIC 1 WORD",
                  style: TextStyle(color: Colors.white,fontSize: bodyheight*0.03),
                ),
                SizedBox(width: twidth*0.45),
                Icon(Icons.lock, color: Colors.white,size: bodyheight*0.05),
                Container(
                    height: bodyheight * 0.05,
                    child: Image(image: AssetImage("Images/calendar.png"),fit: BoxFit.fill,)),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return onepic();
                },
              ));
            },
            child: Container(
              height: bodyheight * 0.20,
              width: twidth,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("Images/croup_1.png"),
                      fit: BoxFit.fill)),
              child: Stack(
                children: [
                  Container(
                    height: bodyheight*0.03,
                    width: twidth,
                    child: Image(
                      image: AssetImage("Images/game_top.png"),
                      fit: BoxFit.fill,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
