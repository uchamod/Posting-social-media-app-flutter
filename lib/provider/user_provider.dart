import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/service/authentication.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _currentUser;
  final Authentication _auth = Authentication();
  UserModel get getCurrentUser => _currentUser!;

// UserProvider() {
//   refreshUser();
//   }
  //refresh the user state when change was happend
  Future<void> refreshUser() async {
    UserModel currentUser = await _auth.getUserDetails();
    _currentUser = currentUser;
    notifyListeners();
  }
}
