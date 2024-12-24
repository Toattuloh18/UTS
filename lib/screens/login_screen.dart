import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _adminCodeController = TextEditingController(); // Controller untuk kode unik admin

  Future<void> _login(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUsername = prefs.getString('username');
    String? savedPassword = prefs.getString('password');
    const String adminCode = "12345"; // Kode unik admin

    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty || _adminCodeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Semua field harus diisi!')),
      );
      return;
    }

    if (_usernameController.text == savedUsername &&
        _passwordController.text == savedPassword &&
        _adminCodeController.text == adminCode) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login Gagal! Username, Password, atau Kode Admin salah')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Login'),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo atau gambar kecil
              Icon(
                Icons.pets,
                size: 100,
                color: Colors.green[700],
              ),
              SizedBox(height: 30),
              
              // Form Login Username
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Masukkan username Anda',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.green[700]!, width: 2),
                  ),
                  prefixIcon: Icon(Icons.account_circle, color: Colors.green[700]),
                ),
              ),
              SizedBox(height: 20),

              // Form Login Password
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Masukkan password Anda',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.green[700]!, width: 2),
                  ),
                  prefixIcon: Icon(Icons.lock, color: Colors.green[700]),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),

              // Form Kode Unik Admin
              TextFormField(
                controller: _adminCodeController,
                decoration: InputDecoration(
                  labelText: 'Kode Admin',
                  hintText: 'Masukkan kode admin',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.green[700]!, width: 2),
                  ),
                  prefixIcon: Icon(Icons.vpn_key, color: Colors.green[700]),
                ),
              ),
              SizedBox(height: 30),

              // Tombol Login
              ElevatedButton(
                onPressed: () => _login(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700], // Warna latar belakang tombol
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: Colors.green[600],
                  elevation: 5,
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Tombol untuk navigasi ke halaman Register
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child: Text(
                  'Belum punya akun? Register',
                  style: TextStyle(color: Colors.green[700]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
