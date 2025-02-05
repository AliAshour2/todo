import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo/auth/models/user_data_model.dart';
import 'package:todo/common/remote/firebase_services.dart';

class TodoAuthProvider with ChangeNotifier {
  UserDataModel? user;
  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future login(String email, String password) async {
    setLoading(true);
    try {
      user = await FirebaseServices.login(email, password);
    } catch (e) {
      if (e is FirebaseAuthException) {
        Fluttertoast.showToast(
            msg: e.message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "There is an error try again later",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } finally {
      setLoading(false);
    }
  }

  Future signUp(UserDataModel user) async {
    setLoading(true);
    try {
      this.user = await FirebaseServices.register(UserDataModel(
        name: user.name,
        email: user.email,
        password: user.password,
      ));
    } catch (e) {
      if (e is FirebaseAuthException) {
        Fluttertoast.showToast(
            msg: e.message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "There is an error try again later",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } finally {
      setLoading(false);
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseServices.logout();
    } catch (e) {
      if (e is FirebaseAuthException) {
        Fluttertoast.showToast(
            msg: e.message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "There is an error try again later",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }
}
