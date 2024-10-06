import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled18/readings.dart';
import 'dart:convert';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Server',
      home: MyHomePage(title: 'Flutter Server App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late Future<List<Reading>> readings;

  Future<List<Reading>> getReadingList() async {
    final response = await http.get(
        Uri.parse('<MY_GET_REQUEST_LINK>')
    );
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Reading> readings = items.map<Reading>((json) {
      return Reading.fromJson(json);
    }).toList();
    return readings;
  }

  @override
  void initState() {
    super.initState();
    readings = getReadingList(); // readings are retrieved here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<List<Reading>>(
          future: readings,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                return Text('${data.id}, ${data.temperature}°C, ${data.humidity}%, ${data.reading_time}');
              },
            );
          },
        ),
      ),);
  }
}