import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController
{
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool check = false ;
  bool obscure = true ;
  bool isLoading = false;
  changeObscure()
  {
    obscure = !obscure ;
    update();
  }
}