import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class InputAgenda extends StatefulWidget {
  const InputAgenda({super.key});

  @override
  State<InputAgenda> createState() => _InputAgendaState();
}

class _InputAgendaState extends State<InputAgenda> {
  int step = 2;
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
                  height: 400,
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
                              onTap: () => setState(() {
                                step++;
                                _kunciForm.currentState?.save();
                                debugPrint(step.toString());
                                debugPrint(
                                    _kunciForm.currentState?.value.toString());
                              }),
                              child: Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    "Lanjut",
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
                        height: 330,
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
                                    items: opsiJenisAgenda
                                        .map((e) => DropdownMenuItem(
                                              //alignment: AlignmentDirectional.center,
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList(),
                                  ),
                                  SizedBox(height: 20),
                                  //fieldMangkate
                                  FormBuilderDateTimePicker(
                                    name: "waktuAgendaStart",
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2024, 12, 31),
                                    decoration: PengaturanDekorasiField(
                                      hintText: "Mangkate?",
                                    ),
                                    onChanged: (value) {
                                      _kunciForm.currentState?.save();
                                      debugPrint(_kunciForm.currentState?.value
                                          .toString());
                                      setState(() {});
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  //field Balikke?
                                  FormBuilderDateTimePicker(
                                    name: "waktuAgendaEnd",
                                    //enabled: ,
                                    firstDate: _kunciForm.currentState
                                        ?.value['waktuAgendaStart'],
                                    lastDate: DateTime(2024, 12, 31),
                                    decoration: PengaturanDekorasiField(
                                        hintText: "Balikke?"),
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
                                    fieldName: "wilayahAgenda",
                                    kunciForm: _kunciForm,
                                    isiDropdown: wilayahAgenda,
                                    hintText: "Ningdi?",
                                    selectedItems: _kunciForm.currentState
                                            ?.value['wilayahAgenda'] ??
                                        [],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  //detil Lokasi
                                  FormBuilderTextField(
                                    name: "detilLokasi",
                                    decoration: PengaturanDekorasiField(
                                        hintText: "Detail Lokasi (Nek Ono)"),
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
                                    selectedItems: _kunciForm.currentState
                                            ?.value['personelBAM'] ??
                                        [],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  //personelDosenTendik
                                  DropdownMultiple(
                                    fieldName: "personelDosenTendik",
                                    kunciForm: _kunciForm,
                                    isiDropdown: dataDosenTendik,
                                    hintText: "Personel Dosen/Tendik",
                                    selectedItems: _kunciForm.currentState
                                            ?.value['personelTendik'] ??
                                        [],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  //personelLainnya
                                  FormBuilderTextField(
                                    name: "personelLuar",
                                    decoration: PengaturanDekorasiField(
                                        hintText: "Personel Lainnya"),
                                  )
                                ],
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
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        alignLabelWithHint: true,
        contentPadding: EdgeInsets.all(25),
        hintText: hintText,
        hintStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black26,
        ),
        fillColor: Colors.blue.shade50,
        filled: true);
  }
}

class DropdownMultiple extends StatelessWidget {
  const DropdownMultiple(
      {super.key,
      required this.isiDropdown,
      required this.hintText,
      required this.kunciForm,
      required this.fieldName,
      required this.selectedItems});

  final List<String> isiDropdown;
  final String hintText;

  final GlobalKey<FormBuilderState> kunciForm;
  final String fieldName;
  final List<String> selectedItems;

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
    );
  }
}
