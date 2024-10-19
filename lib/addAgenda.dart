import 'package:easy_stepper/easy_stepper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:markethink/beranda.dart';
import 'package:markethink/dbFirebase.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class InputAgenda extends StatefulWidget {
  const InputAgenda({super.key});

  @override
  State<InputAgenda> createState() => _InputAgendaState();
}

class _InputAgendaState extends State<InputAgenda> {
  int step = 1;
  List<String> opsiJenisAgenda = ["Roadshow", "Expo", "Presentasi", "Rapat"];
  List<String> wilayahAgenda = [
    "Kota Magelang",
    "Kabupaten Magelang",
    "Kabupaten Temanggung",
    "Kabupaten Wonosobo",
    "Kabupaten Purworejo",
    "Kabupaten Kebumen"
  ];
  List<String> personalBAM = ["Huda", "Pungki", "Zafir", "Bapang"];
  List<String> dataDosenTendik = ["Tuessi", "Zuhron", "Yudi", "Lilik"];
  List<String> dataKendaraan = [
    "Luxio BAM",
    "Avanza",
    "Innova",
    "Ambulance",
    "Hi Ace",
    "Kendaraan Pribadi"
  ];
  Map<String, dynamic> hasilForm = {};

  final controlllerPeta = MapController.withPosition(
      initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324));

  final _kunciForm = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    double lebarLayar = MediaQuery.of(context).size.width;
    double tinggiLayar = MediaQuery.of(context).size.height;
    return Scaffold(
      body: FormBuilder(
        key: _kunciForm,
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: lebarLayar <= 720
                  ? (5 / 100 * lebarLayar)
                  : (25 / 100 * lebarLayar)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //title
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                  child: Text("Agenda Baru"),
                ),
                //mainForm
                Container(
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
                              onTap: () async{
                                await tambahAgenda(hasilForm);
                                setState((){
                                hasilForm = _kunciForm.currentState!.value;
                                if (_kunciForm.currentState
                                        ?.saveAndValidate() ==
                                    true) {
                                  step++;
                                 
                                  
                                }
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
                        height: 390,
                        padding: EdgeInsets.all(20),
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
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2030, 12, 31),
                                    validator: FormBuilderValidators.required(
                                        errorText: 'Harus ada tanggalnya woy'),
                                    decoration: PengaturanDekorasiField(
                                      hintText: "Mangkate?",
                                    ),
                                    onChanged: (value) => setState(() {
                                      _kunciForm.currentState
                                          ?.saveAndValidate();
                                    }),
                                  ),
                                  SizedBox(height: 20),
                                  //field Balikke?
                                  Visibility(
                                    visible: _kunciForm.currentState
                                            ?.value['waktuBerangkatAgenda'] !=
                                        null,
                                    child: FormBuilderDateTimePicker(
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
                                    isiDropdown: wilayahAgenda,
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
                                    isiDropdown: personalBAM,
                                    hintText: "Personel BAM",
                                    isWajib: true,
                                    selectedItems: _kunciForm.currentState
                                            ?.value['personelBAM'] ??
                                        [],
                                  ),
                                  SizedBox(height: 20),
                                  //personelDosenTendik
                                  DropdownMultiple(
                                    fieldName: "personelDosenTendik",
                                    kunciForm: _kunciForm,
                                    isiDropdown: dataDosenTendik,
                                    hintText: "Personel Dosen/Tendik",
                                    selectedItems: _kunciForm.currentState
                                            ?.value['personelDosenTendik'] ??
                                        [],
                                  ),
                                  SizedBox(height: 20),
                                  //personelLainnya
                                  FormBuilderTextField(
                                    name: "personelTambahanAgenda",
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
                                    initialValue: false,
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
                                    initialValue: false,
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
                    ],
                  ),
                ),
              ],
            ),
          ),
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
                          "2",
                          style: TextStyle(
                            fontSize: 26,
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
                          "Event",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        //tanggal berangkat
                        Text(
                          DateFormat.d()
                              .format(hasilForm['waktuBerangkatAgenda']),
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                        //bulan berangkat
                        Text(
                          DateFormat.MMMM()
                              .format(hasilForm['waktuBerangkatAgenda']),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                          ),
                        ),
                        //tahun berangkat
                        Text(
                          DateFormat.y()
                              .format(hasilForm['waktuBerangkatAgenda']),
                          style: TextStyle(fontSize: 12, color: Colors.blue),
                        ),
                        //jam event
                        Text(
                          DateFormat.Hm()
                              .format(hasilForm['waktuBerangkatAgenda']),
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
      this.isWajib = false});

  final List<String> isiDropdown;
  final String hintText;

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
          wrap: true),
      searchEnabled: true,
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
