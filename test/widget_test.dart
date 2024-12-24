import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:petshop_inventory_system/main.dart'; // Sesuaikan dengan lokasi file utama Anda
import 'package:petshop_inventory_system/models/barang.dart'; // Sesuaikan dengan halaman yang ingin diuji

void main() {
  group('Widget Testing for Petshop Inventory System', () {
    testWidgets('Verify presence of BarangPage title', (WidgetTester tester) async {
      // Build the BarangPage widget
      await tester.pumpWidget(MaterialApp(home: BarangPage()));

      // Verify if the title 'Daftar Barang' is present
      expect(find.text('Daftar Barang'), findsOneWidget);
    });

    testWidgets('Verify empty state message', (WidgetTester tester) async {
      // Build the BarangPage widget
      await tester.pumpWidget(MaterialApp(home: BarangPage()));

      // Verify if the empty state message is present
      expect(find.text('Tidak ada data'), findsOneWidget);
    });

    testWidgets('Check for CircularProgressIndicator on loading', (WidgetTester tester) async {
      // Build the BarangPage widget
      await tester.pumpWidget(MaterialApp(home: BarangPage()));

      // While the FutureBuilder is loading, CircularProgressIndicator should be shown
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
