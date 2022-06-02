// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'apiservices.dart';
import 'dataclass.dart';
import 'detaildatapage.dart';

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
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    _tfNama.text = widget.data.cnama;
    _tfAvatar.text = widget.data.cavatar;
    _tfAlamat.text = widget.data.calamat;
    _tfEmail.text = widget.data.cemail;
    _tfPekerjaan.text = widget.data.cpekerjaan;
    _tfQuote.text = widget.data.cquote;
    return MaterialApp(
      title: "Widget Catalog",
      home: Scaffold(
        key: scaffoldKey,
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

                    cData isiData = cData(
                        cid: widget.data.cid,
                        cnama: _tfNama.text,
                        cavatar: _tfAvatar.text,
                        calamat: _tfAlamat.text,
                        cemail: _tfEmail.text,
                        cpekerjaan: _tfPekerjaan.text,
                        cquote: _tfQuote.text);

                    ScaffoldMessenger.of(scaffoldKey.currentContext!)
                        .showSnackBar(
                      SnackBar(
                        content: Text('Data ${_tfNama.text} Berhasil Diedit'),
                        onVisible: () {
                          Future.delayed(const Duration(milliseconds: 200), () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Detail(data: isiData);
                                },
                              ),
                            );
                          });
                        },
                      ),
                    );
                    // Navigator.pop(context, widget.data);]
                  },
                  child: Text('Submit')),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Detail(data: widget.data);
                      },
                    ),
                  );
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
