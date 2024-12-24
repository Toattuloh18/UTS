import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'inventory_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Meminta izin akses penyimpanan pada aplikasi pertama kali dibuka
    _requestPermission();
  }

  Future<void> _requestPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Apakah Anda yakin ingin keluar?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                // Navigasi ke halaman login
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleCrudAction(String action) {
    switch (action) {
      case 'add':
        print('Tambah data');
        // Aksi untuk menambah data
        break;
      case 'edit':
        print('Edit data');
        // Aksi untuk mengedit data
        break;
      case 'delete':
        print('Hapus data');
        // Aksi untuk menghapus data
        break;
      case 'view':
        print('Lihat stok barang');
        _showStockDialog();
        break;
    }
  }

  void _showStockDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Stok Barang"),
          content: Container(
            width: double.maxFinite,
            child: ListView(
              children: [
                ListTile(
                  title: Text("Barang 1"),
                  subtitle: Text("Stok: 20"),
                ),
                ListTile(
                  title: Text("Barang 2"),
                  subtitle: Text("Stok: 15"),
                ),
                ListTile(
                  title: Text("Barang 3"),
                  subtitle: Text("Stok: 30"),
                ),
                // Tambahkan data barang lain jika diperlukan
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Tutup"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UHB Petshop'),
        backgroundColor: Colors.green[700],
        elevation: 5,
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline, size: 30),
            onPressed: () {
              // Aksi CRUD untuk mengelola tabel inventaris
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InventoryScreen()),
              );
            },
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.menu, size: 30),
            onSelected: _handleCrudAction,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'add',
                  child: Row(
                    children: [
                      Icon(Icons.add, color: Colors.green),
                      SizedBox(width: 10),
                      Text('Tambah Data'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit, color: Colors.orange),
                      SizedBox(width: 10),
                      Text('Edit Data'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 10),
                      Text('Hapus Data'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'view',
                  child: Row(
                    children: [
                      Icon(Icons.visibility, color: Colors.blue),
                      SizedBox(width: 10),
                      Text('Lihat Stok Barang'),
                    ],
                  ),
                ),
              ];
            },
          ),
          IconButton(
            icon: Icon(Icons.logout, size: 30),
            onPressed: () {
              _logout(context); // Panggil fungsi logout
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Permission.storage.request(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green[700]!, Colors.green[200]!], // Gradient warna
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Selamat datang di Sistem Informasi Petshop!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.5,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(5.0, 5.0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => InventoryScreen()),
                            );
                          },
                          child: Card(
                            elevation: 10,
                            shadowColor: Colors.green[700],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 50.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.inventory,
                                    size: 50,
                                    color: Colors.green[700],
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    'Lihat Inventaris',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InventoryScreen()),
          );
        },
        child: Icon(Icons.inventory),
        backgroundColor: Colors.green[700],
        elevation: 5,
      ),
    );
  }
}
