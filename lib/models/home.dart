import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:converchat/models/Food.dart';
import 'package:converchat/models/chat.dart';
import 'package:converchat/models/fooDetails.dart';
import 'package:converchat/models/signIn.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:converchat/service/auth.dart';
import 'package:converchat/service/data.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return homeState();
  }
}

class homeState extends State<home> {
  String url = '';
  File? file;
  UploadTask? task;
  final Auth _auth = Auth();
  datab database = datab();
  String name = '';
  String image = '';
  bool fav = false;

  //*******************Current user name */

  //All useeers *************
  final Stream<QuerySnapshot> users = FirebaseFirestore.instance
      .collection('users')
      .where('id', isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  final Stream<QuerySnapshot> food =
      FirebaseFirestore.instance.collection('food').snapshots();

  @override
  void initState() {
    super.initState();
    getCurUser();
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : ' No File';
    // TODO: implement build
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,

              /*ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            height: 2,
            width: 2,
            child: Image.asset('assets/logo1.png'),
          ),
        ),*/

              elevation: 10,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 119, 8, 0),
                    Color.fromARGB(255, 241, 153, 146)
                  ], begin: Alignment.centerLeft),
                ),
              ),
              title: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(backgroundImage: NetworkImage(image)),
                      Positioned(
                        right: 1,
                        bottom: 0,
                        child: Container(
                            height: 13,
                            width: 13,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 1,
                                color: Color.fromARGB(255, 119, 8, 0),
                              ),
                              color: Colors.green,
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(name)
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () async {
                    selectFile();
                    print(fileName);
                  },
                  icon: Icon(Icons.search),
                ),
                IconButton(
                  onPressed: () async {
                    register();
                  },
                  icon: Icon(Icons.add_a_photo),
                ),
                IconButton(
                  onPressed: () async {
                    await _auth.signOut();
                    print('Signed out !');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => signIn()),
                    );
                  },
                  icon: const Icon(Icons.logout),
                ),
              ],
              bottom: const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.chat_bubble),
                  ),
                  Tab(
                    icon: Icon(Icons.favorite),
                  )
                ],
              )),
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 253, 213, 210),
              Color.fromARGB(255, 109, 30, 24),
              Colors.black
            ])),
            child: TabBarView(children: [
              StreamBuilder<QuerySnapshot>(
                  stream: users,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(color: Colors.red),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error');
                    }
                    final data = snapshot.data!;
                    return ListView.builder(
                        padding: EdgeInsets.only(top: 2),
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: data.size,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 65,
                            child: Card(
                              color: Colors.white,
                              elevation: 0,
                              margin: EdgeInsets.all(1),
                              child: ListTile(
                                mouseCursor: MaterialStateMouseCursor.clickable,
                                hoverColor: Colors.red,
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => chat(
                                      name: data.docs[index]['name'],
                                      profile: data.docs[index]['profile'],
                                      con: data.docs[index]['con'],
                                      userName: name,
                                    ),
                                  ),
                                ),
                                leading: Stack(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          data.docs[index]['profile']),
                                      radius: 20,
                                    ),
                                    if (data.docs[index]['con'])
                                      Positioned(
                                        right: 1,
                                        bottom: 0,
                                        child: Container(
                                          height: 10,
                                          width: 10,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.white),
                                              color: Colors.green,
                                              shape: BoxShape.circle),
                                        ),
                                      )
                                  ],
                                ),
                                title: Text(data.docs[index]['name']),
                                //subtitle: Text(data.docs[index]['friends']['id']),
                              ),
                            ),
                          );
                        });
                  }),
              /*ListView.builder(
                itemCount: ListF.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                    title: Text(ListF[index].name),
                    trailing: Text('${ListF[index].price}'),
                  ));
                },
              ),*/

              StreamBuilder<QuerySnapshot>(
                stream: food,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Food List is Empty !!'));
                  } else if (snapshot.hasData) {
                    final foods = snapshot.data!;
                    print('food----------------');
                    print(foods);

                    return GridView.builder(
                      primary: false,
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      padding: EdgeInsets.all(15),
                      itemCount: foods.size,
                      itemBuilder: (context, index) {
                        SizedBox(
                          height: 500,
                        );
                        return InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => foodDetails(
                                name: foods.docs[index]['name'],
                                Bool: foods.docs[index]['bool'],
                                pic: foods.docs[index]['pic'],
                                price: foods.docs[index]['price'],
                                disc: foods.docs[index]['disc'],
                              ),
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 5,
                                  )
                                ]),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    foods.docs[index]['bool']
                                        ? SizedBox(
                                            height: 25,
                                            child: IconButton(
                                                iconSize: 20,
                                                onPressed: () {
                                                  fav = true;
                                                  print(fav);
                                                },
                                                icon: Icon(
                                                  Icons.favorite,
                                                  color: Color.fromARGB(
                                                      255, 226, 74, 63),
                                                )),
                                          )
                                        : SizedBox(
                                            height: 25,
                                            child: IconButton(
                                                iconSize: 20,
                                                onPressed: () => fav = false,
                                                icon: Icon(Icons.favorite,
                                                    color: Colors.white)),
                                          )
                                  ],
                                ),
                                Center(
                                  child: Container(
                                    height: 80,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(80),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              foods.docs[index]['pic'])),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${foods.docs[index]['price']} Dhs',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFFCC8053)),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  foods.docs[index]['name'],
                                  style: GoogleFonts.varela(
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),

                          /* title: Text(
                                foods.docs[index]['name'],
                              ),*/
                        );
                      },
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 300,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.red),
                    );
                  }
                },
              )
            ]),
          ),
        ),
      ),
    );
  }

  Widget buildFood(Food food) => ListTile(
        title: Text(food.name),
        subtitle: Text('${food.price}'),
      );
  getCurUser() async {
    final curUser = await FirebaseAuth.instance.currentUser;
    if (curUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(curUser.uid)
          .get()
          .then((e) {
        setState(() {
          name = e.data()!['name'];
          image = e.data()!['profile'];
        });
      });
      print(name);
      print(image);
    } else {
      print('Current User Null');
    }
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    print('file!');
    setState(() {
      file = File(path);
    });
  }

  Future uploadFile() async {
    if (file == null) return;
    final fileName = basename(file!.path);
    final destination = 'files/$fileName';
    addFileFirebase(destination, file!);
  }

  static UploadTask? addFileFirebase(String destination, File file) {
    try {
      print(file);
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      print('rror file');

      return null;
    }
  }

  Future fileget() async {
    final fileName = basename(file!.path);
    final destination = 'files/$fileName';
    task = addFileFirebase(destination, file!);
    if (task == null) return 'NULLL';
    final snapshot = await task!.whenComplete(() => null);

    setState(() {
      print(url);
      url = snapshot.ref.getDownloadURL() as String;
    });
  }

  Future storyget() async {
    final fileName = basename(file!.path);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child('files/$fileName');
    String fileUrl = await ref.getDownloadURL();
    setState(() {
      url = fileUrl;
    });
  }

  Future register() => showDialog(
      context: this.context,
      builder: (context) => AlertDialog(
            backgroundColor: Color.fromARGB(255, 253, 220, 218),
            title: Text('Register Now '),
            content: Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 60),
                width: 400,
                height: 150,
                child: Column(
                  children: [
                    ElevatedButton(
                        onPressed: selectFile, child: Text('Select File')),
                    Text(file != null ? basename(file!.path) : ' No File'),
                    ElevatedButton(
                        onPressed: uploadFile, child: Text('Upload File')),
                  ],
                )),
          ));
}
