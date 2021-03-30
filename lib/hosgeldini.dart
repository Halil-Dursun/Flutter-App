import 'package:bitamirci_proje/profil.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  var id;
  Welcome(this.id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anasayfa'),
        actions: [
          IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profil(id)));
              },
              color: Colors.white),
        ],
      ),
      body: Center(
        child: Text(
          'Hoşgeldiniz',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
