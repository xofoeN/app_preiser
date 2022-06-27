import 'package:app_preiser/Homepage.dart';
import 'package:app_preiser/authentication_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Homepage.dart';
import 'SignInPage.dart';


Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthenticationService>(
              create: (_) => AuthenticationService(FirebaseAuth.instance)
          ),
          
          StreamProvider(
              create: (context) => context.read<AuthenticationService>().authStateChanges, initialData: null,
          )
         ],
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: AuthenticationWrapper(),
          )
        );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if(firebaseUser != null){
      print("ja");
      return HomePage();
    }
      print("nein");
      return SignInPage();
  }
}


Widget buildField(var Text, int x, TextEditingController mailcontroller, double y) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 18),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0,2)
              )
            ]
        ),
        height: y,
        child: TextField(
          textInputAction: TextInputAction.newline,
          maxLines: null,
          expands: true,
          controller : mailcontroller,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.black87,
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
               prefixIcon: Icon(IconData(x, fontFamily: 'MaterialIcons')),
                hintText: Text,
                hintStyle: TextStyle(
                color: Colors.black38
              )
          ),
        ),
      )
    ],
  );


}
Widget buildPW(var Text, int x, TextEditingController mailcontroller, double y) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 18),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0,2)
              )
            ]
        ),
        height: y,
        child: TextField(
          obscureText: true,
          controller : mailcontroller,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.black87,
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(IconData(x, fontFamily: 'MaterialIcons')),
              hintText: Text,
              hintStyle: TextStyle(
                  color: Colors.black38
              )
          ),
        ),
      )
    ],
  );


}