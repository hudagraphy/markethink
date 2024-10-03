import 'package:flutter/material.dart';

class InputAgenda extends StatelessWidget {
  const InputAgenda({super.key});

  @override
  Widget build(BuildContext context) {
    double lebarLayar = MediaQuery.of(context).size.width;
    double tinggiLayar = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: lebarLayar <= 720
                ? (5 / 100 * lebarLayar)
                : (25 / 100 * lebarLayar)),
        child: Center(
          child: Container(
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
                      visible: true,
                      child: Expanded(
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
                    //tombol lanjut
                    Expanded(
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
                    )
                  ],
                ),
                Container(
                  height: 330,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 30,
                        )
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
