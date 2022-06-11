import 'package:app_preiser/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authentication_class.dart';
import 'firebase_storage.dart';


class rechnung extends StatefulWidget {
  const rechnung({Key? key}) : super(key: key);

  @override
  State<rechnung> createState() => _rechnungState();
}

class _rechnungState extends State<rechnung> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text('BestellCount'),
        actions: <Widget>[
          IconButton(onPressed: (){
            context.read<AuthenticationService>().signOut(context);
          }, icon: Icon(Icons.power_off)),
        ],
      ),
      body:
      Image.network(context.read<AuthenticationService>().loadImage(context.read<AuthenticationService>().getuserID().toString()).toString()),
    );
  }
}

