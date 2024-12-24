import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'sevices/api_sevice.dart';
import 'models/barang.dart';
import 'package:device_preview/device_preview.dart'; // Impor package device_preview

void main() {
  runApp(
    DevicePreview(
      enabled: true, // Set true untuk mengaktifkan preview, ganti menjadi false di produksi
      builder: (context) => MyApp(),  // Aplikasi utama Anda
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Petshop Inventory System',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
