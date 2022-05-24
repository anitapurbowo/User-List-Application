// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:networking/adddatapage.dart';
import 'package:networking/detaildatapage.dart';
import 'apiservices.dart';
import 'dataclass.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Widget Catalog',
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Service serviceAPI = Service();
  late Future<List<cData>> listData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listData = serviceAPI.getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Widget Catalog",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Coba Widget"),
        ),
        body: Column(
          children: [
            FutureBuilder<List<cData>>(
              future: listData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<cData> isiData = snapshot.data!;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ListView.builder(
                        itemCount: isiData.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: UniqueKey(),
                            background: Container(
                              padding: EdgeInsets.only(left: 8),
                              alignment: Alignment.centerLeft,
                              color: Colors.red,
                              child: Icon(Icons.cancel),
                            ),
                            secondaryBackground: Container(
                              padding: EdgeInsets.only(right: 8),
                              alignment: Alignment.centerRight,
                              color: Colors.red,
                              child: Icon(Icons.cancel),
                            ),
                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.endToStart) {
                                return true;
                              } else {
                                return true;
                              }
                            },
                            onDismissed: (direction) {
                              deleteData(isiData[index].cid);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Data ${isiData[index].cnama} berhasil dihapus',
                                  ),
                                ),
                              );
                              setState(() {
                                isiData.removeAt(index);
                              });
                            },
                            child: ListTile(
                              title: Text(isiData[index].cnama),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  isiData[index].cavatar,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("ID : " + isiData[index].cid),
                                  Text("Alamat : " + isiData[index].calamat),
                                  Text("Email : " + isiData[index].cemail),
                                  Text("Pekerjaan : " + isiData[index].cpekerjaan),
                                  Text("Quote : " + isiData[index].cquote),
                                ],
                              ),
                              onTap: () {
                                showData(isiData[index].cid);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Detail(
                                        data: isiData[index],
                                      );
                                    },
                                  ),
                                );
                              },
                              onLongPress: () {
                                deleteData(isiData[index].cid);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Data ${isiData[index].cnama} berhasil dihapus',
                                    ),
                                  ),
                                );
                                setState(() {
                                  isiData.removeAt(index);
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: const CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            cData data = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddData(),
              ),
            );
            addData(data.cnama, data.cavatar, data.calamat, data.cemail,
                data.cpekerjaan, data.cquote);

            //tambahData();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void tambahData() async {
    bool response = await serviceAPI.postData(
        'pnama', 'pavatar', 'palamat', 'pemail', 'ppekerjaan', 'pquote');

    if (response == true) {
      setState(() {
        listData = serviceAPI.getAllData();
      });
    }
  }

  void showData(String id) async {
    cData response = await serviceAPI.getSingleData(id);
    log("data = ${response.cnama} - ${response.cavatar} - ${response.calamat} - ${response.cemail} - ${response.cpekerjaan} - ${response.cquote}");
  }

  void deleteData(String id) async {
    bool response = await serviceAPI.deleteData(id);
    if (response == true) {
      setState(() {
        listData = serviceAPI.getAllData();
      });
      log("Data telah dihapus");
    } else {
      log("error = data tidak dihapus");
    }
  }

  void addData(String nama, String avatar, String alamat, String email,
      String pekerjaan, String quote) async {
    bool response = await serviceAPI.postData(
        nama, avatar, alamat, email, pekerjaan, quote);
    if (response == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Data berhasil ditambahkan',
          ),
        ),
      );
      setState(() {
        listData = serviceAPI.getAllData();
      });
    }
  }
}
