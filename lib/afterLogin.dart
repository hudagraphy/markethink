import 'package:flutter/material.dart';
import 'package:markethink/beranda.dart';

class AfterLogin extends StatelessWidget {
  const AfterLogin({super.key});

  @override
  Widget build(BuildContext context) {
    double lebarLayar = MediaQuery.of(context).size.width;
    double tinggiLayar = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: NavigasiBar(lebarLayar: lebarLayar),
      extendBody: true,
      body: Beranda(),
    );
  }
}