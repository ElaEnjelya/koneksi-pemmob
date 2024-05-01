import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Universitas di Indonesia',
      home: UniversitiesPage(),
    );
  }
}

class UniversitiesPage extends StatefulWidget {
  @override
  _UniversitiesPageState createState() => _UniversitiesPageState();
}

class _UniversitiesPageState extends State<UniversitiesPage> {
  List<dynamic> _universities = [];

  @override
  void initState() {
    super.initState();
    fetchUniversities();
  }

  Future<void> fetchUniversities() async {
    try {
      final response = await http.get(Uri.parse(
          'http://universities.hipolabs.com/search?country=Indonesia'));
      if (response.statusCode == 200) {
        setState(() {
          _universities = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load universities');
      }
    } catch (e) {
      print('Error fetching universities: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Universitas di Indonesia'),
      ),
      body: _universities.isNotEmpty
          ? ListView.builder(
              itemCount: _universities.length,
              itemBuilder: (context, index) {
                var university = _universities[index];
                // Ambil situs web pertama dari list web_pages
                String webPage = university['web_pages'][0];
                return Container(
                  decoration: BoxDecoration(
                    color: index % 2 == 0
                        ? Colors.grey[300]
                        : Colors
                            .white, // Ganti warna background untuk setiap baris
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      university['name'],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      webPage,
                      textAlign: TextAlign.center,
                    ),
                    onTap: () => _launchURL(webPage),
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}
