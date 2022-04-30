import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expandable/expandable.dart';
import 'package:lottie/lottie.dart';

class foodDetails extends StatelessWidget {
  final String name;
  final String pic;
  String price;
  bool Bool;
  String disc;
  foodDetails(
      {required this.name,
      required this.Bool,
      required this.pic,
      required this.price,
      required this.disc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color.fromARGB(255, 153, 23, 14),
        title: Text(
          name,
          style: GoogleFonts.varela(
              textStyle: TextStyle(color: Color.fromARGB(255, 163, 42, 34))),
        ),
        centerTitle: true,
        elevation: 10,
        //primary: false,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
              height: 200,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadiusDirectional.circular(50),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(pic),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              price + ' MAD ',
              style: GoogleFonts.playfairDisplay(
                textStyle: TextStyle(
                  fontSize: 22,
                  color: Color.fromARGB(255, 201, 152, 6),
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                disc,
                style: GoogleFonts.playfairDisplay(
                  textStyle: TextStyle(
                    height: 2,
                    fontSize: 22,
                    color: Color.fromARGB(255, 247, 244, 238),
                  ),
                ),
              ),
            ),
            Bool
                ? Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(8)),
                    margin: EdgeInsets.all(5),
                    elevation: 2,
                    color: Colors.white,
                    shadowColor: Color.fromARGB(255, 204, 201, 201),
                    child: ExpandablePanel(
                      theme: const ExpandableThemeData(
                          animationDuration: Duration(seconds: 2)),
                      header: Text(
                        name + ' are one of Your Favourite food',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.playfairDisplay(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 201, 152, 6),
                          ),
                        ),
                      ),
                      collapsed: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Click here for recipe',
                            style: GoogleFonts.playfairDisplay(
                              textStyle: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 109, 82, 8),
                              ),
                            ),
                          ),
                        ],
                      ),
                      expanded: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '2 eggs + water',
                                style: GoogleFonts.playfairDisplay(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 44, 33, 2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Powdered sugar',
                                style: GoogleFonts.playfairDisplay(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 44, 33, 2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Unsweetened cocoa powder',
                                style: GoogleFonts.playfairDisplay(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 44, 33, 2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Oil',
                                style: GoogleFonts.playfairDisplay(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 44, 33, 2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Vanilla Extract',
                                style: GoogleFonts.playfairDisplay(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 44, 33, 2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : Column(
                    children: [
                      Text(
                        ' seems Like you Don\'t Like ' + name,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.playfairDisplay(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 201, 152, 6),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        child: Lottie.asset('assets/sadface.json'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
