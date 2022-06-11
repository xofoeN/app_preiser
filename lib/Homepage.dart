import 'package:app_preiser/rechnung.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Bestellung_anlegen.dart';
import 'Homepage.dart';
import 'authentication_class.dart';
import 'main.dart';


class HomePage extends StatelessWidget{


  final databaseRef = FirebaseDatabase.instance.ref().child("Bestellungen");

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text("Homepage"),
        actions: <Widget>[
          IconButton(onPressed: (){
            context.read<AuthenticationService>().signOut(context);
          }, icon: Icon(Icons.power_off)),
        ],
      ),
      body: SafeArea(
        child: FirebaseAnimatedList(
          query: databaseRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index){
            var daten = snapshot.value as Map?;

            return ListTile(
              onTap: () {
                Navigator.of(context)
                    .push(
                    MaterialPageRoute(builder: (context) => rechnung())
                );
              },
              title: Text(daten!["Name"]),
              subtitle: Text(daten!["Produkte"].toString().replaceAll(" \\n ", "\n")),
              trailing: IconButton(
                onPressed: (){
                  var keyFinder = snapshot.key;
                  print(keyFinder);
                },
              icon: Icon(Icons.delete),
              ),
            );
          },
        ),
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
              MaterialPageRoute(builder: (context) => const bestellungAnlegen())
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add_circle),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}