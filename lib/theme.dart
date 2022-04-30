import 'package:flutter/material.dart';

ThemeData dark(BuildContext context) {
  return ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(
      color: Color.fromARGB(255, 243, 90, 79),
      titleTextStyle: TextStyle(
          color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w500),
    ),
    textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Color.fromARGB(255, 194, 185, 185),
        ),
    colorScheme: ThemeData().colorScheme.copyWith(
          primary: Color.fromARGB(255, 126, 9, 1),
        ),
  );
}

ThemeData light(BuildContext context) {
  return ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(
      color: Color.fromARGB(255, 243, 90, 79),
      titleTextStyle: TextStyle(
          color: Color.fromARGB(255, 10, 3, 3),
          fontSize: 20,
          fontWeight: FontWeight.w500),
    ),
    textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Color.fromARGB(255, 3, 2, 2),
        ),
    colorScheme: ThemeData().colorScheme.copyWith(
          primary: Color.fromARGB(255, 126, 9, 1),
        ),
  );
}
