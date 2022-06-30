import 'package:app_preiser/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
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

  final Storage storage = Storage();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text('Rechnungen'),
        actions: <Widget>[
          IconButton(onPressed: (){
            context.read<AuthenticationService>().signOut(context);
          }, icon: Icon(Icons.power_off)),
        ],
      ),
     body: Column(
        children:[
        FutureBuilder(
          future: storage.listFiles(),
          builder: (BuildContext context, AsyncSnapshot<firebase_storage.ListResult> snapshot) {
            if(snapshot.connectionState == ConnectionState.done &&snapshot.hasData) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.items.length,
                  itemBuilder: (BuildContext context, int index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: (){},
                          child: Text(snapshot.data!.items[index].name),
                          ),
                    );
                  }
                ),
              );
            }
            if(snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData){
              return CircularProgressIndicator();
            }
            return Container();
          }
        ),
        FutureBuilder(
          future: storage.downloadURL(context.read<AuthenticationService>().getuserID().toString()),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if(snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            return Container(
              alignment: Alignment.center,
              width: 400,
              height: 250,
              child: Image.network(

                    snapshot.data!,
                    fit: BoxFit.cover,
              ));
            }
            if(snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData){
              return CircularProgressIndicator();
            }
              return Container();
          }
          )
        ],
     ),
    );
  }
}

