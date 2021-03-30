import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Tamirciyim extends StatefulWidget {
  var userId;
  Tamirciyim(this.userId);

  @override
  _TamirciyimState createState() => _TamirciyimState();
}

class _TamirciyimState extends State<Tamirciyim> {
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
                "Mesleğinizi Seçiniz",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Divider(),
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
                      'Onayla',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                    onPressed: () {
                      MeslekSecimi(
                        secilenMeslek,
                      );
                      Navigator.pop(context);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  void MeslekSecimi(String job) {
    var url = "http://192.168.137.1/bitamircideneme/tamirciyim.php";
    var data = {"id": widget.userId.toString(), "job": job};
    var res = http.post(url, body: data);
    Fluttertoast.showToast(
        msg: "Mesleğiniz Kaydedildi",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
