import 'package:rentacar/model/utils.dart';
import 'package:flutter/material.dart';

class specific extends StatelessWidget {
  final double fiyat1;
  final String marka1;
  final String model1;
  final String vites1;
  final String depozito1;
  final String sinif1;
  final String yakit1;
  final int g_km1;

  specific({
    required this.marka1,
    required this.model1,
    required this.fiyat1,
    required this.vites1,
    required this.depozito1,
    required this.sinif1,
    required this.yakit1,
    required this.g_km1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: fiyat1 == null ? 60 : 100,
      width: 100,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: fiyat1 == null
          ? Column(
              children: [
                Text(
                  model1,
                  style: MainHeading,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  model1,
                  style: SubHeading,
                ),
              ],
            )
          : Column(
              children: [
                Text(
                  marka1,
                  style: BasicHeading,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  fiyat1.toString(),
                  style: SubHeading,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(model1)
              ],
            ),
    );
  }
}

class specific1 extends StatelessWidget {
  final double fiyat1;
  final String marka1;
  final String model1;
  final String vites1;
  final String depozito1;
  final String sinif1;
  final String yakit1;
  final int g_km1;
  final String resim;

  specific1(
      {required this.marka1,
      required this.model1,
      required this.fiyat1,
      required this.vites1,
      required this.depozito1,
      required this.sinif1,
      required this.yakit1,
      required this.g_km1,
      required this.resim});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: fiyat1 == null ? 80 : 100,
      width: 100,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: fiyat1 == null
          ? Column(
              children: [
                Text(
                  model1,
                  style: MainHeading,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  model1,
                  style: SubHeading,
                ),
              ],
            )
          : Column(
              children: [
                Text(
                  marka1,
                  style: BasicHeading,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  fiyat1.toString(),
                  style: SubHeading,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(model1)
              ],
            ),
    );
  }
}
