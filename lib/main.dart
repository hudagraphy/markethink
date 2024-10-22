import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markethink/addAgenda.dart';
import 'package:markethink/beranda.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:markethink/loginPage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            textTheme: GoogleFonts.latoTextTheme(),
            inputDecorationTheme: InputDecorationTheme(
              alignLabelWithHint: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.amber)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.amber)),
              contentPadding: EdgeInsets.all(20),
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black26,
              ),
              suffixIconColor: Colors.blue,
              fillColor: Colors.blue.shade50,
              filled: true,
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
                padding: WidgetStatePropertyAll(EdgeInsets.all(20)),
                backgroundColor: WidgetStatePropertyAll(Colors.blue),
                foregroundColor: WidgetStatePropertyAll(Colors.white),
                side: WidgetStatePropertyAll(
                  BorderSide(color: Colors.blue),
                ),
              ),
            )),
        // routes: {
        //   '/' : (context) => Beranda(),
        //   '/login' : (context) => SignInScreen(
        //     providers: [
        //       EmailAuthProvider(),

        //     ],
        //   )
        // },
        home: HalamanLogin());
  }
}
