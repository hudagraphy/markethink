import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

Future tambahAgenda(Map<String, dynamic> dataAgenda, String idAgenda) {
  var db = FirebaseFirestore.instance;
  CollectionReference agenda = db.collection('agenda');
  return db.collection('agenda').doc(idAgenda).set(dataAgenda).onError(
        (error, stackTrace) => print('Gagal input agenda : $error'),
      );
}

Future ambilDataAgenda({required String userAkun, String dokumen = 'all'}) {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference agenda = db.collection('agenda');

  final hasil = agenda.where('personelBAM', arrayContains: userAkun).orderBy('waktuBerangkatAgenda').get().then((value) {
    return value.docs;
  },);
  return hasil;
}

Future ambilDataKotaKab(String filePath) async {
  String jsonString = await rootBundle.loadString(filePath);
  return json.decode(jsonString);
}
