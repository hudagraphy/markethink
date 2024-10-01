import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(textTheme: GoogleFonts.latoTextTheme()),
        home: Beranda());
  }
}

class Beranda extends StatelessWidget {
  const Beranda({super.key});

  @override
  Widget build(BuildContext context) {
    double lebarLayar = MediaQuery.of(context).size.width;
    double tinggiLayar = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 5 / 100 * lebarLayar),
        padding: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            //Profile, Greeting, Notification
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //profiledan greetings
                Container(
                  //userProfile
                  child: Row(
                    children: [
                      Container(
                          padding: EdgeInsets.only(right: 5),
                          child: CircleAvatar()),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Assalamualaikum",
                            style: TextStyle(fontSize: 12, color: Colors.blue),
                          ),
                          Text(
                            "Admisi Unimma!",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                //notiifikasi
                IconButton(
                    onPressed: () => {},
                    icon: Icon(Icons.notifications_rounded, color: Colors.blue,))
              ],
            ),
            //Lokasi Device
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: IconTextKecil(
                isiIkon: Icons.location_on_rounded,
                isiText: "Mertoyudan, Magelang",
              ),
            ),
            //High priority card
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade100,
                      blurRadius: 30,
                      spreadRadius: 3)
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Text, dan Tajuk Acara Prioritas
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Agenda terdekatmu", style: TextStyle(fontSize: 14),),
                      Text(
                        "Dangdutan nde Bekicot Magetan Mlaku Mlaku Ning sarangan",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.blue
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                  //Ikon Teks Waktu dan Jam
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconTextKecil(
                          isiIkon: Icons.calendar_month_rounded,
                          isiText: "Minggu, 14 November 2019"),
                      IconTextKecil(
                          isiIkon: Icons.schedule_rounded, isiText: "08:00 WIB")
                    ],
                  )
                ],
              ),
            ),
            //Agenda Berikutnya
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  //SubTitle : Agenda akan datang - Lihat semua
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Agenda beriktunya",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Lihat semua",
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  //progressBarr
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "--Progress Bar di sini--",
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  //List Kartu Agenda
                  Stack(
                    children: [
                      //Tajuk acara berikutnya
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                spreadRadius: 0.5,
                                blurRadius: 10,
                                blurStyle: BlurStyle.outer),
                          ],
                        ),
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 110, top: 10, right: 15, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Main tajuk
                              Text(
                                "Expo GIASS 2024 Cabang Surabaya",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              //row isi lokasi dan small info icon
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //info lokasi
                                  IconTextKecil(
                                    isiIkon: Icons.location_on_rounded,
                                    isiText: "Gempol Surabaya",
                                  ),
                                  //informasi tambahan (proof dan kendaraan)
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.done_all_rounded,
                                        size: 15,
                                      ),
                                      Icon(
                                        Icons.directions_car_filled_rounded,
                                        size: 15,
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      //Floating Tanggal
                      Container(
                        padding: EdgeInsets.all(5),
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                spreadRadius: 0.5,
                                blurRadius: 5,
                                blurStyle: BlurStyle.outer),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "18",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue
                              ),
                            ),
                            Text(
                              "September\n2024",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 10, color: Colors.blue),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
            //
          ],
        ),
      ),
    );
  }
}

class IconTextKecil extends StatelessWidget {
  const IconTextKecil(
      {super.key, required this.isiIkon, required this.isiText});

  final IconData isiIkon;
  final String isiText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          isiIkon,
          size: 15,
          color: Colors.blue,
        ),
        Text(
          isiText,
          style: TextStyle(fontSize: 10),
        )
      ],
    );
  }
}
