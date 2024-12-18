import 'dart:convert';
import 'dart:io';

import 'package:easy_stepper/easy_stepper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:markethink/beranda.dart';
import 'package:markethink/dbFirebase.dart';
import 'package:markethink/methods.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:uuid/uuid.dart';

class InputAgenda extends StatefulWidget {
  const InputAgenda({
    super.key,
    this.isEdit = false,
    this.dataAgenda = const{}
  });

  final bool isEdit;
  final Map<String, dynamic> dataAgenda;

  @override
  State<InputAgenda> createState() => _InputAgendaState();
}

class _InputAgendaState extends State<InputAgenda> {
  //index Step form
  int step = 1;

  //data form dropdown *next ganti dengan API
  List<String> opsiJenisAgenda = ["Roadshow", "Expo", "Presentasi", "Rapat"];
  List<String> dataKendaraan = [
    "Luxio BAM",
    "Avanza",
    "Innova",
    "Ambulance",
    "Pick Up"
        "Hi Ace",
    "Bus",
        "Kendaraan Pribadi"
  ];
  Map<String, dynamic> hasilForm = {};

  //kunciForm tambah Agenda
  final _kunciForm = GlobalKey<FormBuilderState>();

  //inisiasi data dropdown kotaKab
  List<String> kotaKabAgenda = [];
  List<String> personelBAM = [];
  List<String> personelDosenTendik = [];

  //fungsi bantuan untuk simpan data ke variabel isi data dropdown
  Future fetchDataDropdown() async {
    final tempDataKotaKab = await ambilDataJSON('assets/kotaKab.json', 'name');
    kotaKabAgenda = tempDataKotaKab;
    final tempDataPersonelBam = await ambilDataJSON(
        'assets/personel.json', 'namaPersonel',
        filter: 'statusPersonel', where: 'Personel BAM');
    personelBAM = tempDataPersonelBam;
    final tempDataDosenTendik = await ambilDataJSON(
        'assets/personel.json', 'namaPersonel',
        filter: 'statusPersonel', where: 'Non BAM');
    personelDosenTendik = tempDataDosenTendik;
  }

  

