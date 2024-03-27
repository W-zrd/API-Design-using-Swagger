import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key? key, required this.title})
      : super(key: key); // Required keyword for title

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<App> apps = [
    App(
        name: 'Facebook',
        languages: ['Dart', 'JavaScript'],
        iconColor: Colors.blue),
    App(
        name: 'Instagram',
        languages: ['Java', 'Kotlin'],
        iconColor: Colors.purpleAccent),
    App(
        name: 'Twitter',
        languages: ['Python', 'C++'],
        iconColor: Colors.black87),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: apps.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: apps[index].iconColor,
                child: Icon(Icons.code,
                    color: Colors.white), // Adjust icon accordingly
              ),
              title: Text(apps[index].name),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                        "Detail",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text(
                              apps[index].name,
                              style: const TextStyle(fontSize: 21, color: Colors.blue),
                            ),
                            Text(apps[index].languages.join(', ')),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class App {
  final String name;
  final List<String> languages;
  final Color iconColor;

  App({required this.name, required this.languages, required this.iconColor});
}
