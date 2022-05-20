import 'package:flutter/material.dart';
import 'dataclass.dart';
import 'main.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController _tfNama = TextEditingController();
  TextEditingController _tfAvatar = TextEditingController();
  TextEditingController _tfAlamat = TextEditingController();
  TextEditingController _tfEmail = TextEditingController();
  TextEditingController _tfPekerjaan = TextEditingController();
  TextEditingController _tfQuote = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Widget Catalog",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Add Data Page"),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _tfNama,
                decoration: InputDecoration(
                  labelText: 'Masukan Nama',
                ),
              ),
              TextField(
                controller: _tfAvatar,
                decoration: InputDecoration(
                  labelText: 'Masukan Avatar',
                ),
              ),
              TextField(
                controller: _tfAlamat,
                decoration: InputDecoration(
                  labelText: 'Masukan Alamat',
                ),
              ),
              TextField(
                controller: _tfEmail,
                decoration: InputDecoration(
                  labelText: 'Masukan Email',
                ),
              ),
              TextField(
                controller: _tfPekerjaan,
                decoration: InputDecoration(
                  labelText: 'Masukan Pekerjaan',
                ),
              ),
              TextField(
                controller: _tfQuote,
                decoration: InputDecoration(
                  labelText: 'Masukan Quote',
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Data Berhasil Dihapus')));
                    cData data = cData(
                        cid: "",
                        cnama: _tfNama.text,
                        cavatar: _tfAvatar.text,
                        calamat: _tfAlamat.text,
                        cemail: _tfEmail.text,
                        cpekerjaan: _tfPekerjaan.text,
                        cquote: _tfQuote.text);
                    Navigator.pop(context, data);
                  },
                  child: Text('Submit')),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Back"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
