import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Barang {
  final int id;
  final String namaBarang;
  final double hargaBarang;
  final int stokBarang;

  Barang({
    required this.id,
    required this.namaBarang,
    required this.hargaBarang,
    required this.stokBarang,
  });

  factory Barang.fromJson(Map<String, dynamic> json) {
    return Barang(
      id: json['id'],
      namaBarang: json['nama_barang'],
      hargaBarang: json['harga_barang'],
      stokBarang: json['stok_barang'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_barang': namaBarang,
      'harga_barang': hargaBarang,
      'stok_barang': stokBarang,
    };
  }
}

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  List<Barang> barangList = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _stokController = TextEditingController();
  bool _isEditing = false;
  int? _editId;

  // Fetch all barang from API
  Future<void> fetchBarangs() async {
    final response = await http.get(Uri.parse('http://localhost:8000/barangs'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        barangList = data.map((json) => Barang.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load barang');
    }
  }

  // Add or Update barang
  Future<void> saveBarang() async {
    final namaBarang = _namaController.text;
    final hargaBarang = double.tryParse(_hargaController.text);
    final stokBarang = int.tryParse(_stokController.text);

    if (namaBarang.isEmpty || hargaBarang == null || stokBarang == null) {
      return;
    }

    final newBarang = Barang(
      id: _editId ?? 0,
      namaBarang: namaBarang,
      hargaBarang: hargaBarang,
      stokBarang: stokBarang,
    );

    final url = _isEditing
        ? Uri.parse('http://localhost:8000/barangs/${_editId}')
        : Uri.parse('http://localhost:8000/barangs');

    final method = _isEditing ? 'PUT' : 'POST';
    final response = await (method == 'POST'
        ? http.post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: json.encode(newBarang.toJson()),
          )
        : http.put(
            url,
            headers: {'Content-Type': 'application/json'},
            body: json.encode(newBarang.toJson()),
          ));

    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        _isEditing = false;
        _editId = null;
        _namaController.clear();
        _hargaController.clear();
        _stokController.clear();
        fetchBarangs();
      });
    } else {
      throw Exception('Failed to save barang');
    }
  }

  // Delete barang
  Future<void> deleteBarang(int id) async {
    final response =
        await http.delete(Uri.parse('http://localhost:8000/barangs/$id'));

    if (response.statusCode == 204) {
      setState(() {
        barangList.removeWhere((barang) => barang.id == id);
      });
    } else {
      throw Exception('Failed to delete barang');
    }
  }

  // Edit barang
  void editBarang(Barang barang) {
    setState(() {
      _isEditing = true;
      _editId = barang.id;
      _namaController.text = barang.namaBarang;
      _hargaController.text = barang.hargaBarang.toString();
      _stokController.text = barang.stokBarang.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchBarangs();
  }

  @override
  void dispose() {
    _namaController.dispose();
    _hargaController.dispose();
    _stokController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inventory PetShop')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _namaController,
                    decoration: InputDecoration(labelText: 'Nama Barang'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama barang tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _hargaController,
                    decoration: InputDecoration(labelText: 'Harga Barang'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Harga barang tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _stokController,
                    decoration: InputDecoration(labelText: 'Stok Barang'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Stok barang tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        saveBarang();
                      }
                    },
                    child: Text(_isEditing ? 'Update Barang' : 'Tambah Barang'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: barangList.length,
                itemBuilder: (context, index) {
                  final barang = barangList[index];
                  return ListTile(
                    title: Text(barang.namaBarang),
                    subtitle: Text(
                        'Harga: ${barang.hargaBarang}, Stok: ${barang.stokBarang}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => editBarang(barang),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => deleteBarang(barang.id),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
