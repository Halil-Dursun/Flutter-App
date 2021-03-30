import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController userctrl, passctrl, mailctrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userctrl = new TextEditingController();
    passctrl = new TextEditingController();
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
                "Kayıt Ol",
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
                    labelText: 'İsim',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: TextField(
                  controller: passctrl,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Şifre',
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
                      'Kayıt Ol',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                    onPressed: () {
                      RegisterUser(userctrl.text, passctrl.text, mailctrl.text);
                      Navigator.pop(context);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  void RegisterUser(String name, String pass, String mail) {
    var url = "http://192.168.137.1/bitamircideneme/register.php";
    var data = {"username": name, "password": pass, "email": mail};
    var res = http.post(url, body: data);
    Fluttertoast.showToast(
        msg: "Kayıt Başarılı",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
