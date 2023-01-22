import 'package:firebase_auth/firebase_auth.dart';
import 'package:rentacar/model/kayit.dart';
import 'package:rentacar/model/user.dart';
import 'package:rentacar/model/utils.dart';
import 'package:flutter/material.dart';
import 'package:rentacar/services/auth.dart';
import 'package:rentacar/views/DateTimePicker.dart';
import 'package:rentacar/widgets/specific.dart';
import 'package:rentacar/model/araba.dart';
import 'package:rentacar/widgets/my_elevated_button.dart';

class Araba_DetayPage extends StatelessWidget {
  final Araba_Detay araba;
  final UserModel user;

  Araba_DetayPage({required this.araba, required this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
              onPressed: null,
              icon: Icon(Icons.bookmark,
                  size: 30, color: Theme.of(context).accentColor)),
          IconButton(onPressed: null, icon: Icon(Icons.share, size: 30)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              araba.marka,
              style: MainHeading,
            ),
            Text(
              araba.model,
              style: BasicHeading,
            ),
            Hero(
                tag: araba.marka,
                child: Image.asset(
                  "assets/images/${araba.resim}",
                  height: 232,
                  width: 400,
                )),
            SizedBox(
              height: 30,
            ),
            Text(
              'ÖZELLİKLER',
              style: TextStyle(
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    //padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0, 0),
                          blurRadius: 10.0,
                          spreadRadius: 5.0,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Vites Türü ",
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Text(
                          "${araba.vites}".toUpperCase(),
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color.fromARGB(255, 201, 124, 124),
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                        Text(
                          "Yakıt",
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Text(
                          "${araba.yakit}".toUpperCase(),
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color.fromARGB(255, 201, 124, 124),
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                        Text(
                          "Depozito",
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Text(
                          "${araba.depozito}",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color.fromARGB(255, 201, 124, 124),
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    //padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0, 0),
                          blurRadius: 10.0,
                          spreadRadius: 5.0,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Günlük KM Sınırı",
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Text(
                          "${araba.g_km}",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color.fromARGB(255, 201, 124, 124),
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                        Text(
                          "Sınıf",
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Text(
                          "${araba.sinif}".toUpperCase(),
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color.fromARGB(255, 201, 124, 124),
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                        Text(
                          "Plaka",
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Text(
                          "${araba.plaka}",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color.fromARGB(255, 201, 124, 124),
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 130),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0, 0),
                          blurRadius: 10.0,
                          spreadRadius: 5.0,
                        )
                      ],
                    ),
                    child: Column(children: [
                      Text(
                        "Günlük Kiralama Ücreti",
                        style: TextStyle(
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        "${araba.fiyat} TL",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color.fromARGB(255, 201, 124, 124),
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ]),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0, 0),
                          blurRadius: 10.0,
                          spreadRadius: 5.0,
                        )
                      ],
                    ),
                    child: Center(
                        child: Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DateTimePicker(
                                              araba: Araba_Detay(
                                                  arabaid: araba.arabaid,
                                                  marka: araba.marka,
                                                  model: araba.model,
                                                  vites: araba.vites,
                                                  depozito: araba.depozito,
                                                  sinif: araba.sinif,
                                                  yakit: araba.yakit,
                                                  g_km: araba.g_km,
                                                  fiyat: araba.fiyat,
                                                  resim: araba.resim,
                                                  plaka: araba.plaka,
                                                  logo: araba.logo,
                                                  sirket: araba.sirket),
                                              user: UserModel(
                                                  username: user.username,
                                                  email: user.email,
                                                  password: user.password,
                                                  tc: user.tc,
                                                  tel: user.tel))));
                                },
                                child: Text("Kirala"),
                                style: ButtonStyle(
                                    overlayColor:
                                        MaterialStateProperty.all(Colors.amber),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.grey),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.all(10)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            side: BorderSide(
                                                color: Colors.amber))))))),
                  ),
                ],
              ),
            ]),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
