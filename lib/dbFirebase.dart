import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

Future tambahAgenda(Map<String, dynamic> dataAgenda, String idAgenda) {
  var db = FirebaseFirestore.instance;
  //CollectionReference agenda = db.collection('agenda');
  return db.collection('agenda').doc(idAgenda).set(dataAgenda).onError(
        (error, stackTrace) => print('Gagal input agenda : $error'),
      );
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

Future hapusAgenda(String idAgenda) async{
  //koneksi ke firestore
  var db = FirebaseFirestore.instance;
  return db.collection('agenda').doc(idAgenda).delete().whenComplete(() => true,).onError((error, stackTrace) => false,);
}

Future<List<Map<String, dynamic>>> ambilDataAgenda() async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference agenda = db.collection('agenda');

  List<Map<String, dynamic>> hasil = [];

  await agenda
      .where('waktuBerangkatAgenda', isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime.now().subtract(Duration(hours: 6))))
      .orderBy('waktuBerangkatAgenda')
      .get()
      .then(
    (QuerySnapshot value) {
      value.docs.forEach(
        (dokumen) {
          var tempDataHasil = dokumen.data() as Map<String, dynamic>; //simpan sementara hasil ke variabel
          tempDataHasil['idDokumen'] = dokumen.id; //menambahkan id dokumen ke hasil
          hasil.add(tempDataHasil);
          
        },
      );
    },
  );
  
  return hasil;
}
