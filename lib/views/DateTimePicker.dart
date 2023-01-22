import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rentacar/model/araba.dart';
import 'package:rentacar/model/kayit.dart';
import 'package:rentacar/model/user.dart';
import 'package:rentacar/views/araba_detay.dart';
import 'package:rentacar/views/araba_genelbakis.dart';
import 'package:rentacar/widgets/my_elevated_button.dart';
import 'package:firebase_core/firebase_core.dart';

enum Actions1 { arackayit }

class DateTimePicker extends StatefulWidget {
  final Araba_Detay araba;
  final UserModel user;
  final Actions1 action;
  const DateTimePicker(
      {super.key,
      required this.araba,
      required this.user,
      this.action = Actions1.arackayit});
  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  var difference = 0;
  double fiyat = 0;
  double tfiyat = 0;
  int id = 0;
  Map<DateTime, List> t = {};
  @override
  void initState() {
    super.initState();
    endDate = startDate;
    baslangic();
  }

  Future<void> baslangic() async {
    var response = await FirebaseFirestore.instance
        .collection("islem")
        .where("plaka", isEqualTo: widget.araba.plaka)
        .orderBy("bitarih", descending: true)
        .limit(1)
        .get();
    print(response.docs.first.data());
    print("metot çalıştı");
    if (response.docs.isNotEmpty) {
      Timestamp bitarih = response.docs[0].data()['bitarih'];
      //print("Bitarih ${bitarih.toDate()}");
      //DateFormat dateFormat = DateFormat('MMMM dd, yyyy at HH:mm:ss a Z');

      var parselananTarih = bitarih.toDate();
      startDate =
          DateTime.fromMillisecondsSinceEpoch(bitarih.millisecondsSinceEpoch);

      int timestampInSeconds = bitarih.seconds; //bitarih['_second'];
      int timestampInNanoseconds = 0;
      DateTime date = DateTime.fromMillisecondsSinceEpoch(
          timestampInSeconds * 1000 + timestampInNanoseconds ~/ 1000000);

      ///print(date.toString());
      //print(startDate.toString());
      startDate = date;
    } else {
      startDate = DateTime.now();
    }
  }

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Başlangıç Tarihini Seçiniz'),
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all(Colors.grey.shade400),
                  shadowColor: MaterialStateProperty.all(Colors.black),
                  overlayColor: MaterialStateProperty.all(Colors.amber),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(color: Colors.amber)))),
              onPressed: () {
                Future.delayed(Duration(seconds: 2), () {
                  baslangic();
                });

                showDatePicker(
                  context: context,
                  initialDate: startDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                ).then((pickedDate) {
                  if (pickedDate == null) return;
                  setState(() {
                    startDate = pickedDate;
                    //enddate bir gün sonrası olacak
                    endDate = startDate.add(Duration(days: 1));
                  });
                });
              },
            ),
            Text('Seçilen Başlangıç Tarihi:\n ${startDate.toString()}'),
            SizedBox(
              height: 100,
            ),
//şimdi bitiş tarihini seçelim
            ElevatedButton(
              child: Text('Bitiş Tarihini Seçiniz'),
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all(Colors.grey.shade400),
                  overlayColor: MaterialStateProperty.all(Colors.amber),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(color: Colors.amber)))),
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: endDate,
                  firstDate: endDate,
                  lastDate: DateTime(2100),
                ).then((pickedDate) {
                  if (pickedDate == null) return;
                  setState(() {
                    endDate = pickedDate;
                    difference = endDate.difference(startDate).inDays;
                    fiyat = difference * widget.araba.fiyat;
                    tfiyat = fiyat + int.parse(widget.araba.depozito);
                  });
                });
              },
            ),
            Text('Seçilen Bitiş Tarihi: \n${endDate.toString()}'),
            SizedBox(
              height: 100,
            ),
            //start ile end arasındaki farkı bulalım
            Text(
              'Toplam Kiralama Bedeli: $fiyat TL',
            ),
            Text('Günlük Fark: $difference'),
            Text('Depozito: ${widget.araba.depozito} TL'),
            Text('Toplam Ödenecek Tutar: $tfiyat TL'),
            SizedBox(height: 20),

            MyElevatedButton(
                child: Text("Kirala"),
                color: Colors.blue,
                onPressed: () async {
                  var kayit = KayitModel(
                      plaka: widget.araba.plaka,
                      email: widget.user.email,
                      marka: widget.araba.marka,
                      model: widget.araba.model,
                      tc: widget.user.tc,
                      tel: widget.user.tel,
                      musait: false,
                      bitarih: endDate,
                      btarih: startDate,
                      fiyat: fiyat);

                  if (widget.action == Actions1.arackayit) {
                    await FirebaseFirestore.instance
                        .collection("islem")
                        .add(kayit.toJson());
                  } else {
                    var response = await FirebaseFirestore.instance
                        .collection("islem")
                        .limit(1)
                        .get();
                    if (response.docs.isNotEmpty) {
                      await FirebaseFirestore.instance
                          .collection("islem")
                          .doc(response.docs.first.id)
                          .set(kayit.toJson());
                    }
                  }

                  Get.back();
                  Get.back();
                  Get.to(() => araba_genelbakis(
                        user: widget.user,
                      ));
                }),
          ],
        ),
      ),
    );
  }
}
