import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled/storage.dart';

class StorageService {
  static const String _baseUrl = 'http://localhost/api.php';

  Future<List<Storage>> fetchStorageItems() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print('Fetched data: $jsonData');
      return List<Storage>.from(jsonData.map((json) => Storage.fromJson(json)));
    } else {
      print('Error fetching data: ${response.statusCode}');
      throw Exception('Failed to fetch storage items');
    }
  }

  Future<void> addStorageItem(String nama, String kategori, String deskripsi) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'nama': nama, 'kategori': kategori, 'deskripsi': deskripsi}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add storage item');
    }
  }
}