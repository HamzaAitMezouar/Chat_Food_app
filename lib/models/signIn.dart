import 'package:converchat/service/auth.dart';
import 'package:converchat/service/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Clip.dart';
import 'home.dart';

class signIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return signInState();
  }
}

class signInState extends State<signIn> {
  final Auth _auth = Auth();
  final _key = GlobalKey<FormState>();

  // form
  late String _email = '';
  String _psd = '';
  String _err = '';
  bool pVisible = true;
  bool load = false;
  @override
  @override
  Widget build(BuildContext context) {
    return load
        ? loading()
        : Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      ClipPath(
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color.fromARGB(255, 95, 8, 1),
                              Color.fromARGB(255, 121, 54, 49),
                              Color.fromARGB(255, 204, 130, 130)
                            ], begin: Alignment.centerLeft),
                          ),
                          height: 300,
                          width: double.infinity,
                        ),
                        clipper: clip(),
                      ),
                      Positioned(
                        bottom: -130,
                        left: 0,
                        right: 0,
                        child: Container(
                          child: Lottie.asset(
                            'assets/food.json',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 140,
                  ),
                  Center(
                    child: Form(
                      key: _key,
                      child: Column(
                        children: [
                          email(),
                          const SizedBox(
                            height: 20,
                          ),
                          password(),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 300,
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(0),
                                primary: Color.fromARGB(255, 114, 0, 0),
                                onPrimary: Color.fromARGB(255, 204, 204, 204),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                textStyle: TextStyle(fontSize: 30),
                              ),
                              onPressed: () async {
                                if (_key.currentState!.validate()) {
                                  setState(() {
                                    load = true;
                                  });
                                  dynamic result =
                                      await _auth.signInEmail(_email, _psd);

                                  if (result == null) {
                                    setState(() {
                                      _err =
                                          'Could not sign with this Email and password  !';
                                      print(_err);
                                      load = false;
                                    });
                                  } else {
                                    setState(
                                      () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => home()),
                                        );
                                        _err = '';
                                        print(_err);
                                      },
                                    );
                                  }
                                }
                              },
                              child: Ink(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(colors: [
                                    Color.fromARGB(255, 119, 8, 0),
                                    Color.fromARGB(255, 153, 56, 49),
                                    Color.fromARGB(255, 241, 153, 146)
                                  ], begin: Alignment.centerLeft),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Container(
                                  width: 300,
                                  height: 40,
                                  child: const Text('Submit'),
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextButton(
                              onPressed: register,
                              child: const Text(
                                'Create New Account !',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 199, 158, 155),
                                ),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            _err,
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.facebook),
                        onPressed: () {},
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      IconButton(
                        icon: Icon(Icons.whatsapp),
                        onPressed: () {},
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      IconButton(
                        icon: Icon(Icons.facebook_sharp),
                        onPressed: () {},
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
  }

//-----------------------------TextField
  Widget password() {
    String val;
    return SizedBox(
      width: 300,
      child: TextFormField(
        validator: (val) => val!.isEmpty ? 'Enter a Correct Password !' : null,
        onChanged: (val) {
          setState(() {
            _psd = val;
          });
        },
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 100, 0, 0), width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          fillColor: Color.fromARGB(255, 199, 158, 155),
          filled: true,
          labelText: 'Password',
          prefixIcon: const Icon(Icons.lock),
          labelStyle: const TextStyle(
              color: Color.fromARGB(255, 121, 8, 0), fontSize: 20),
          suffixIcon: IconButton(
            onPressed: () => setState(() => pVisible = !pVisible),
            icon:
                pVisible ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 109, 0, 0), width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        obscureText: pVisible,
        keyboardType: TextInputType.visiblePassword,
      ),
    );
  }

//*************************EMAAAAIL
//******************** */ */
  Widget email() {
    return SizedBox(
      width: 300,
      child: TextFormField(
        validator: (val) => val!.isEmpty ? 'Enter a Correct Email !' : null,
        onChanged: (val) {
          setState(() {
            _email = val;
          });
        },
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 100, 0, 0), width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          fillColor: Color.fromARGB(255, 199, 158, 155),
          filled: true,
          labelText: 'Email',
          prefixIcon: Icon(Icons.email),
          labelStyle:
              TextStyle(color: Color.fromARGB(255, 121, 8, 0), fontSize: 20),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 100, 0, 0), width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

// *************************POPup*************
  Future register() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Color.fromARGB(255, 253, 220, 218),
          title: Text('Register Now '),
          content: Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 60),
            width: 400,
            height: 150,
            child: Column(
              children: [
                SizedBox(
                  height: 75,
                  child: email(),
                ),
                password()
              ],
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                  shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(7),
                    ),
                  ),
                  elevation: 5,
                  shadowColor: Color.fromARGB(255, 230, 137, 131),
                  backgroundColor: Color.fromARGB(255, 129, 21, 13)),
              onPressed: () async {
                if (_key.currentState!.validate()) {
                  dynamic result = await _auth.registerEmail(_email, _psd);

                  if (result == null) {
                    setState(() {
                      _err = 'Could not Register !';
                      print(_err);
                    });
                  } else {
                    setState(
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => home()),
                        );
                        _err = '';
                        print(_err);
                      },
                    );
                  }
                }
              },
              child: Text(
                'Register',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      );
}
