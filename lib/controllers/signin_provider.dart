import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AnonymousSignInProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserCredential? _user;

  UserCredential get user => _user!;

  Future signInAnonymously() async {
    try {
      final anonymousUser = await _auth.signInAnonymously();
      _user = anonymousUser;
      User? person = anonymousUser.user;
      if (person != null) {
        if (anonymousUser.additionalUserInfo!.isNewUser) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(person.uid)
              .set({});
        }
      }
      notifyListeners();
    } catch (e) {
      const SnackBar(
        content: Text("There was an error!"),
      );
    }
  }

  Future logOut() async {
    try {
      await _auth.signOut();
      notifyListeners();
    } catch (e) {
      const SnackBar(
        content: Text("There was an error!"),
      );
    }
  }
}
