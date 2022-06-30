import 'package:app_preiser/Bestellung_2.dart';
import 'package:app_preiser/rechnung.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authentication_class.dart';
import 'firebase_storage.dart';



class HomePage extends StatelessWidget{

  final Storage storage = Storage();
  final databaseRef = FirebaseDatabase.instance.ref().child("Bestellungen");


  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text("Homepage"),
        actions: <Widget>[
          IconButton(onPressed: (){
            context.read<AuthenticationService>().clearBestellung();
          }, icon: Icon(Icons.shopping_cart)
          ),
          IconButton(onPressed: () async {
              final result = await FilePicker.platform.pickFiles(
                  allowMultiple: false,
                  type: FileType.custom,
                  allowedExtensions: ['png','jpg']
              );
                if(result == null){
                  ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No file selected'),
                ),
                  );
              return null;
              }

              final path = result?.files.single.path!;
              final fileName = context.read<AuthenticationService>().getuserID().toString();

              storage
                  .upLoadFile(path!, fileName)
                  .then((value) => print('Done')
                );
              },
              icon: Icon(Icons.upload_file)
          ),
          IconButton(onPressed: (){
            Navigator.of(context)
                .push(
                MaterialPageRoute(builder: (context) => rechnung())
            );
          }, icon: Icon(Icons.document_scanner)
          ),
          IconButton(onPressed: (){
            context.read<AuthenticationService>().signOut(context);
          }, icon: Icon(Icons.power_off)
          ),
        ],
      ),
      body: SafeArea(
        child:
        FirebaseAnimatedList(
          query: databaseRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index){
            var daten = snapshot.value as Map?;
            return ListTile(

              title: Text(daten!["Name"],style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("Geschäft: "+daten!["laden"].toString()+"\n \n"+daten!["Produkte"].toString().replaceAll(" \\n ", "\n")),
              trailing: FlatButton.icon(onPressed: (){
                context.read<AuthenticationService>().clearBestellungUID(context, daten!["id"].toString());
              },
                  icon: Icon(Icons.delete), label: Text("Bestellung löschen")),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(0),
              ),
            );
          },
        ),
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
              MaterialPageRoute(builder: (context) => const bestellungenstfl())
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add_circle),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}