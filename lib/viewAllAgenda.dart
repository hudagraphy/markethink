import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:markethink/beranda.dart';
import 'package:markethink/dbFirebase.dart';

class ViewAllAgenda extends StatelessWidget {
  const ViewAllAgenda({super.key});

  @override
  Widget build(BuildContext context) {
    double lebarLayar = MediaQuery.of(context).size.width;
    double tinggiLayar = MediaQuery.of(context).size.height;
    late String userAkun =
        FirebaseAuth.instance.currentUser?.displayName ?? 'Huda';
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5 / 100 * lebarLayar),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: FutureBuilder(
          future: ambilDataAgenda(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var agenda = snapshot.data![index];
                  return GestureDetector(
                    onTap: () async {
                      return dialogViewAgenda(context, lebarLayar, agenda);
                    },
                    child: KartuAgenda(
                        tajukAcara: agenda['tajukAgenda'],
                        waktuAcara: agenda['waktuBerangkatAgenda'].toDate(),
                        lokasiAcara: agenda['kotaKabAgenda'][0]),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('ERRRO LEH ${snapshot.error}'),
              );
            } else {
              return Center(
                child: Text('Sik ya'),
              );
            }
          },
        ),
      ),
    );
  }
}
