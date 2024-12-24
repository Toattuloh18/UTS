class Barang {
  final int id;
  final String namaBarang;
  final double hargaBarang;
  final int stokBarang;

  Barang({required this.id, required this.namaBarang, required this.hargaBarang, required this.stokBarang});

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
