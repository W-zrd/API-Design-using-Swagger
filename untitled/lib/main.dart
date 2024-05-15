import 'package:flutter/material.dart';
import 'package:untitled/storage_service.dart';
import 'package:untitled/storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Storage App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StorageListScreen(),
    );
  }
}

class StorageListScreen extends StatefulWidget {
  const StorageListScreen({super.key});

  @override
  State<StorageListScreen> createState() => _StorageListScreenState();
}

class _StorageListScreenState extends State<StorageListScreen> {
  final StorageService _storageService = StorageService();
  List<Storage> _storageItems = [];

  @override
  void initState() {
    super.initState();
    _fetchStorageItems();
  }

  Future<void> _fetchStorageItems() async {
    try {
      final storageItems = await _storageService.fetchStorageItems();
      setState(() {
        _storageItems = storageItems;
      });
    } catch (e) {
      // Handle error
      print('Error fetching storage items: $e');
    }
  }

  Future<void> _addStorageItem() async {
    final namaController = TextEditingController();
    final kategoriController = TextEditingController();
    final deskripsiController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Storage Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: namaController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: kategoriController,
              decoration: const InputDecoration(labelText: 'Kategori'),
            ),
            TextField(
              controller: deskripsiController,
              decoration: const InputDecoration(labelText: 'Deskripsi'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final nama = namaController.text;
              final kategori = kategoriController.text;
              final deskripsi = deskripsiController.text;
              try {
                await _storageService.addStorageItem(nama, kategori, deskripsi);
                await _fetchStorageItems();
                Navigator.pop(context);
              } catch (e) {
                // Handle error
                print('Error adding storage item: $e');
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Storage Items'),
      ),
      body: _storageItems.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _storageItems.length,
        itemBuilder: (context, index) {
          final storage = _storageItems[index];
          return Card(
            child: ListTile(
              title: Text(storage.nama),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Kategori: ${storage.kategori}'),
                  Text('Deskripsi: ${storage.deskripsi}'),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addStorageItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}