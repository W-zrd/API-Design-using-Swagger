class Storage {
  final int id;
  final String nama;
  final String kategori;
  final String deskripsi;

  Storage({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.deskripsi,
  });

  factory Storage.fromJson(Map<String, dynamic> json) {
    return Storage(
      id: int.parse(json['id']),
      nama: json['nama'],
      kategori: json['kategori'],
      deskripsi: json['deskripsi'],
    );
  }
}