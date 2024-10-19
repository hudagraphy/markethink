import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markethink/addAgenda.dart';
import 'package:markethink/beranda.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(textTheme: GoogleFonts.latoTextTheme()),
        home: InputAgenda() //Beranda(),
        );
  }
}
