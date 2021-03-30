import 'dart:convert';

import 'package:bitamirci_proje/hosgeldini.dart';
import 'package:bitamirci_proje/kayit_sayfasi.dart';
import 'package:bitamirci_proje/sifremi_unuttum.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future login() async {
    var url = "http://192.168.137.1/bitamircideneme/login.php";
    var response = await http.post(url, body: {
      "username": user.text,
      "password": pass.text,
    });
    var data = json.decode(response.body);
    if (data == "Error") {
      Fluttertoast.showToast(
          msg: "Kullanıcı adı veya Şifre Hatalı",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Giriş Başarılı",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Welcome(data)));
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "BiTamirci",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "BiTamirci",
                  style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              TextFormField(
                controller: user,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  labelText: "Kullanıcı Adı",
                  labelStyle: TextStyle(color: Colors.blue),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: pass,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  labelText: "Şifre",
                  labelStyle: TextStyle(color: Colors.blue),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                      child: Text(
                        "Kayıt Ol",
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                        );
                      }),
                  MaterialButton(
                      child: Text(
                        "Şifremi Unuttum",
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SifremiUnuttum(),
                          ),
                        );
                      })
                ],
              ),
              _loginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginButton() => RaisedButton(
      color: Colors.blue,
      child: Text(
        "Giriş Yap",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        login();
      });
}
