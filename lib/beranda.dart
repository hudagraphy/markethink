import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:markethink/addAgenda.dart';
import 'package:markethink/dbFirebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:markethink/loginPage.dart';
import 'package:markethink/profilPage.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  @override
  Widget build(BuildContext context) {
    double lebarLayar = MediaQuery.of(context).size.width;
    double tinggiLayar = MediaQuery.of(context).size.height;
    late String userAkun =
        FirebaseAuth.instance.currentUser?.displayName ?? 'Huda';
    return Scaffold(
      body: Stack(
        children: [
          //Main Content
          RefreshIndicator.adaptive(
            displacement: (18 / 100) * tinggiLayar,
            color: Colors.amber,
            backgroundColor: Colors.blue,
            onRefresh: () {
              return Future.delayed(
                Duration(seconds: 3),
                () => setState(() {}),
              );
            },
            child: FutureBuilder(
                future: ambilDataAgenda(userAkun: userAkun),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length > 0) {
                      return Container(
                        margin: EdgeInsets.only(top: 80),
                        child: ListView(
                          children: [
                            Stack(
                              children: [
                                //Agenda Berikutnya
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius:
                                        BorderRadiusDirectional.vertical(
                                      top: Radius.circular(30),
                                    ),
                                  ),
                                  margin: EdgeInsets.only(top: 100),
                                  padding: EdgeInsets.only(
                                    top: 100,
                                    bottom: 80,
                                    left: 5 / 100 * lebarLayar,
                                    right: 5 / 100 * lebarLayar,
                                  ),
                                  child: Column(
                                    children: [
                                      //Agenda akan datang - Lihat semua
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Agenda beriktunya",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              var allData = snapshot.data;
                                              List<QueryDocumentSnapshot>
                                                  dataAgendaHuda = allData;
                                              print(dataAgendaHuda);
                                            },
                                            child: Text(
                                              "Lihat semua",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      //progressBarr
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          "--Progress Bar di sini--",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ),
                                      //List Kartu Agenda
                                      Container(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: snapshot.data.length - 1,
                                          itemBuilder: (context, index) {
                                            var dataAgenda =
                                                snapshot.data[index + 1].data();
                                            return GestureDetector(
                                              onTap: () async {
                                                dialogViewAgenda(context,
                                                    lebarLayar, dataAgenda);
                                              },
                                              child: KartuAgenda(
                                                tajukAcara:
                                                    dataAgenda['tajukAgenda'],
                                                lokasiAcara:
                                                    dataAgenda['kotaKabAgenda']
                                                        .join(', '),
                                                waktuAcara: dataAgenda[
                                                        'waktuBerangkatAgenda']
                                                    .toDate(),
                                                statusApprove: true,
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                //Pin Lokasi dan HighPriority Card
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 5 / 100 * lebarLayar,
                                      right: 5 / 100 * lebarLayar,
                                      top: 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //Lokasi Device
                                      PinLokasi(),
                                      //High priority card
                                      GestureDetector(
                                        onTap: () {
                                          dialogViewAgenda(context, lebarLayar,
                                              snapshot.data[0].data());
                                        },
                                        child: HighPriorityCard(
                                            dataAgenda:
                                                snapshot.data[0].data()),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: Text('Ga ada Agenda Buatmu'),
                      );
                    }
                  } else if (snapshot.hasError) {
                    return Text('Error leh ${snapshot.error}');
                  } else {
                    return Text('Sik Yo Bro');
                  }
                }),
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HalamanProfil(),
                      ),
                    );
                  },
                  child: Container(
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
                              style:
                                  TextStyle(fontSize: 12, color: Colors.blue),
                            ),
                            Text(
                              userAkun,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                //notiifikasi
                IconButton(
                    onPressed: () => {
                          debugPrint(
                              FirebaseAuth.instance.currentUser?.displayName)
                        },
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
            child: NavigasiBar(lebarLayar: lebarLayar),
          )
        ],
      ),
    );
  }
}

Future<dynamic> dialogViewAgenda(
    BuildContext context, double lebarLayar, dataAgenda) {
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: lebarLayar <= 720
                    ? (5 / 100 * lebarLayar)
                    : (25 / 100 * lebarLayar)),
            padding: EdgeInsets.all(15),
            height: 390,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: CardViewAgenda(hasilForm: dataAgenda)),
      );
    },
  );
}

