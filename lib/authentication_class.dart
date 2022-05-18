import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {

  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
  Future<String?> signIn({required String email, required String password}) async{
    print(email);
    print(password);
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      print("angemeldet");
          return "erfolgreich angemeldet";
    } on FirebaseAuthException catch (e){
      print("nix");
          return e.message;
    }

  }
  Future<String?> signUp({required String email, required String password}) async{
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
          return "Benutzer erstellt";
    } on FirebaseAuthException catch (e){
          return e.message;
    }
  }
}