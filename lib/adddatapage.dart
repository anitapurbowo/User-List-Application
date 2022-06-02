// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'apiservices.dart';
import 'dataclass.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final TextEditingController _tfNama = TextEditingController();
  final TextEditingController _tfAvatar = TextEditingController();
  final TextEditingController _tfAlamat = TextEditingController();
  final TextEditingController _tfEmail = TextEditingController();
  final TextEditingController _tfPekerjaan = TextEditingController();
  final TextEditingController _tfQuote = TextEditingController();

  Service serviceAPI = Service();

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
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    cData data = cData(
                      cid: "",
                      cnama: _tfNama.text,
                      cavatar: _tfAvatar.text,
                      calamat: _tfAlamat.text,
                      cemail: _tfEmail.text,
                      cpekerjaan: _tfPekerjaan.text,
                      cquote: _tfQuote.text,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Data Berhasil Ditambahkan'),
                      ),
                    );
                    addData(data.cnama, data.cavatar, data.calamat, data.cemail, data.cpekerjaan, data.cquote);
                    Navigator.pop(context,'1');
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

  void addData(String nama, String avatar, String alamat, String email,
      String pekerjaan, String quote) async {
    bool response = await serviceAPI.postData(
        nama, avatar, alamat, email, pekerjaan, quote);
    if (response == true) {
      log("Data berhasil ditambahkan");
    } else {
      log("error = data gagal ditambahkan");
    }
  }
}
