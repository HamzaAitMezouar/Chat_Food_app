import 'package:flutter/material.dart';

class clip extends CustomClipper<Path> {
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height / 2);
    path.cubicTo(size.width / 4, 3 * (size.height / 3), 3 * (size.width / 4),
        size.height / 2, size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class clipInf extends CustomClipper<Path> {
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height / 2);
    path.quadraticBezierTo(
        size.height, size.width / 8, size.height / 2, size.width / 8);
    path.cubicTo(size.width / 4, 3 * (size.height / 3), 3 * (size.width / 4),
        size.height / 2, size.width, size.height);
    path.lineTo(0, size.height / 8);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
