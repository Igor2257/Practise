import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:practise/Screens/gallery_screen.dart';


void main(List<String> args) async {

  runApp(const Starting());

}

class Starting extends StatelessWidget {
  const Starting({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Galery(),
      },
    );
  }

}




