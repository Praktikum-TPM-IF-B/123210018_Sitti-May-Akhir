import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _amiibos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAmiibos();
  }

  Future<void> _fetchAmiibos() async {
    final response = await http.get(Uri.parse('https://www.amiiboapi.com/api/amiibo/'));
    if (response.statusCode == 200) {
      setState(() {
        _amiibos = json.decode(response.body)['amiibo'];
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load amiibos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Amiibo List', style: TextStyle(fontFamily: 'Poppins', fontSize: 24)),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _amiibos.length,
              itemBuilder: (context, index) {
                final amiibo = _amiibos[index];
                final imageUrl = amiibo['image'] ?? 'https://via.placeholder.com/150';

                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Image.network(
                      imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(amiibo['name'], style: TextStyle(fontFamily: 'Poppins', fontSize: 18)),
                    subtitle: Text(
                      'Character: ${amiibo['character']}\nGame Series: ${amiibo['gameSeries']}',
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
