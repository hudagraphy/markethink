import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:markethink/beranda.dart';
import 'package:markethink/viewAllAgenda.dart';

class HalamanLogin extends StatelessWidget {
  const HalamanLogin({super.key});

  @override
  Widget build(BuildContext context) {
    double lebarLayar = MediaQuery.of(context).size.width;
    double tinggiLayar = MediaQuery.of(context).size.height;
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            showAuthActionSwitch: false,
            showPasswordVisibilityToggle: true,
            subtitleBuilder: (context, action) {
              return Text('Silakan login pake email absen kamu');
            },
            sideBuilder: (context, constraints) {
              return Container(
                child: Image.network(
                    "https://i.ibb.co.com/pzyVX8m/Asset-33-8x.png"),
              );
            },
            headerBuilder: (context, constraints, shrinkOffset) {
              return Container(
                margin: EdgeInsets.only(
                    bottom: 50, top: 150, left: 100, right: 100),
                child: Image.network(
                    "https://i.ibb.co.com/pzyVX8m/Asset-33-8x.png"),
              );
            },
            footerBuilder: (context, action) {
              return Container(
                  margin: EdgeInsets.only(top: 150),
                  child: Center(
                      child: Text(
                    'Lensakarta | Markethink v0.1.24',
                    style: TextStyle(fontSize: 10),
                  )));
            },
            styles: Set<FirebaseUIStyle>(),
            headerMaxExtent: 30 / 100 * tinggiLayar,
            providers: [
              EmailAuthProvider(),
            ],
          );
        }
        return ViewAllAgenda();
      },
    );
  }
}
