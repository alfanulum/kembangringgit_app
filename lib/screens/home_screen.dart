import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kembangringgit_app/widgets/developer_card.dart';
import 'package:kembangringgit_app/widgets/feature_card.dart';
import 'package:kembangringgit_app/widgets/weather_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '';
  String userNik = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('name') ?? 'Memuat';
      userNik = prefs.getString('nik') ?? 'Memuat';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName),
              const SizedBox(
                height: 5,
              ),
              Text(
                userNik,
              )
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Ionicons.notifications_outline),
          )
        ],
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              WeatherCard(),
              SizedBox(
                height: 20,
              ),
              Text(
                'Layanan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FeatureCard(
                    route: 'document',
                    text: 'Dokumen',
                    image: 'assets/icon_document.png',
                  ),
                  FeatureCard(
                    route: 'report',
                    text: 'Laporan',
                    image: 'assets/icon_report.png',
                  ),
                  FeatureCard(
                    route: 'event',
                    text: 'Kegiatan',
                    image: 'assets/icon_calendar.png',
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Pengembang',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10,
              ),
              DeveloperCard(
                image: 'assets/profile_alpan.jpg',
                name: 'Muhammad Alfanul Ulum',
                phone: '085746767019',
                email: '22082010064@student.upnjatim.ac.id',
              ),
              SizedBox(
                height: 10,
              ),
              DeveloperCard(
                image: 'assets/profile_arya.jpeg',
                name: 'Arya Rizky Tri Putra',
                phone: '085707656364',
                email: '22082010067@student.upnjatim.ac.id',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
