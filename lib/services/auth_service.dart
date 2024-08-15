import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_cards_new/data/firestore_database.dart';
import 'package:flash_cards_new/screens/authenticate/registration_screen.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirestoreDatabase _firestoreDatabase = FirestoreDatabase();

  // auth change user stream
  Stream<User?> get authStateChanges {
    return _auth.authStateChanges();
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

// register with email and password
  Future registerWithEmailAndPassword(String email, String password, String nickName, UserRoles role) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      _firestoreDatabase.addUser(nickName, user!.uid, email, role);
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

// sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}