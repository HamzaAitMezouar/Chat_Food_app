import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:converchat/models/userMod.dart';
import 'package:provider/provider.dart';

import '../models/Food.dart';

class datab {
  String? uid;
  datab([this.uid]);
  CollectionReference userCol = FirebaseFirestore.instance.collection('users');
  Stream collectionStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  Future getDb() async {
    await userCol.get().then((value) {
      for (var element in value.docs) {
        print(element.data());
        print('*****************************************');
      }
    });
  }

  Stream<List<userMod>> getuserModel() {
    print('TEEEEST');
    print(FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (doc) => userMod.fromJson(
                doc.data(),
              ),
            )
            .toList()));
    return FirebaseFirestore.instance.collection('users').snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => userMod.fromJson(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  CollectionReference foodCol = FirebaseFirestore.instance.collection('food');
  /*Future getFood() async {
    List listF = [];
    try {
      await foodCol.get().then((value) => value.docs.forEach((element) {
            listF.add(element.data());
          }));
      print('listF DATAAA');
      print(listF);
    } catch (e) {
      e.toString();
    }

    return listF;
  }*/

  Stream<List<Food>> getfood() =>
      FirebaseFirestore.instance.collection('food').snapshots().map(
            (snapshot) => snapshot.docs.map((doc) {
              print('Food.fromJson(doc.data())');
              print(doc.data());
              print(Food.fromJson(
                doc.data(),
              ));
              return Food.fromJson(
                doc.data(),
              );
            }).toList(),
          );
}
