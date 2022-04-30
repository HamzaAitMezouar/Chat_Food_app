import 'package:converchat/models/home.dart';
import 'package:converchat/models/signIn.dart';
import 'package:converchat/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:converchat/theme.dart';
import 'package:provider/provider.dart';

import '../service/auth.dart';
import 'Clip.dart';

class info extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 114, 21, 14),
              Color.fromARGB(255, 238, 137, 129),
              Color.fromRGBO(255, 255, 255, 1),
            ], begin: Alignment.bottomCenter),
          ),
          child: Column(children: [
            SizedBox(
              height: 150,
            ),
            Center(
              child: CircleAvatar(
                radius: 120,
                backgroundImage: AssetImage('assets/logo1.png'),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            const SizedBox(
              height: 90,
              width: 300,
              child: Text(
                'Enjoy a new experience talking about food ',
                style: TextStyle(
                  color: Color.fromARGB(255, 66, 4, 0),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 3,
              child: Text("Click Skip to Start"),
            ),
            TextButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Skip'),
                  Icon(
                    (Icons.arrow_right),
                  ),
                ],
              ),
              onPressed: () {
                final user = Provider.of<User?>(context, listen: false);
                print(user);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => signIn()),
                );
              },
            ),
            /* ClipPath(
                child: Container(
                  height: 50,
                  color: Color.fromARGB(255, 109, 0, 0),
                  width: double.infinity,
                ),
                clipper: clipInf(),
              ),*/
          ]),
        ),
      ),
    );
  }
}
