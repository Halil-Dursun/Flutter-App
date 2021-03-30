import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ProfilDuzenle extends StatefulWidget {
  var idUser;
  String kullaniciadiduzenle = "", epostaduzenle = "", meslekduzenle;
  ProfilDuzenle(this.idUser, this.kullaniciadiduzenle, this.epostaduzenle,
      this.meslekduzenle);

  @override
  _ProfilDuzenleState createState() => _ProfilDuzenleState();
}

class _ProfilDuzenleState extends State<ProfilDuzenle> {
  TextEditingController user, mail;
  List<String> meslekler = [
    "Çilingir",
    "Klimacı",
    "Televizyoncu",
    "Mobilyacı",
    "Beyaz Eşya Tamircisi",
    "Su Tesisatçısı"
  ];
  String secilenMeslek = "Çilingir";

  @override
  void initState() {
    // TODO: implement initState
    user = new TextEditingController();
    mail = new TextEditingController();
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
                "Profil Düzenle",
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
                  controller: mail,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: widget.epostaduzenle,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: TextField(
                  controller: user,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: widget.kullaniciadiduzenle,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: DropdownButton(
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 36,
                    isExpanded: true,
                    underline: SizedBox(),
                    style: TextStyle(color: Colors.black, fontSize: 22),
                    items: meslekler.map((oankiMeslek) {
                      return DropdownMenuItem(
                        child: Text(oankiMeslek),
                        value: oankiMeslek,
                      );
                    }).toList(),
                    onChanged: (s) {
                      setState(() {
                        secilenMeslek = s;
                      });
                    },
                    value: secilenMeslek,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: MaterialButton(
                    child: Text(
                      'Güncelle',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                    onPressed: () {
                      UpdateProfile(user.text, secilenMeslek, mail.text);
                      Navigator.pop(context);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  void UpdateProfile(String name, String job, String mail) {
    var url = "http://192.168.137.1/bitamircideneme/profilduzenle.php";
    var data = {
      "id": widget.idUser.toString(),
      "username": name,
      "job": job,
      "email": mail
    };
    var res = http.post(url, body: data);
    Fluttertoast.showToast(
        msg: "Güncelleme Başarılı",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
