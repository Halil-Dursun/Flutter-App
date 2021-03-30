import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class SifremiUnuttum extends StatefulWidget {
  @override
  _SifremiUnuttumState createState() => _SifremiUnuttumState();
}

class _SifremiUnuttumState extends State<SifremiUnuttum> {
  TextEditingController userctrl, mailctrl;
  var data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userctrl = new TextEditingController();
    mailctrl = new TextEditingController();
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
                "Şifremi Unuttum",
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
                  controller: mailctrl,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: 'E-posta',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: TextField(
                  controller: userctrl,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Kullanıcı Adı',
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
                      'E-posta Gönder',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                    onPressed: () {
                      sifreGonder(userctrl.text, mailctrl.text);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future sifreGonder(String user, String mail) async {
    var url = 'http://192.168.137.1/bitamircideneme/sifremiunuttum.php';
    var bodyVeriable = {
      'username': user,
      'email': mail,
    };
    var response = await http.post(url, body: bodyVeriable);
    setState(() {
      data = json.decode(response.body);
      if (data == "Error") {
        Fluttertoast.showToast(
            msg:
                "Böyle bir kayıt bulunamadı lütfen girdiğiniz bilgileri kontrol ediniz.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        sendMail();
        Fluttertoast.showToast(
            msg: "E-Posta Başarı ile Gönderildi.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pop(context);
      }
    });
  }

  sendMail() async {
    String username = 'bitamirciapp@gmail.com';
    String password = 'hd1998hd';

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, 'BiTamirci')
      ..recipients.add('${mailctrl.text}')
      //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      //..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'BiTamirci Şifremi Unuttum ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html =
          "<h1>BiTamirci</h1>\n<p>Uygulamaya girmek için yeni şifreniz : ${data.toString()}</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
