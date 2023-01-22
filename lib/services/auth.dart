import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:rentacar/model/araba.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rentacar/model/user.dart';

class Auth extends GetxController {
  var arabaList = [].obs;
  var userList = [].obs;
  var sirketList = [].obs;
  Araba_Detay? araba;
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> arabalar() async {
    arabaList.assignAll([]);
    var result = await FirebaseFirestore.instance.collection("araba").get();
    Future.forEach(result.docs, (element) async {
      var sirket = await sirketByAraba(element.data()["sirket"]);
      element.data()["logo"] = sirket["logo"] ?? "";
      element.data()["sirket_adi"] = sirket["adi"] ?? "";
      var arabaModel = Araba_Detay.fromJson(element.data());
      arabaModel.sirket_adi = sirket["adi"];
      arabaModel.logo = sirket["logo"];
      arabaList.add(arabaModel);
    });
  }

  Future<void> kullanicilar() async {
    var result = await FirebaseFirestore.instance.collection("kullanici").get();
    result.docs.forEach((element) {
      userList.add(UserModel.fromJson(element.data()));
    });
  }

  Future<void> sirketler() async {
    var result = await FirebaseFirestore.instance.collection("sirket").get();
    result.docs.forEach((element) {
      sirketList.add(UserModel.fromJson(element.data()));
    });
  }

  Future sirketByAraba(String araba) async {
    var result = await FirebaseFirestore.instance
        .collection("sirket")
        .where("sirket_id", isEqualTo: araba)
        .get();

    return result.docs.first.data();
  }

  Future<User?> signInAnonymously() async {
    final userCredentials = await _firebaseAuth.signInAnonymously();
    return userCredentials.user;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Stream<User?> authStatus() {
    return _firebaseAuth.authStateChanges();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    kullanicilar();
    arabalar();
    super.onInit();
  }
}
