import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kembangringgit_app/screens/document_create_screen.dart';
import 'package:kembangringgit_app/screens/document_screen.dart';
import 'package:kembangringgit_app/screens/event_create_screen.dart';
import 'package:kembangringgit_app/screens/event_screen.dart';
import 'package:kembangringgit_app/screens/home_screen.dart';
import 'package:kembangringgit_app/screens/login_screen.dart';
import 'package:kembangringgit_app/screens/report_create_screen.dart';
import 'package:kembangringgit_app/screens/report_screen.dart';
import 'package:kembangringgit_app/firebase_options.dart';
import 'screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kembang Ringgit',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: ThemeData(useMaterial3: true),
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/document', page: () => const DocumentScreen()),
        GetPage(name: '/document/create', page: () => DocumentCreateScreen()),
        GetPage(name: '/report', page: () => const ReportScreen()),
        GetPage(name: '/report/create', page: () => ReportScreenScreen()),
        GetPage(name: '/event', page: () => const EventScreen()),
        GetPage(name: '/event/create', page: () => EventCreateScreen()),
      ],
    );
  }
}
