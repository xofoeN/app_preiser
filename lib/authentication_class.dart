
import 'package:app_preiser/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';


class AuthenticationService {

  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  final databaseRef = FirebaseDatabase.instance.ref();

  Future<void> signOut(BuildContext context) async {
    //await _firebaseAuth.signOut();
    FirebaseAuth.instance.signOut();
    print("hops");
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => AuthenticationWrapper()));
  }

  Future<String?> signIn(
      {required String email, required String password, required BuildContext context}) async {
    print(email);
    print(password);
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print("angemeldet");
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => AuthenticationWrapper()));
      return "erfolgreich angemeldet";
    } on FirebaseAuthException catch (e) {
      print("nicht angemeldet");
      showAlertDialog(context, "Bitte überprüfe deine E-Mail und das Passwort", "Anmeldung fehlgeschlagen");
      return e.message;
    }
  }

  Future<String?> signUp(
      {required String email, required String password, required String Vorname, required String Nachname}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      datenEinfuegen(Vorname, Nachname, getuserID());
      return "Benutzer erstellt";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  void datenEinfuegen(String Vorname, String Nachname, String? userID) {
    databaseRef.child("Nutzer/$userID").set({
      "Vorname": Vorname,
      "Nachname": Nachname,

    }
    );
  }

  String? getuserID() {
    final User? userx = _firebaseAuth.currentUser;
    final userID = userx?.uid;
    return userID;
  }


  Future<void> addProdukt(String produkt, String? laden) async {
    var changeString = produkt.replaceAll("\n", " \\n ");
    var userID = getuserID();

    final snapshot = await databaseRef.child('Nutzer/$userID/Vorname').get();

    databaseRef.child("Bestellungen/$userID").set({
      "Name": snapshot.value,
      "Produkte": changeString,
      "laden": laden,
      "id": getuserID(),
    }
    );
  }

  Future<String> loadImage(String userID) async {
    final ref = FirebaseStorage.instance.ref().child('files///$userID');
    var url = await ref.getDownloadURL();
    print(url);
    return url;
  }

  deleteFolder(path) {
    final ref = FirebaseStorage.instance.ref().child('files/');
  }

  Future clearBestellung() async {
    databaseRef.child("Bestellungen").remove();
    return await FirebaseStorage.instance.ref().child('').delete();
  }

  Future clearBestellungUID(BuildContext context, String userID) async {
    if(userID != getuserID()) {
      showAlertDialog(context, "Du kannst keine Bestellungen anderer löschen", "löschen fehlgeschlagen");
      return;
    } else {
      print(userID);
      databaseRef.child("Bestellungen/$userID").remove();
      return await FirebaseStorage.instance.ref().child('').delete();
    }
  }

  showAlertDialog(BuildContext context, String text, String title) {

    // set up the button
    Widget okButton = TextButton(
      style: TextButton.styleFrom(
        primary: Colors.green,
      ),
      child: Text("OK"),
      onPressed: () => Navigator.pop(context),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(text),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
