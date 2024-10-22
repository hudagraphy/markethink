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

  final hasil = agenda
      .where('personelBAM', arrayContains: userAkun)
      .orderBy('waktuBerangkatAgenda')
      .get()
      .then(
    (value) {
      return value.docs;
    },
  );
  return hasil;
}

Future ambilDataJSON(String filePath, String param,
    {String filter = 'no', String where = 'no'}) async {
  String jsonString = await rootBundle.loadString(filePath);
  if (filter == 'no') {
    return jsonDecode(jsonString)
        .map<String>((e) => e[param] as String)
        .toList();
  } else {
    return jsonDecode(jsonString)
        .where((data) => data[filter] == where)
        .map<String>((e) => e[param] as String)
        .toList();
  }
}