  //init state untuk memanggil fungsi fectdata dropdown
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDataDropdown();
    
    
  }

  @override
  Widget build(BuildContext context) {
    double lebarLayar = MediaQuery.of(context).size.width;
    double tinggiLayar = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FormBuilder(
        key: _kunciForm,
        child: Stack(
          children: [
            //background form, jika dkilik dialog muncul untuk menutup form
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Center(
                        child: Container(
                          height: 110,
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.symmetric(
                              horizontal: lebarLayar <= 720
                                  ? (5 / 100 * lebarLayar)
                                  : (25 / 100 * lebarLayar)),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Ga sido yo?',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    'Iyo ga sido',
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Opacity(
                opacity: 0.1,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            //konten Form Utama
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: lebarLayar <= 720
                        ? (5 / 100 * lebarLayar)
                        : (25 / 100 * lebarLayar)),
                clipBehavior: Clip.hardEdge,
                height: 460,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Stack(
                  children: [
                    //tombol tombol
                    Row(
                      children: [
                        //tombol balik
                        Visibility(
                          visible: step > 1,
                          child: Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() {
                                step--;
                              }),
                              child: Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    "Balik",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //tombol lanjut
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              hasilForm = _kunciForm.currentState!.value;
                              print(hasilForm);
                              if (_kunciForm.currentState?.saveAndValidate() ==
                                  true) {
                                    //jika kondisi wdiget.agenda ada (edit state) maka..
                                    if (widget.dataAgenda["jenisAgenda"] != null) {
                                      //isi data initial untuk edit kotaKabAgenda, personelBAM, personel
                                      _kunciForm.currentState?.setInternalFieldValue('kotaKabAgenda', List<String>.from(widget.dataAgenda['kotaKabAgenda']));
                                      _kunciForm.currentState?.setInternalFieldValue('personelBAM', List<String>.from(widget.dataAgenda['personelBAM']));
                                      //cek apabila personelDosenTendik kosong (karena opsional)
                                     if (widget.dataAgenda['personelDosenTendik'] != null) {
                                        _kunciForm.currentState?.setInternalFieldValue('personelDosenTendik', List<String>.from(widget.dataAgenda['personelDosenTendik']));
                                     }
                                     if (widget.dataAgenda['kendaraanAgenda'] != null) {
                                        _kunciForm.currentState?.setInternalFieldValue('kendaraanAgenda', List<String>.from(widget.dataAgenda['kendaraanAgenda']));
                                     }
                                    //simpan pada _kunciForm
                                    _kunciForm.currentState?.save();
                                    }
                                //data sementara sambil nunggu field aman
                                _kunciForm.currentState?.setInternalFieldValue(
                                    'pinLocation',
                                    '-7.521917643849493, 110.22655455772104');
                                _kunciForm.currentState?.setInternalFieldValue(
                                    'berkasAgenda',
                                    'https://drive.google.com/open?id=1PBnYQZ1VupTTgA4Zy6lQ90Wte3NZJARy&usp=drive_fs');
                                step++;
                                if (step == 7) {
                                  //jika kondisi edit update maka
                                  if(widget.dataAgenda['jenisAgenda'] != null){
                                    //update berdasarkkan id document
                                    await tambahAgenda(hasilForm,
                                      "${widget.dataAgenda['idDokumen']}");
                                  }else{
                                    await tambahAgenda(hasilForm,
                                      "${hasilForm['jenisAgenda']}_${Uuid().v1().substring(0, 13)}");
                                  }
                                  
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  setState(() {});
                                }
                              }

                              setState(() {

                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                              ),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  step == 6 ? "Simpen" : "Lanjut",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    //form input
                    Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(bottom: 70),//kasih jarak agar tombol di stack bawahnya keliatan
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 30,
                          )
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minHeight: 390),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //Step 1
                              Visibility(
                                visible: step == 1,
                                child: Column(
                                  children: [
                                    //jenis Agenda660
                                    FormBuilderDropdown<String>(
                                      name: "jenisAgenda",
                                      initialValue: widget.dataAgenda['jenisAgenda'],
                                      decoration: PengaturanDekorasiField(
                                          hintText: "Jenis Agenda"),
                                      validator: FormBuilderValidators.required(
                                          errorText: 'Wajib diisi leh'),
                                      items: opsiJenisAgenda
                                          .map((e) => DropdownMenuItem(
                                                //alignment: AlignmentDirectional.center,
                                                value: e,
                                                child: Text(e),
                                              ))
                                          .toList(),
                                    ),
                                    SizedBox(height: 20),
                                    //field Taju Acara
                                    FormBuilderTextField(
                                      name: 'tajukAgenda',
                                      initialValue: widget.dataAgenda['tajukAgenda'],
                                      decoration: PengaturanDekorasiField(
                                          hintText: 'Tajuk Agenda'),
                                      validator: FormBuilderValidators.required(
                                          errorText:
                                              'Agenda apaan, mosok kagak ada nama acaranya'),
                                    ),
                                    SizedBox(height: 20),
                                    //fieldMangkate
                                    FormBuilderDateTimePicker(
                                      name: "waktuBerangkatAgenda",
                                      initialValue: widget.dataAgenda['waktuBerangkatAgenda']?.toDate(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2030, 12, 31),
                                      validator: FormBuilderValidators.required(
                                          errorText: 'Harus ada tanggalnya woy'),
                                      decoration: PengaturanDekorasiField(
                                        hintText: "Mangkate?",
                                      ),
                                      onChanged: (value) => setState(() {
                                        _kunciForm.currentState?.saveAndValidate();
                                      }),
                                    ),
                                    SizedBox(height: 20),
                                    //field Balikke?
                                    Visibility(
                                      visible: (_kunciForm.currentState
                                              ?.value['waktuBerangkatAgenda'] !=
                                          null) || (widget.dataAgenda["waktuPulangAgenda"] != null) ,
                                      child: FormBuilderDateTimePicker(
                                        initialValue: widget.dataAgenda['waktuPulangAgenda']?.toDate(),
                                        name: "waktuPulangAgenda",
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2024, 12, 31),
                                        decoration: PengaturanDekorasiField(
                                            hintText: "Balikke?"),
                                      ),
                                    ),
                                    //
                                  ],
                                ),
                              ),
                              //Step 2
                              Visibility(
                                visible: step == 2,
                                child: Column(
                                  children: [
                                    //wilayah Agenda
                                    DropdownMultiple(
                                      fieldName: "kotaKabAgenda",
                                      kunciForm: _kunciForm,
                                      isiDropdown: kotaKabAgenda,
                                      hintText: "*Ningdi?",
                                      isWajib: true,
                                      selectedItems: _kunciForm.currentState
                                              ?.value['kotaKabAgenda'] ??
                                          [],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    //detil Lokasi
                                    FormBuilderTextField(
                                      name: "detilLokasiAgenda",
                                      initialValue: widget.dataAgenda['detilLokasiAgenda'],
                                      validator: FormBuilderValidators.required(),
                                      decoration: PengaturanDekorasiField(
                                          hintText: "*Detail Lokasi"),
                                    ),
                                    //pinPicker
                                  ],
                                ),
                              ),
                              //Step 3
                              Visibility(
                                visible: step == 3,
                                child: Column(
                                  children: [
                                    //personelBAM
                                    DropdownMultiple(
                                      fieldName: "personelBAM",
                                      kunciForm: _kunciForm,
                                      isiDropdown: personelBAM,
                                      hintText: "*Personel BAM",
                                      isWajib: true,
                                      selectedItems: _kunciForm
                                              .currentState?.value['personelBAM'] ??
                                          [],
                                    ),
                                    SizedBox(height: 20),
                                    //personelDosenTendik
                                    DropdownMultiple(
                                      fieldName: "personelDosenTendik",
                                      kunciForm: _kunciForm,
                                      isiDropdown: personelDosenTendik,
                                      hintText: "Personel Dosen/Tendik",
                                      selectedItems: _kunciForm.currentState
                                              ?.value['personelDosenTendik'] ??
                                          [],
                                    ),
                                    SizedBox(height: 20),
                                    //personelLainnya
                                    FormBuilderTextField(
                                      name: "personelTambahanAgenda",
                                      initialValue: widget.dataAgenda['personelTambahangAgenda'],
                                      decoration: PengaturanDekorasiField(
                                          hintText: "Personel Lainnya"),
                                    )
                                  ],
                                ),
                              ), //step 4
                              //step 4
                              Visibility(
                                visible: step == 4,
                                child: Column(
                                  children: [
                                    //field Kendaraan
                                    DropdownMultiple(
                                      fieldName: 'kendaraanAgenda',
                                      kunciForm: _kunciForm,
                                      hintText: 'Numpak Opo?',
                                      isiDropdown: dataKendaraan,
                                      selectedItems: _kunciForm.currentState
                                              ?.value['kendaraanAgenda'] ??
                                          [],
                                    ),
                                    SizedBox(height: 20),
                                    //suratpinjam kendaraan
                                    FormBuilderSwitch(
                                      name: 'suratPinjamKendaraan',
                                      initialValue: widget.dataAgenda['suratPinjamKendaraan'] ?? false,
                                      title: Text(
                                        'Butuh pinjam kendaraan?',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      activeColor: Colors.blue,
                                      decoration: PengaturanDekorasiField(
                                          hintText: "hintText"),
                                    ),
                                    SizedBox(height: 20),
                                    //Surat tugas
                                    FormBuilderSwitch(
                                      name: 'suratTugasAgenda',
                                      initialValue: widget.dataAgenda['suratTugasAgenda'] ?? false,
                                      title: Text(
                                        'Butuh surat tugas?',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      activeColor: Colors.blue,
                                      decoration: PengaturanDekorasiField(
                                          hintText: "hintText"),
                                    )
                                  ],
                                ),
                              ),
                              //step 5
                              Visibility(
                                visible: step == 5,
                                child: Column(
                                  children: [
                                    //notes
                                    FormBuilderTextField(
                                      name: 'notesAgenda',
                                      initialValue: widget.dataAgenda['notesAgenda'],
                                      decoration: PengaturanDekorasiField(
                                          hintText: 'Catatan (kalo ada)'),
                                      maxLines: 5,
                                      onChanged: (value) {
                                        _kunciForm.currentState?.saveAndValidate();
                                      },
                                    ),
                                    SizedBox(height: 20),
                                    //filePicker
                                    // FormBuilderFilePicker(
                                    //   name: 'berkasPendukungAgenda',
                                    //   typeSelectors: [
                                    //     TypeSelector(
                                    //       type: FileType.any,
                                    //       selector: Row(
                                    //         children: [
                                    //           Icon(Icons.add_circle_rounded),
                                    //           Text('Tambah Berkas Pendukung')
                                    //         ],
                                    //       ),
                                    //     ),
                                    //   ],
                                    //   allowCompression: true,
                                    //   previewImages: false,
                                    //   decoration: PengaturanDekorasiField(
                                    //       hintText: 'Berkas Pendukung'),
                                    // )
                                  ],
                                ),
                              ),
                              //preview Agenda
                              Visibility(
                                visible: step == 6,
                                child: CardViewAgenda(
                                  hasilForm: hasilForm,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration PengaturanDekorasiField({
    required String hintText,
  }) {
    return InputDecoration(
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
        alignLabelWithHint: true,
        contentPadding: EdgeInsets.all(20),
        hintText: hintText,
        hintStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black26,
        ),
        fillColor: Colors.blue.shade50,
        filled: true);
  }
}

class CardViewAgenda extends StatelessWidget {
  const CardViewAgenda({super.key, required this.hasilForm});

  final Map<String, dynamic> hasilForm;

  @override
  Widget build(BuildContext context) {
    DateTime waktuBerangkatAgenda;
    hasilForm['waktuBerangkatAgenda'] is! DateTime
        ? waktuBerangkatAgenda = hasilForm['waktuBerangkatAgenda'].toDate()
        : waktuBerangkatAgenda = hasilForm['waktuBerangkatAgenda'];
    String sisaHari = countDownAgenda(waktuBerangkatAgenda);
    return Container(
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //kolom waktu
            Container(
              height: 340,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //pulangnya
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          sisaHari,
                          style: TextStyle(
                            fontSize: switch (sisaHari) {
                              'Besok' => 14,
                              'Sekarang' => 12,
                              'Hari ini' => 12,
                              _=> 22
                            },
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        ),
                        Text(
                          'hari lagi',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  //berangkat
                  Container(
                    child: Column(
                      children: [
                        Text(
                          DateFormat.EEEE().format(waktuBerangkatAgenda),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        //tanggal berangkat
                        Text(
                          DateFormat.d().format(waktuBerangkatAgenda),
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                        //bulan berangkat
                        Text(
                          DateFormat.MMMM().format(waktuBerangkatAgenda),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                          ),
                        ),
                        //tahun berangkat
                        Text(
                          DateFormat.y().format(waktuBerangkatAgenda),
                          style: TextStyle(fontSize: 12, color: Colors.blue),
                        ),
                        //jam event
                        Text(
                          DateFormat.Hm().format(waktuBerangkatAgenda),
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            VerticalDivider(
              width: 20,
              thickness: 1,
              indent: 10,
              endIndent: 0,
              color: Colors.blue,
            ),
            //kolom detil
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //jenisAgenda
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        "#${hasilForm['jenisAgenda']}",
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ),
                    ),
                    //main title
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        '${hasilForm['tajukAgenda']}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black87),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: IconTextKecil(
                        isiIkon: Icons.location_on_rounded,
                        isiText: hasilForm['kotaKabAgenda'].join(', '),
                      ),
                    ),
                    //detil Lokasi
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: IconTextKecil(
                          isiIkon: Icons.location_city_rounded,
                          isiText: '${hasilForm['detilLokasiAgenda'] ?? '-'}'),
                    ),
                    //personelBAM
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: IconTextKecil(
                          isiIkon: Icons.diversity_3_rounded,
                          isiText: '${hasilForm['personelBAM'].join(', ')}'),
                    ),
                    //personelDosenTendik
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: IconTextKecil(
                          isiIkon: Icons.group_rounded,
                          isiText:
                              '${hasilForm['personelDosenTendik']?.join(', ') ?? '-'}'),
                    ),
                    //personelTambahan
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: IconTextKecil(
                          isiIkon: Icons.person_add_rounded,
                          isiText:
                              '${hasilForm['personelTambahanAgenda'] ?? '-'}'),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: IconTextKecil(
                          isiIkon: Icons.directions_car_filled_rounded,
                          isiText:
                              '${hasilForm['kendaraanAgenda']?.join(', ') ?? 'Tanpa Kendaraan'}'),
                    ),
                    //notesAgenda
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: IconTextKecil(
                        isiIkon: Icons.draw_rounded,
                        isiText: "${hasilForm['notesAgenda'] ?? '-'}",
                      ),
                    ),
                    Row(
                      children: [
                        //SPPD
                        Container(
                          margin: EdgeInsets.only(bottom: 10, right: 15),
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: hasilForm['suratTugasAgenda']
                                ? Colors.blue
                                : Colors.grey,
                            child: Text(
                              "SPPD",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 7,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        //Kendaraan
                        Container(
                          margin: EdgeInsets.only(bottom: 10, right: 15),
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: hasilForm['suratPinjamKendaraan']
                                ? Colors.blue
                                : Colors.grey,
                            child: Icon(
                              Icons.directions_car_filled_sharp,
                              size: 12,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                        //file
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.task_rounded,
                              size: 12,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DropdownMultiple extends StatelessWidget {
  const DropdownMultiple(
      {super.key,
      required this.isiDropdown,
      required this.hintText,
      required this.kunciForm,
      required this.fieldName,
      required this.selectedItems,
      this.isWajib = false,
      this.isSingle = false});

  final List<String> isiDropdown;
  final String hintText;
  final bool isSingle;
  final GlobalKey<FormBuilderState> kunciForm;
  final String fieldName;
  final List<String> selectedItems;
  final bool isWajib;

  @override
  Widget build(BuildContext context) {
    return MultiDropdown<String>(
      items: isiDropdown
          .map(
            (e) => DropdownItem(
              value: e,
              label: e,
              selected: selectedItems.contains(e),
            ),
          )
          .toList(),
      fieldDecoration: FieldDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        borderRadius: 30,
        padding: EdgeInsets.all(25),
        animateSuffixIcon: true,
        backgroundColor: Colors.blue.shade50,
        hintText: hintText,
        hintStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black26,
        ),
      ),
      dropdownDecoration: DropdownDecoration(
        backgroundColor: Colors.white,
        borderRadius: BorderRadius.circular(30),
        maxHeight: 300
      ),
      searchDecoration: SearchFieldDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        hintText: "Golekki wae",
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      chipDecoration: ChipDecoration(
          backgroundColor: Colors.amber,
          borderRadius: BorderRadius.circular(10),
          labelStyle: TextStyle(fontSize: 12),
          wrap: true),
      searchEnabled: true,
      singleSelect: isSingle,
      onSelectionChange: (selectedItems) {
        kunciForm.currentState?.setInternalFieldValue(fieldName, selectedItems);
      },
      validator: (selectedOptions) {
        if ((selectedOptions == null || selectedOptions.isEmpty) && isWajib) {
          return 'Iki wajib leh!';
        }
        return null;
      },
    );
  }
}
