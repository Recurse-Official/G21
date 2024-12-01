import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final List<Map<String, String>> _users = [
    {
      'username': 'Dhruv_71',
      'email': 'dhruvnuti71@gmail.com',
      'phone': '7981714520',
      'password': '1234',
    },
  ];

  String? _loggedInUser;

  bool login(String identifier, String password) {
    for (var user in _users) {
      if ((user['email'] == identifier || user['username'] == identifier) &&
          user['password'] == password) {
        _loggedInUser = identifier;
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  void signup(String username, String email, String phone, String password) {
    _users.add({
      'username': username,
      'email': email,
      'phone': phone,
      'password': password,
    });
    _loggedInUser = email;
    notifyListeners();
  }

  void logout() {
    _loggedInUser = null;
    notifyListeners();
  }

  String? get loggedInUser => _loggedInUser;
}
