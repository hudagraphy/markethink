import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class InputAgenda extends StatefulWidget {
  const InputAgenda({super.key});

  @override
  State<InputAgenda> createState() => _InputAgendaState();
}

class _InputAgendaState extends State<InputAgenda> {
  int step = 1;
  List<String> opsiJenisAgenda = ["Roadshow", "Expo", "Presentasi", "Rapat"];

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
                              onTap: () => setState(() {step++; debugPrint(step.toString());}),
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
                                    items: opsiJenisAgenda.map((e) => DropdownMenuItem(
                                      //alignment: AlignmentDirectional.center,
                                      value: e,
                                      child: Text(e),
                                    )).toList(),
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
                                    decoration: PengaturanDekorasiField(hintText: "Balikke?"),
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
                                 
                                ],
                              ),
                            ),
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
        hintStyle: TextStyle(fontWeight: FontWeight.bold, ),
        fillColor: Colors.blue.shade50,
        filled: true);
  }
}
