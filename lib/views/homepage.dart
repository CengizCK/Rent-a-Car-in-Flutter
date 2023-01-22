import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentacar/model/araba.dart';
import 'package:rentacar/model/user.dart';
import 'package:rentacar/services/auth.dart';
import 'package:rentacar/views/araba_genelbakis.dart';
import 'package:rentacar/views/aracteslim.dart';
import 'package:rentacar/views/login_page.dart';
import 'package:rentacar/views/register_page.dart';
import 'package:rentacar/widgets/my_elevated_button.dart';

class HomePage extends StatefulWidget {
  final UserModel user;

  final TextEditingController plakactrl;

  const HomePage({super.key, required this.user, required this.plakactrl});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  @override
  Future<void> kayitsil() async {
    var response = await FirebaseFirestore.instance
        .collection("kullanici")
        .where("email", isEqualTo: widget.user.email)
        .get();
    print(response.docs);
    if (response.docs.isNotEmpty) {
      await _database
          .collection('kullanici')
          .doc(response.docs.first.id)
          .delete();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RENT A CAR"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyElevatedButton(
                  child: Text("Araç Kirala"),
                  color: Colors.blue,
                  onPressed: () async {
                    await Get.find<Auth>().arabalar();
                    Get.to(() => araba_genelbakis(
                          user: widget.user,
                        ));
                  }),
              SizedBox(
                height: 20,
              ),
              MyElevatedButton(
                  child: Text("Araç Teslim"),
                  color: Colors.blue,
                  onPressed: () {
                    Get.to(() => aracteslim(
                          user: widget.user,
                          plakactrl: widget.plakactrl,
                        ));
                  }),
              SizedBox(
                height: 20,
              ),
              MyElevatedButton(
                  child: Text("Hesap Silme"),
                  color: Colors.blue,
                  onPressed: () {
                    Get.defaultDialog(
                        title: "Hesabınız Silinecektir!",
                        middleText:
                            "Hesabınızı Silmek üzeresiniz Onayla butonuna tıklarsanız hesabınız silinecektir.",
                        textConfirm: "Onayla",
                        confirmTextColor: Colors.white,
                        onConfirm: () {
                          kayitsil();
                          Get.offAll(() => LoginPage());
                          Get.offAll(() => LoginPage());
                        });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
