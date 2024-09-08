
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_cards_new/data/firestore_database.dart';
import 'package:flash_cards_new/screens/authenticate/registration_screen.dart';
import 'package:flash_cards_new/utilities/constants.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

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
      prefs!.setString(AppConstants.kBoxPreferenceKey, user!.uid);
      print('opening ${user.uid}');
      await Hive.openBox(user.uid);
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
      prefs!.setString(AppConstants.kBoxPreferenceKey, user.uid);
      await Hive.openBox(user.uid);
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

// sign out
  Future signOut() async {
    prefs!.remove(AppConstants.kBoxPreferenceKey);
    await Hive.close();
    print('hive boxes closed');
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}