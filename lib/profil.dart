import 'dart:convert';

import 'package:bitamirci_proje/profil_duzenle.dart';
import 'package:bitamirci_proje/tamirciyim.dart';
import 'package:bitamirci_proje/yeni_sifre.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Profil extends StatefulWidget {
  var idUser;
  Profil(this.idUser);
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  List data;
  String kullaniciadi = "", eposta = "", meslek = "";

  Future userProfile() async {
    var url = 'http://192.168.137.1/bitamircideneme/profil.php';
    var bodyVeriable = {
      'id': widget.idUser.toString(),
    };
    var response = await http.post(url, body: bodyVeriable);
    setState(() {
      data = json.decode(response.body);
      kullaniciadi = data[0]['username'];
      eposta = data[0]['email'];
      meslek = data[0]['job'];
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      userProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profil'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://w0.pngwave.com/png/639/452/computer-icons-avatar-user-profile-people-icon-png-clip-art.png'),
                radius: 80.0,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 14.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 24.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Kullanıcı Adı",
                              style: TextStyle(fontSize: 18.0),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              kullaniciadi,
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 15.0),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 14.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.mail,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 24.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "E-Posta",
                              style: TextStyle(fontSize: 18.0),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              eposta,
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 15.0),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 14.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.work,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 24.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Meslek",
                              style: TextStyle(fontSize: 18.0),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              meslek,
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 15.0),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      child: Text(
                        "Tamirciyim",
                        style: TextStyle(color: Colors.green),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Tamirciyim(
                              widget.idUser,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      child: Text(
                        "Profili Düzenle",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilDuzenle(
                                widget.idUser, kullaniciadi, eposta, meslek),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      child: Text(
                        "Şifre Değiştir",
                        style: TextStyle(color: Colors.yellow),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SifreDegistir(widget.idUser),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
