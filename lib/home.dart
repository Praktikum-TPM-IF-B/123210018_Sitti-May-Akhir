import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hi, Nama Mahasiswa!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Profile',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Data Teman',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Teman ${index + 1}'),
                  subtitle: Text('Tahun Masuk: 2024'),
                  trailing: Text('NIM: 123456789'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
