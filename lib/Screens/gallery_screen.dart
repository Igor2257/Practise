import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Galery extends StatefulWidget {
  const Galery({Key? key}) : super(key: key);

  @override
  State<Galery> createState() => _GaleryState();
}

class _GaleryState extends State<Galery> {
//List which contains data from API Unsplash response
  List data = [];

  _getData() async {
    http.Response response = await http.get(Uri.parse(
        'http://api.unsplash.com/photos/?client_id=SxKBVEK0FKaAZbw7MxTT-GP4H3T1o4GUZAYwJaOQbu0'));
    data = json.decode(response.body);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Gallery',
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int position) {
                var item = data[position];
                return Container(
                  height: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(4),
                        bottomLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                        topLeft: Radius.circular(4)),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.15),
                          offset: const Offset(0, 0),
                          spreadRadius: 4,
                          blurStyle: BlurStyle.normal)
                    ],
                  ),
                  margin: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Image.network(
                          item["urls"]["small"],
                          width: MediaQuery.of(context).size.width / 4,
                          height: MediaQuery.of(context).size.width / 4,
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext cont) {
                              return Stack(children: [
                               Align(alignment: Alignment.center,child:  Image.network(item["urls"]["full"])
                                   ,),
                                Align(alignment: Alignment.topRight,
                                  child:  Card(child:IconButton(
                                    icon: Icon(Icons.close,color: Colors.black,), onPressed: () {
                                    Navigator.of(context).pop();
                                  },),),
                                ),

                              ],);
                            },
                          );
                        }
                      ),
                      Text("${item["description"] != null
                          ? "Description:${item["description"]}"
                          : ""}",style: TextStyle(fontSize: 10)),
                      Text("Author: ${item["user"]["name"]}",style: TextStyle(fontSize: 14),),
                    ],
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
            ),
          ),
        ));
  }
}
