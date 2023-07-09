import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../models/UserModel.dart';


class RegisterServices {
  final auth = FirebaseAuth.instance;
  final cloudStore = FirebaseFirestore.instance;

  register({required String email, required String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Get.defaultDialog(
        title: 'failed',
        content: Text(e.code),
      );
    }
  }


  addUserToFirebase({required UserModel userModel}) async {
    await cloudStore
        .collection('users')
        .doc('${auth.currentUser?.uid}')
        .set(userModel.toJson());
  }

}
