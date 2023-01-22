import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:rentacar/model/user.dart';
import 'package:rentacar/model/utils.dart';
import 'package:flutter/material.dart';
import '../model/araba.dart';
import 'package:rentacar/views/araba_detay.dart';
import 'package:rentacar/services/auth.dart';

class grid extends StatelessWidget {
  final UserModel user;

  const grid({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    String sirket_id = "";
    String sirket_adi = "";

    var c = Get.find<Auth>();

    //var u = Get.find<Auth>();
    return Card(
      child: Obx(
        () => GridView.builder(
          itemCount: c.arabaList.length,
          itemBuilder: (context, i) {
            print(c.arabaList[i].sirket_adi);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          Araba_DetayPage(araba: c.arabaList[i], user: user)));
                },
                child: Container(
                    decoration:
                        BoxDecoration(color: Colors.grey.shade400, boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        spreadRadius: 2.5,
                      )
                    ]),
                    child: Column(
                      children: [
                        Text(
                          c.arabaList[i].marka,
                          style: MainHeading,
                        ),
                        Text(
                          c.arabaList[i].model,
                          style: SubHeading,
                        ),
                        Card(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/${c.arabaList[i].resim}",
                              height: 90,
                              width: 150,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    "assets/images/${c.arabaList[i].logo}",
                                    height: 25,
                                    width: 40,
                                    alignment: Alignment.topLeft,
                                  ),
                                  Text(
                                    "${c.arabaList[i].sirket_adi}\nRent A Car",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  )
                                ])
                          ],
                        )),
                        SizedBox(
                          height: 8,
                        )
                      ],
                    )),
              ),
            );
          },
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        ),
      ),
    );
  }
}
