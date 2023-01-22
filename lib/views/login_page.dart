import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:rentacar/model/user.dart';
import 'package:rentacar/services/auth.dart';
import 'package:rentacar/views/araba_genelbakis.dart';
import 'package:rentacar/views/aracteslim.dart';
import 'package:rentacar/views/homepage.dart';
import 'package:rentacar/views/register_page.dart';
import 'package:rentacar/widgets/my_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController plakactrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Giriş Sayfası"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Lottie.asset('assets/animations/66238-car-rent.json'),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: TextFormField(
                decoration: InputDecoration(
                    label: Text("Kullanıcı Adı"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
                controller: usernameCtrl,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: TextFormField(
                decoration: InputDecoration(
                    label: Text("Şifre"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
                controller: passwordCtrl,
                obscureText: true,
              ),
            ),
            MyElevatedButton(
                child: Text("Giriş"),
                color: Colors.blue,
                onPressed: () async {
                  if (usernameCtrl.text.isNotEmpty &&
                      passwordCtrl.text.isNotEmpty) {
                    var response = await FirebaseFirestore.instance
                        .collection("kullanici")
                        .where("username", isEqualTo: usernameCtrl.text)
                        .where("password", isEqualTo: passwordCtrl.text)
                        .limit(1)
                        .get();
                    if (response.docs.isNotEmpty) {
                      var c = Get.put(Auth(), permanent: true);

                      //await c.arabalar();
                      final kullanici = UserModel(
                          username: response.docs[0].data()['username'],
                          email: response.docs[0].data()['email'],
                          password: response.docs[0].data()['password'],
                          tc: response.docs[0].data()['tc'],
                          tel: response.docs[0].data()['tel']);
                      print(kullanici);
                      Get.offAll(() => HomePage(
                            user: kullanici,
                            plakactrl: plakactrl,
                          ));
                    } else {
                      Get.defaultDialog(
                          title: "Girilen Bilgiler Doğru Değildir!",
                          middleText:
                              "Lütfen Kullanıcı Adı veya Şifrenizi Doğru Giriniz!",
                          titleStyle: TextStyle(fontSize: 20),
                          textConfirm: "Tamam",
                          confirmTextColor: Colors.amber,
                          onConfirm: () async {
                            Get.back();
                          });
                    }
                  } else {
                    Get.defaultDialog(
                        title: "Girilen Bilgiler Boştur!",
                        middleText: "Lütfen Tüm Alanları Doldurunuz!",
                        titleStyle: TextStyle(fontSize: 20),
                        textConfirm: "Tamam",
                        confirmTextColor: Colors.amber,
                        onConfirm: () async {
                          Get.back();
                        });
                  }
                }),
            MyElevatedButton(
                child: Text("Kullanıcı Kayıt"),
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterPage(
                                usernameCtrl: usernameCtrl,
                                passwordCtrl: passwordCtrl,
                                emailCtrl: TextEditingController(),
                                telCtrl: TextEditingController(),
                                tcCtrl: TextEditingController(),
                                action: Actions1.register,
                              )));
                })
          ],
        ),
      ),
    );
  }
}
