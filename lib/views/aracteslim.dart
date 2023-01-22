import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:rentacar/model/araba.dart';
import 'package:rentacar/model/user.dart';
import 'package:rentacar/widgets/my_elevated_button.dart';

enum Actions2 { update }

class aracteslim extends StatefulWidget {
  final UserModel user;

  final TextEditingController plakactrl;
  const aracteslim({super.key, required this.user, required this.plakactrl});

  @override
  State<aracteslim> createState() => _aracteslimState();
}

class _aracteslimState extends State<aracteslim> {
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  var difference = 0;
  var df = 2;
  double fiyat = 0;
  double sfiyat = 0;
  String id = "";
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  @override
  void initState() {
    super.initState();
  }

  late DateTime date;

  Future<void> teslim() async {
    var response = await FirebaseFirestore.instance
        .collection("islem")
        .where("plaka", isEqualTo: widget.plakactrl.text)
        .orderBy("bitarih", descending: true)
        .limit(1)
        .get();
    if (response.docs.isNotEmpty) {
      Timestamp bitarih2 = response.docs[0].data()['bitarih'];
      fiyat = response.docs[0].data()['fiyat'];

      var parselananTarih = bitarih2.toDate();

      int timestampInSeconds = bitarih2.seconds; //bitarih['_second'];
      int timestampInNanoseconds = 0;
      date = DateTime.fromMillisecondsSinceEpoch(
          timestampInSeconds * 1000 + timestampInNanoseconds ~/ 1000000);
    }
  }

  Future<void> set() async {
    var response = await FirebaseFirestore.instance
        .collection("islem")
        .where("plaka", isEqualTo: widget.plakactrl.text)
        .where("tc", isEqualTo: widget.user.tc)
        .get();
    if (response.docs.isNotEmpty) {
      id = response.docs.first.id.toString();
    } else {
      Get.defaultDialog(
          title: "Araç Teslim",
          middleText: "Kayıt Bulunamadı",
          textConfirm: "Onayla",
          confirmTextColor: Colors.white,
          onConfirm: () {
            /*Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => aracteslim(
                          user: widget.user,
                          plakactrl: widget.plakactrl,
                        )));*/
            Get.back();
          });
    }
  }

  Widget build(BuildContext context) {
    final CollectionReference db = _database.collection('islem');

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(
                label: Text("Plaka"),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
              controller: widget.plakactrl,
            ),
            SizedBox(
              height: 50,
            ),
            MyElevatedButton(
                child: Text("Teslim Et"),
                color: Colors.blue,
                onPressed: () {
                  teslim();
                  set();
                  difference = date.difference(DateTime.now()).inDays;

                  if (difference <= 0) {
                    difference = (difference).abs();
                    sfiyat = fiyat + fiyat * 1.5 * difference;
                    print((fiyat * difference).toString());
                    Map<String, dynamic?> updatecarprice = {
                      fiyat.toString(): sfiyat,
                    };

                    Get.defaultDialog(
                        title: "Araç Tesliminde Gecikme",
                        middleText:
                            "Toplam $difference gün geciktirdiniz Borcunuz: $sfiyat",
                        textConfirm: "Onayla",
                        confirmTextColor: Colors.white,
                        onConfirm: () async {
                          await db.doc(id).update({'fiyat': sfiyat});
                          Get.back();
                          Get.back();
                        });
                  } else {
                    sfiyat = fiyat * difference;
                    Get.defaultDialog(
                        title: "Araç Teslim",
                        middleText: "Aracı başarıyla teslim ettiniz.",
                        textConfirm: "Onayla",
                        confirmTextColor: Colors.white,
                        onConfirm: () async {
                          Get.back();
                          Get.back();
                        });
                  }
                })
          ],
        ),
      ),
    );
  }
}
