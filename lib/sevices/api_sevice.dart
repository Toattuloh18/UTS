import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petshop_inventory_system/models/barang.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8000/barangs';

  // Fetch semua barang
  Future<List<Barang>> fetchBarangs() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Barang.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Menambah barang
  Future<Barang> addBarang(Barang barang) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(barang.toJson()),
    );

    if (response.statusCode == 201) {
      return Barang.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add barang');
    }
  }

  // Update barang
  Future<Barang> updateBarang(int id, Barang barang) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(barang.toJson()),
    );

    if (response.statusCode == 200) {
      return Barang.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update barang');
    }
  }

  // Hapus barang
  Future<void> deleteBarang(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete barang');
    }
  }
}
