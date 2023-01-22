import 'package:rentacar/model/user.dart';
import 'package:rentacar/model/utils.dart';
import 'package:flutter/material.dart';
import 'package:rentacar/widgets/grid.dart';

class araba_genelbakis extends StatelessWidget {
  final UserModel user;

  const araba_genelbakis({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1000,
        title: Text('RENT A CAR', style: SubHeading),
      ),
      body: Card(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Arabalar',
              style: MainHeading,
            ),
          ),
          Expanded(
            child: grid(
              user: user,
            ),
          ),
        ],
      )),
    );
  }
}
