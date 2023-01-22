import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rentacar/model/user.dart';
import 'package:rentacar/widgets/my_elevated_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';

enum Actions1 { register, update }

class RegisterPage extends StatelessWidget {
  const RegisterPage(
      {super.key,
      required this.usernameCtrl,
      required this.passwordCtrl,
      required this.emailCtrl,
      required this.tcCtrl,
      required this.telCtrl,
      this.username = "",
      this.action = Actions1.register});

  final TextEditingController usernameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController passwordCtrl;
  final TextEditingController tcCtrl;
  final TextEditingController telCtrl;
  final Actions1 action;
  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kullanıcı Kayıt"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: TextFormField(
              decoration: InputDecoration(
                  label: Text("Kullanici Adı"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              controller: usernameCtrl,
              autofocus: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: TextFormField(
              decoration: InputDecoration(
                  label: Text("E-Mail"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              controller: emailCtrl,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: TextFormField(
              decoration: InputDecoration(
                  label: Text("Şifre"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              controller: passwordCtrl,
              obscureText: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: TextFormField(
              decoration: InputDecoration(
                  label: Text("Telefon Numarası"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              controller: telCtrl,
              keyboardType: TextInputType.number,
              maxLength: 11,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: TextFormField(
                decoration: InputDecoration(
                    label: Text("TC Kimlik"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
                controller: tcCtrl,
                keyboardType: TextInputType.number,
                maxLength: 11),
          ),
          MyElevatedButton(
              child: Text("Kullanıcı Kayıt"),
              color: Colors.red,
              onPressed: () async {
                if (usernameCtrl.text.isNotEmpty &&
                    emailCtrl.text.isNotEmpty &&
                    passwordCtrl.text.isNotEmpty &&
                    tcCtrl.text.isNotEmpty &&
                    telCtrl.text.isNotEmpty) {
                  if (EmailValidator.validate(emailCtrl.text) == true &&
                      tcCtrl.text.length == 11 &&
                      telCtrl.text.length == 11 &&
                      passwordCtrl.text.length > 8) {
                    var user = UserModel(
                        username: usernameCtrl.text,
                        email: emailCtrl.text,
                        password: passwordCtrl.text,
                        tc: tcCtrl.text,
                        tel: telCtrl.text);

                    if (action == Actions1.register) {
                      await FirebaseFirestore.instance
                          .collection("kullanici")
                          .add(user.toJson());
                    } else {
                      var response = await FirebaseFirestore.instance
                          .collection("kullanici")
                          .where("username", isEqualTo: username)
                          .limit(1)
                          .get();
                      if (response.docs.isNotEmpty) {
                        await FirebaseFirestore.instance
                            .collection("kullanici")
                            .doc(response.docs.first.id)
                            .set(user.toJson());
                      }
                    }
                    Navigator.pop(context, 'ok');
                  } else {
                    Get.defaultDialog(
                        title: "Girilen Bilgiler Doğru Formatta Değildir",
                        middleText:
                            "•E-mail example@example.com formatında olmalıdır.\n•Şifreniz 8 karakterden uzun olmalıdır.\n•Telefon ve TC kimlik numaranız 11 karakterden oluşmalıdır.",
                        titleStyle: TextStyle(fontSize: 20),
                        textConfirm: "Tamam",
                        confirmTextColor: Colors.amber,
                        onConfirm: () async {
                          Get.back();
                        });
                  }
                } else {
                  Get.defaultDialog(
                      title: "Lütfen Tüm Boşlukları Doldurunuz",
                      middleText:
                          "Kullanıcı kaydı için tüm boşlukların doldurulması gerekmektedir.",
                      titleStyle: TextStyle(fontSize: 20),
                      textConfirm: "Tamam",
                      confirmTextColor: Colors.amber,
                      onConfirm: () async {
                        Get.back();
                      });
                }
              })
        ]),
      ),
    );
  }
}
