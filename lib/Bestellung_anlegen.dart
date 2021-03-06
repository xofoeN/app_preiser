

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Homepage.dart';
import 'authentication_class.dart';
import 'main.dart';

class  bestellungAnlegen extends StatelessWidget {


  const bestellungAnlegen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final TextEditingController produktController = TextEditingController();

    final items = ["Lidl","Aldi","E-Center"];
    String? value;

    return Scaffold(
      appBar: AppBar(

        title: Text('BestellCount'),
        actions: <Widget>[
          IconButton(onPressed: (){
            context.read<AuthenticationService>().signOut(context);
          }, icon: Icon(Icons.power_off)),
        ],
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,

                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 120
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Produkte hinzufügen',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 35,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 50),
                      buildField('Gib deine Produkte ein',1, produktController,150),
                      SizedBox(height: 50),
                      RaisedButton(
                        onPressed: () {
                          context.read<AuthenticationService>().addProdukt(
                            produktController.text,
                            value.toString()
                          );
                          Navigator.of(context)
                              .push(
                              MaterialPageRoute(builder: (context) => HomePage())
                          );
                        },
                        child: Text("Bestellung anlegen"),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  DropdownMenuItem<String> buildMenuItem(String item)  =>
      DropdownMenuItem(value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
}