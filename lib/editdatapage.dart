// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'apiservices.dart';
import 'dataclass.dart';

class EditData extends StatefulWidget {
  final cData data;

  const EditData({Key? key, required this.data}) : super(key: key);

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  Service serviceAPI = Service();

  final TextEditingController _tfNama = TextEditingController();
  final TextEditingController _tfAvatar = TextEditingController();
  final TextEditingController _tfAlamat = TextEditingController();
  final TextEditingController _tfEmail = TextEditingController();
  final TextEditingController _tfPekerjaan = TextEditingController();
  final TextEditingController _tfQuote = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _tfNama.text = widget.data.cnama;
    _tfAvatar.text = widget.data.cavatar;
    _tfAlamat.text = widget.data.calamat;
    _tfEmail.text = widget.data.cemail;
    _tfPekerjaan.text = widget.data.cpekerjaan;
    _tfQuote.text = widget.data.cquote;
    return MaterialApp(
      title: "Widget Catalog",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Edit Data Page"),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              ClipOval(
                child: Image.network(
                  widget.data.cavatar,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
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
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    updateData(
                      widget.data.cid,
                      _tfNama.text,
                      _tfAvatar.text,
                      _tfAlamat.text,
                      _tfEmail.text,
                      _tfPekerjaan.text,
                      _tfQuote.text,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Data Berhasil Dihapus'),
                      ),
                    );
                    Navigator.pop(context);
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

  void updateData(
    String id,
    String nama,
    String avatar,
    String alamat,
    String email,
    String pekerjaan,
    String quote,
  ) async {
    bool response = await serviceAPI.updateData(
      id,
      nama,
      avatar,
      alamat,
      email,
      pekerjaan,
      quote,
    );
    
    if (response == true) {
      log("Data ${nama} berhasil di edit");
    } else {
      log("error = edit data ${nama}");
    }
  }
}
