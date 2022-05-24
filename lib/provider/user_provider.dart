import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum Status {Uninitialized, Authenticated, Authienticating, Unauthenticated}

class UserProvider with ChangeNotifier{
  FirebaseAuth _auth;
  User _user;
  Status _status = Status.Uninitialized;
  UserProvider.initialiae(): _auth = FirebaseAuth.instance{
    _auth.onAuthStateChanged.listen(_onStatehanged);
  }

  Status get status => _status;
  User get user => _user;
}

void _onStatehanged(User event) {
}


