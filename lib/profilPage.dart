
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class HalamanProfil extends StatelessWidget {
  const HalamanProfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileScreen(
        actions: [
          SignedOutAction(
            (context) {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}