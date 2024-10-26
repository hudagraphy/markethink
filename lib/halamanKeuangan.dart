import 'package:flutter/material.dart';
import 'package:markethink/beranda.dart';

class HalamanKeuangan extends StatelessWidget {
  const HalamanKeuangan ({super.key});

  @override
  Widget build(BuildContext context) {
    double lebarLayar = MediaQuery.of(context).size.width;
    double tinggiLayar = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          //NavBar
          Center(child: Text('Halaman Keuangan'),)
        ],
      ),
    );
  }
}
