import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class HalamanProfil extends StatelessWidget {
  const HalamanProfil({super.key});

  @override
  Widget build(BuildContext context) {
    double lebarLayar = MediaQuery.of(context).size.width;
    double tinggiLayar = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.all(5),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
            ),
          ),
        ),
        body: Stack(
          children: [
            //BG
            Container(
              margin: EdgeInsets.only(top: 80),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30))),
            ),
            //mainContent
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5 / 100 * lebarLayar),
              padding: EdgeInsets.only(top: 25),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '${FirebaseAuth.instance.currentUser!.displayName}',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  SignOutButton(variant: ButtonVariant.filled,)
                ],
              ),
            )
          ],
        ));
  }
}
