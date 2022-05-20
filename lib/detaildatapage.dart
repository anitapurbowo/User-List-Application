import 'package:flutter/material.dart';
import 'package:networking/dataclass.dart';
import 'apiservices.dart';
import 'main.dart';

class Detail extends StatefulWidget {
  final cData data;

  const Detail({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Widget Catalog",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Detail Page"),
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Card(
                child: ListTile(
                  title: Text(widget.data.cnama),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(widget.data.cavatar),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ID : " + widget.data.cid),
                      Text("Nama : " + widget.data.cnama),
                      Text("Alamat : " + widget.data.calamat),
                      Text("Email : " + widget.data.cemail),
                      Text("Pekerjaan : " + widget.data.cpekerjaan),
                      Text("Quote : " + widget.data.cquote),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8,
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
