import 'package:app_preiser/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'authentication_class.dart';

class  SignInPage extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController vornameController = TextEditingController();
  final TextEditingController nachnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('BestellCount'),
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
                      Text(
                        'Log-In',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 50),
                      buildField("E-Mail", 0xf705, emailController,60),
                      buildField("Passwort", 0xf04b6, passwordController,60),
                      SizedBox(height: 25),
                      RaisedButton(
                        onPressed: () {
                          context.read<AuthenticationService>().signIn(
                            email: emailController.text,
                            password: passwordController.text,
                            context:context,
                          );
                        },
                        child: Text("anmelden"),
                      ),
                      SizedBox(height: 50),
                      Text(
                        'Registrieren',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      buildField("Vorname", 0xf04b6, vornameController,60),
                      buildField("Nachname", 0xf04b6, nachnameController,60),
                      buildField("E-Mail", 0xf705, emailController,60),
                      buildField("Passwort", 0xf04b6, passwordController,60),
                      SizedBox(height: 25),
                      RaisedButton(
                        onPressed: () {
                          context.read<AuthenticationService>().signUp(
                            email: emailController.text,
                            password: passwordController.text,
                            Vorname: vornameController.text,
                            Nachname: nachnameController.text,
                          );
                        },
                        child: Text("registrieren"),
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
}