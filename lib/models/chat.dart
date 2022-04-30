import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_8.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class chat extends StatefulWidget {
  final String userName;
  final String name;
  final String profile;
  final bool con;
  chat(
      {required this.name,
      required this.profile,
      required this.con,
      required this.userName});

  @override
  State<StatefulWidget> createState() {
    return chatState();
  }
}

class chatState extends State<chat> {
  CollectionReference convo = FirebaseFirestore.instance.collection('convo');
  var convoId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    convo
        .where('users', isEqualTo: {widget.userName: null, widget.name: null})
        .limit(1)
        .get()
        .then((snapshot) {
          if (snapshot.docs.isNotEmpty) {
            convoId = snapshot.docs.single.id;
          } else {
            convo.add({
              'users': {widget.userName: null, widget.name: null}
            }).then((e) => convoId = e);
          }
        })
        .catchError((e) {});
  }

  final controller = TextEditingController();
  String message = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /*bottom: PreferredSize(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  height: 50,
                  width: 100,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(profile),
                  ),
                ),
              ],
            ),
            preferredSize: Size.fromHeight(20)),*/
        titleSpacing: 0.5,
        title: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.profile),
                ),
                if (widget.con)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: Color.fromARGB(255, 243, 90, 79),
                          ),
                          color: Colors.green,
                        )),
                  )
              ],
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              widget.name,
              style: GoogleFonts.aBeeZee(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color.fromARGB(255, 5, 4, 0),
                ),
              ),
            ),
          ],
        ),
        actions: const [
          Icon(Icons.call),
          SizedBox(
            width: 7,
          ),
          Icon(Icons.video_call),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: null,
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: getTheConvo(),
          builder: (context, snapshot) {
            return Column(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: getTheConvo(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(color: Colors.red),
                        );
                      } else if (snapshot.hasError) {
                        print('SnapShot CHAT ERROR');
                        return Text('Error');
                      }
                      final data = snapshot.data!;
                      return /*ListView(
                      reverse: true,
                      children: snapshot.data!.docs.map(
                        (document) {
                          var data = document.data()!;
                          return BubbleNormal(
                            text: data.toString(),
                          );
                        },
                      ).toList(),
                    );*/
                          ListView.builder(
                              reverse: true,
                              itemCount: data.size,
                              itemBuilder: (context, index) {
                                return ChatBubble(
                                  clipper: isSender(data.docs[index]['name'])
                                      ? ChatBubbleClipper8(
                                          type: BubbleType.sendBubble)
                                      : ChatBubbleClipper8(
                                          type: BubbleType.receiverBubble),
                                  alignment: alignm(data.docs[index]['name']),
                                  backGroundColor:
                                      isSender(data.docs[index]['name'])
                                          ? Color.fromARGB(255, 141, 25, 17)
                                          : Color.fromARGB(255, 179, 178, 178),
                                  elevation: 1,
                                  shadowColor: Color.fromARGB(255, 83, 83, 83),
                                  margin: EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Container(
                                    child: Text(
                                      data.docs[index]['message'],
                                      style: GoogleFonts.varela(
                                          textStyle: TextStyle(
                                              fontSize: 15,
                                              color: Color.fromARGB(
                                                  255, 0, 0, 0))),
                                    ),
                                  ),
                                );
                              });
                    },
                  ),
                ),
                Container(
                  height: 60,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: SafeArea(
                    child: Row(
                      children: [
                        Icon(
                          Icons.mic,
                          color: Color.fromARGB(255, 243, 90, 79),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color.fromARGB(255, 243, 90, 79)
                                    .withOpacity(0.1)),
                            child: Row(children: [
                              Icon(
                                Icons.sentiment_satisfied_alt_outlined,
                                color: Color.fromARGB(255, 194, 185, 185)
                                    .withOpacity(0.4),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(child: messageForm()),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.attach_file,
                                color: Color.fromARGB(255, 194, 185, 185)
                                    .withOpacity(0.4),
                              ),
                              IconButton(
                                  onPressed: () => controller.text.isEmpty
                                      ? null
                                      : sendMessage(controller.text),
                                  icon: Icon(
                                    Icons.send,
                                    color: Color.fromARGB(255, 243, 90, 79),
                                  )),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }

  getTheConvo() => FirebaseFirestore.instance
      .collection('convo')
      .doc(convoId)
      .collection('messages')
      .orderBy('sendDate', descending: true)
      .snapshots();

  Widget messageForm() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      enableSuggestions: true,
      controller: controller,
      autocorrect: true,
      decoration: InputDecoration(
        hintText: 'Type Message ',
      ),
    );
  }

  void sendMessage(String msg) async {
    FocusScope.of(context).unfocus();
    await uploadMessage(msg);
    controller.clear();
    print(msg);
  }

  Future uploadMessage(String msg) async {
    convo.doc(convoId).collection('messages').add({
      'sendDate': FieldValue.serverTimestamp(),
      'name': widget.userName,
      'message': msg
    }).then((value) => msg = '');

    //final infUser=FirebaseFirestore.instance.collection('users');
    //await infUser.doc(name).update(UserField.)
  }

  bool isSender(String uname) {
    print(uname);
    return uname == widget.userName;
  }

  Alignment alignm(String uname) {
    if (uname == widget.userName)
      return Alignment.topRight;
    else
      return Alignment.topLeft;
  }
  /* static Stream<QuerySnapshot> showMessages(String userName, String name) =>
      FirebaseFirestore.instance
          .collection('chat/$userName/messages')
          // .orderBy('sendDate', descending: true)
          //   .where('receiveName', isEqualTo: name)
          .snapshots();
  //.map((snapshots) =>
  // snapshots.docs.map((e) => Message.fromJson(e.data())).toList());*/
}
