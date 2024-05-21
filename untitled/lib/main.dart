import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'earthquake_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListGempa(),
    );
  }
}

class ListGempa extends StatefulWidget {
  @override
  _ListGempaState createState() => _ListGempaState();
}

class _ListGempaState extends State<ListGempa> {
  late Future<List<Earthquake>> futureGempa;

  Future<List<Earthquake>> fetchGempa() async {
    final response = await http.get(Uri.parse(
        'https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2022-03-05&endtime=2022-03-06&limit=10'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['features'];
      return jsonResponse
          .map((data) => Earthquake.fromJson(data['properties']))
          .toList();
    } else {
      throw Exception('Failed to load gempa');
    }
  }

  @override
  void initState() {
    super.initState();
    futureGempa = fetchGempa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TP',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<Earthquake>>(
        future: futureGempa,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Earthquake> gempa = snapshot.data!;
            return ListView.builder(
              itemCount: gempa.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Magnitude: ${gempa[index].magnitude}'),
                  subtitle: Text(gempa[index].lokasi),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
