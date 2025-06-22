import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:tugas_akhir_semester1/screens/add_note_screen.dart';
import 'package:tugas_akhir_semester1/screens/detail_screen.dart';
import 'package:tugas_akhir_semester1/screens/home_screen.dart';
import 'package:tugas_akhir_semester1/screens/splash_screen.dart';
import 'package:tugas_akhir_semester1/screens/update_note_screen.dart';
// import 'package:tugas_akhir_semester1/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    // Change default factory on the web
    databaseFactory = databaseFactoryFfiWeb;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
