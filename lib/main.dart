import 'package:flutter/material.dart';
import 'package:bitamirci_proje/giris_sayfasi.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(debugShowCheckedModeBanner: false,
    home : LoginPage());
  }
}