import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'Homepage.dart';
import 'authentication_class.dart';
import 'main.dart';

class bestellungenstfl extends StatefulWidget {
  const bestellungenstfl({Key? key}) : super(key: key);

  @override
  State<bestellungenstfl> createState() => _bestellungenstlState();
}


class _bestellungenstlState extends State<bestellungenstfl> {

  final TextEditingController produktController = TextEditingController();

  final items = ["Lidl","Aldi","E-Center"];
  String? value;

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
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,

                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
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
                      const SizedBox(height: 50),
                      buildField('Gib deine Produkte ein',1, produktController,150),
                      const SizedBox(height: 25),
                      DropdownButton<String>(
                        value: value,
                        hint: Text("Laden"),
                        items: items.map(buildMenuItem).toList(),
                        onChanged: (value) => setState(() => this.value = value),
                      ),
                      const SizedBox(height: 50),
                      RaisedButton(
                        onPressed: () {
                          context.read<AuthenticationService>().addProdukt(
                              produktController.text,
                              value
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
