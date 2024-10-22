import 'package:flutter/material.dart';
import 'package:markethink/dbFirebase.dart';

class ViewAllAgenda extends StatelessWidget {
  const ViewAllAgenda({super.key});

  @override
  Widget build(BuildContext context) {
    double lebarLayar = MediaQuery.of(context).size.width;
    double tinggiLayar = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda Semua Tim'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        toolbarHeight: 80,
        centerTitle: true,
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5 / 100 * lebarLayar),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
      ),
    );
  }
}
