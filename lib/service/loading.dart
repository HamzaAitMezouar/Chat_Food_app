import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(255, 248, 126, 118),
        Color.fromARGB(255, 250, 229, 227),
      ])),
      child: Center(
          child: SpinKitCircle(
        color: Color.fromARGB(255, 126, 10, 1),
        size: 50,
      )),
    );
  }
}
