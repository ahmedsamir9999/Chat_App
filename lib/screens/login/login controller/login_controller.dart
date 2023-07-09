import 'package:chat/helper/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController
{
  TextEditingController email = TextEditingController(text: MyCache.getString(key: MyChachKey.email));
  TextEditingController password = TextEditingController(text: MyCache.getString(key: MyChachKey.password));
  var formKey = GlobalKey<FormState>();
  bool check = false ;
  bool obscure = true ;


  changeObscure()
  {
    obscure = !obscure ;
    update();
  }

  changeCheck()
  {
    check = !check ;
    update();
  }
}