class NavigasiBar extends StatefulWidget {
  NavigasiBar({
    super.key,
    required this.lebarLayar,
  });

  final double lebarLayar;
  int indexNav = 1;

  @override
  State<NavigasiBar> createState() => _NavigasiBarState();
}

class _NavigasiBarState extends State<NavigasiBar> {
  final List<IconData> iconNavigasi = [Icons.home_rounded, Icons.add_rounded];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      margin: EdgeInsets.only(
        left: 10 / 100 * widget.lebarLayar,
        right: 10 / 100 * widget.lebarLayar,
        bottom: 30,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconNavbar(
            ikon: Icons.home,
            status: widget.indexNav == 1,
            onPressed: () {
              setState(() {
                widget.indexNav = 1;
              });
            },
          ),
          IconNavbar(
            ikon: Icons.event_note_rounded,
            status: widget.indexNav == 2,
            onPressed: () {
              setState(() {
                widget.indexNav = 2;
              });
            },
          ),
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: IconButton(
              color: Colors.white,
              icon: Icon(Icons.add),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30))),
                  builder: (context) {
                    return Container(
                      height: 250,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IsiBottomSheet(
                            ikon: Icons.calendar_month_rounded,
                            judul: "Buat Agenda",
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => InputAgenda(),
                              );
                            },
                          ),
                          IsiBottomSheet(
                            ikon: Icons.local_see_rounded,
                            judul: "Dokumentasi Giat",
                            onPressed: () {},
                          ),
                          IsiBottomSheet(
                            ikon: Icons.payments_rounded,
                            judul: "Catat Pengeluaran",
                            onPressed: () {},
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          IconNavbar(
            ikon: Icons.account_balance_wallet_rounded,
            status: widget.indexNav == 3,
            onPressed: () {
              setState(() {
                widget.indexNav = 3;
              });
            },
          ),
          IconNavbar(
            ikon: Icons.auto_graph_sharp,
            status: widget.indexNav == 4,
            onPressed: () {
              setState(() {
                widget.indexNav = 4;
              });
            },
          ),
        ],
      ),
    );
  }
}

class IsiBottomSheet extends StatelessWidget {
  const IsiBottomSheet(
      {super.key,
      required this.ikon,
      required this.judul,
      required this.onPressed});

  final String judul;
  final IconData ikon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Icon(
          ikon,
          size: 28,
        ),
        iconColor: Colors.blue,
        title: Text(
          judul,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: onPressed,
      ),
    );
  }
}

class IconNavbar extends StatelessWidget {
  const IconNavbar(
      {super.key,
      required this.ikon,
      required this.status,
      required this.onPressed});

  final void Function() onPressed;
  final bool status;
  final IconData ikon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(ikon),
      color: status ? Colors.blue : Colors.black38,
      onPressed: onPressed,
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
  const HighPriorityCard({super.key, required this.dataAgenda});

  final Map<String, dynamic> dataAgenda;

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
                "${dataAgenda['tajukAgenda']}",
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
                  isiText:
                      "${DateFormat('EEEE, d MMMM y').format(dataAgenda['waktuBerangkatAgenda'].toDate())}"),
              IconTextKecil(
                  isiIkon: Icons.schedule_rounded,
                  isiText:
                      "${DateFormat.Hm().format(dataAgenda['waktuBerangkatAgenda'].toDate())} WIB")
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
                      Container(
                        child: IconTextKecil(
                          isiIkon: Icons.location_on_rounded,
                          isiText: "${lokasiAcara}",
                        ),
                      ),
                      //informasi tambahan (proof dan kendaraan)
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.done_all_rounded,
                              size: 15,
                              color:
                                  statusApprove ? Colors.blue : Colors.black12,
                            ),
                            Icon(
                              Icons.directions_car_filled_rounded,
                              size: 15,
                              color: statusKendaraan
                                  ? Colors.blue
                                  : Colors.black12,
                            )
                          ],
                        ),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isiIkon,
          size: 15,
          color: Colors.blue,
        ),
        Flexible(
          fit: FlexFit.loose,
          child: Text(
            isiText,
            style: TextStyle(fontSize: 10),
          ),
        )
      ],
    );
  }
}
