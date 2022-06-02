import 'package:app_preiser/Homepage.dart';
import 'package:app_preiser/SignInPage.dart';
import 'package:app_preiser/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthenticationService {

  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  final databaseRef = FirebaseDatabase.instance.ref();

  Future<void> signOut(BuildContext context) async {
    //await _firebaseAuth.signOut();
    FirebaseAuth.instance.signOut();
    print("hops");
    //runApp(
    //    MaterialApp(
    //     home: SignInPage(),
    //    )
    //);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AuthenticationWrapper()));
  }
  Future<String?> signIn({required String email, required String password, required BuildContext context}) async{
    print(email);
    print(password);
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      print("angemeldet");
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AuthenticationWrapper()));
          return "erfolgreich angemeldet";
    } on FirebaseAuthException catch (e){
      print("nicht angemeldet");
          return e.message;
    }

  }
  Future<String?> signUp({required String email, required String password, required String Vorname, required String Nachname}) async{
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      datenEinfuegen(Vorname, Nachname, getuserID());
          return "Benutzer erstellt";
    } on FirebaseAuthException catch (e){
          return e.message;
    }
  }
  void datenEinfuegen(String Vorname, String Nachname, String? userID){
    databaseRef.child("Nutzer/$userID").set({
          "Vorname": Vorname,
          "Nachname": Nachname,

      }
    ) ;
  }
  String? getuserID(){
    final User? userx = _firebaseAuth.currentUser;
    final userID = userx?.uid;
    return userID;

  }

}

