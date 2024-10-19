import 'package:cloud_firestore/cloud_firestore.dart';

Future tambahAgenda(Map<String, dynamic> hasilFormAgenda) {
  CollectionReference agenda = FirebaseFirestore.instance.collection('agenda');

  return agenda
      .add({
        'jenisAgenda': 'Expo',
        'tajukAgenda': 'Expo MBGK Konoha',
        'waktuBerangkatAgenda': DateTime.now(),
        'waktuPulangAgenda': DateTime.now(),
        'kotaKabAgenda': ['Magelang', 'Temanggung'],
      })
      .then(
        (value) => print('data Berhasil Ditambah'),
      )
      .catchError((err) => print('Gagal u=input data karena $err'));
}
