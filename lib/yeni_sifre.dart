import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class SifreDegistir extends StatefulWidget {
  var idUser;
  SifreDegistir(this.idUser);
  @override
  _SifreDegistirState createState() => _SifreDegistirState();
}

class _SifreDegistirState extends State<SifreDegistir> {
  TextEditingController pass1, pass2, newpass;
  String data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pass1 = new TextEditingController();
    pass2 = new TextEditingController();
    newpass = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "BiTamirci",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 80.0,
              ),
              Text(
                "Şifre Değiştir",
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Divider(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: TextField(
                  controller: pass1,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Eski Şifre',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: TextField(
                  controller: pass2,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Eski Şifre Onay',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: TextField(
                  controller: newpass,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Yeni Şifre',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: MaterialButton(
                    child: Text(
                      'Değiştir',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                    onPressed: () {
                      if (pass1.text == pass2.text) {
                        sifreDegis(pass1.text, newpass.text);
                      } else {
                        Fluttertoast.showToast(
                            msg:
                                "Eski şifreler uyuşmamaktadır.Tekrar deneyiniz",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  void sifreDegis(String pass1, String newpass) async {
    var url = 'http://192.168.137.1/bitamircideneme/sifredegis.php';
    var bodyVeriable = {
      'id': widget.idUser.toString(),
      'password1': pass1,
      'newpass': newpass,
    };
    var response = await http.post(url, body: bodyVeriable);
    setState(() {
      data = json.decode(response.body);
      if (data == "Succes") {
        Fluttertoast.showToast(
            msg: "Şifre başarı ile değiştirildi.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pop(context);
      }
      if (data == "Error") {
        Fluttertoast.showToast(
            msg: "Eski şifreyi yanlış girdiniz.Tekrar deneyiniz",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }
}
