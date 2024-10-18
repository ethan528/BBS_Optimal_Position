import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx/screens/login.dart';
import 'package:get/get.dart';

import '../screens/welcome.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth authentication = FirebaseAuth.instance;
  late RxBool isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(authentication.currentUser);
    _user.bindStream(authentication.userChanges());
    ever(_user, _moveToPage);
  }

  User? get user => _user.value;

  _moveToPage(User? user) {
    if (user == null) {
      Get.offAll(() => LoginPage());
    } else {
      Get.offAll(() => WelcomePage());
    }
  }

  void register(String email, password) async {
    try {
      isLoading.value = true;
      await authentication.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      Get.snackbar(
        'Error message',
        'User message',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          'Registration is failed',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        messageText: Text(
          e.toString(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    authentication.signOut();
  }

  void login(String email, String password) async {
    try {
      isLoading.value = true;
      await authentication.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error message',
        'User message',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          'Login failed',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        messageText: Text(
          e.toString(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
