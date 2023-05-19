import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:prueba/menu.dart';
import 'package:prueba/shop.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _images = [
    "woman1.png",
    "woman2.png",
    "woman3.png",
    "woman4.png",
    "woman5.png",
    "woman6.png",
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffe87777),
      appBar: AppBar(
        backgroundColor: Color(0xffFF0000),
        centerTitle: true,
        title: Text('Tinder University',style: TextStyle(
          fontFamily: 'Tinder',
          fontSize: 24
        ),),
      ),
      endDrawer: Menu(),
      body: Center(
        child: Container(
          height: screenHeight - 218,
          child: TinderSwapCard(
            allowVerticalMovement: true,
            totalNum: _images.length,
            stackNum: 3,
            maxHeight: screenHeight * 0.9,
            maxWidth: screenWidth * 1,
            minWidth: screenWidth * 0.2,
            minHeight: screenHeight * 0.85,
            cardBuilder: (context, index) {
              return Card(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      color: Color(0xff76c9b2),
                      child: Image.asset('assets/${_images[index]}'),
                    ),
                    SizedBox(height: 0.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Icon(
                            Icons.favorite,
                            size: 58,
                            color: Colors.orange,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Icon(
                            Icons.close,
                            size: 50,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
            swipeCompleteCallback:
                (CardSwipeOrientation orientation, int index) {
              if (orientation == CardSwipeOrientation.LEFT) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text('Pass'),
                    duration: Duration(milliseconds: 200),
                  ),
                );
              } else if (orientation == CardSwipeOrientation.RIGHT) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Like'),
                    duration: Duration(milliseconds: 200),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
