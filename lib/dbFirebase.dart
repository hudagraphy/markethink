import 'package:cloud_firestore/cloud_firestore.dart';

Future tambahAgenda(Map<String, dynamic> hasilFormAgenda) {
  CollectionReference agenda = FirebaseFirestore.instance.collection('agenda');

  return agenda
      .add(hasilFormAgenda)
      .then(
        (value) => print('data Berhasil Ditambah'),
      )
      .catchError((err) => print('Gagal u=input data karena $err'));
}

Future ambilDataAgenda() {
  CollectionReference agenda = FirebaseFirestore.instance.collection('agenda');

  return agenda.get().then(
    (hasil) {
      hasil.docs.forEach(
        (element) {
          print("${element.id} ::: ${element.data()}");
        },
      );
    },
  ).catchError((err){
    print(err);
  });
}
