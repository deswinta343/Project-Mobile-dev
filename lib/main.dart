import 'package:ayotripfiks/form_register.dart';
import 'package:flutter/material.dart';
import 'package:ayotripfiks/sqlite_db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.db(); // Pastikan database diinisialisasi
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFEDF2F6),
      ),
      home: RegisterPage(), // Fixed: Use WelcomeScreen() instead of WelcomeScreen
    );
  }
}