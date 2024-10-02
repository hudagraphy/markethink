import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Beranda extends StatelessWidget {
  const Beranda({super.key});

  @override
  Widget build(BuildContext context) {
    double lebarLayar = MediaQuery.of(context).size.width;
    double tinggiLayar = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          //Main Content
          Container(
            child: Stack(
              children: [
                //Agenda Berikutnya
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadiusDirectional.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  margin: EdgeInsets.only(top: 200),
                  padding: EdgeInsets.only(
                    top: 100,
                    bottom: 50,
                    left: 5 / 100 * lebarLayar,
                    right: 5 / 100 * lebarLayar,
                  ),
                  child: Column(
                    children: [
                      //SubTitle : Agenda akan datang - Lihat semua
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Agenda beriktunya",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Lihat semua",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
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
                      KartuAgenda(
                        tajukAcara: "Expo GIASS Surabaya 2024",
                        lokasiAcara: "Dolly, Surabaya",
                        waktuAcara: DateTime.now(),
                        statusApprove: true,
                      ),
                    ],
                  ),
                ),
                //Pin Lokasi dan HighPriority Card
                Container(
                  margin: EdgeInsets.only(
                      left: 5 / 100 * lebarLayar,
                      right: 5 / 100 * lebarLayar,
                      top: 100),
                  child: Column(
                    children: [
                      //Lokasi Device
                      PinLokasi(),
                      //High priority card
                      HighPriorityCard(),
                    ],
                  ),
                )
              ],
            ),
          ),
          //Profile, Greeting, Notification
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(
                horizontal: 5 / 100 * lebarLayar, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //profile dan greetings
                Container(
                  //userProfile
                  child: Row(
                    children: [
                      Container(
                          padding: EdgeInsets.only(right: 5),
                          child: CircleAvatar()),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Assalamualaikum",
                            style: TextStyle(fontSize: 12, color: Colors.blue),
                          ),
                          Text(
                            "Admisi Unimma!",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                //notiifikasi
                IconButton(
                    onPressed: () => {},
                    icon: Icon(
                      Icons.notifications_rounded,
                      color: Colors.blue,
                    ))
              ],
            ),
          ),
          //NavBar
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              width: double.infinity,
              margin: EdgeInsets.only(
                left: 10 / 100 * lebarLayar,
                right: 10 / 100 * lebarLayar,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(30)),
            ),
          )
        ],
      ),
    );
  }
}

class PinLokasi extends StatelessWidget {
  const PinLokasi({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: IconTextKecil(
        isiIkon: Icons.location_on_rounded,
        isiText: "Mertoyudan, Magelang",
      ),
    );
  }
}

class HighPriorityCard extends StatelessWidget {
  const HighPriorityCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 30,
              spreadRadius: 1)
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
              Text(
                "Agenda terdekatmu",
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              Text(
                "Presentasi SMK Muhammadiyah Kebumen",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blue),
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
    );
  }
}

class KartuAgenda extends StatelessWidget {
  const KartuAgenda({
    super.key,
    required this.tajukAcara,
    required this.waktuAcara,
    required this.lokasiAcara,
    this.statusApprove = false,
    this.statusKendaraan = false,
  });

  final String tajukAcara;
  final DateTime waktuAcara;
  final String lokasiAcara;
  final bool statusApprove;
  final bool statusKendaraan;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Stack(
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
              margin:
                  EdgeInsets.only(left: 115, top: 15, right: 15, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Main tajuk
                  Text(
                    "${tajukAcara}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  //row isi lokasi dan small info icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //info lokasi
                      IconTextKecil(
                        isiIkon: Icons.location_on_rounded,
                        isiText: "${lokasiAcara}",
                      ),
                      //informasi tambahan (proof dan kendaraan)
                      Row(
                        children: [
                          Icon(
                            Icons.done_all_rounded,
                            size: 15,
                            color: statusApprove ? Colors.blue : Colors.black12,
                          ),
                          Icon(
                            Icons.directions_car_filled_rounded,
                            size: 15,
                            color:
                                statusKendaraan ? Colors.blue : Colors.black12,
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
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 10,
                    blurStyle: BlurStyle.outer),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${DateFormat.d().format(waktuAcara)}",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                Text(
                  "${DateFormat.MMMM().format(waktuAcara)}\n${DateFormat.y().format(waktuAcara)}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ],
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
