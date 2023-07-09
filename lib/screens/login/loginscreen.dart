import 'package:chat/helper/shared.dart';
import 'package:chat/screens/login/services%20login/services_login.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../home/home_screen.dart';
import 'login controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final ser = ServicesLogin();
  final control = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: control.formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      'Login with your data that you register by it.',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.0,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextFormField(
                        controller: control.email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email is Empty';
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIconColor: Colors.indigo,
                          prefixIcon: Icon(Icons.email),
                          border: InputBorder.none,
                          hintText: 'email',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.0,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: GetBuilder(
                        init: LoginController(),
                        builder: (controller)=> TextFormField(
                          controller: control.password,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password is Empty';
                            }
                          },
                          obscureText: control.obscure,
                          keyboardType: TextInputType.visiblePassword,
                          cursorColor: Colors.indigo,
                          decoration: InputDecoration(
                            prefixIconColor: Colors.indigo,
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: ()
                              {
                                control.changeObscure();
                              },
                              icon: control.obscure == false
                                  ?Icon(Icons.visibility_off)
                                  :Icon(Icons.visibility)
                              ,
                            ),
                            border: InputBorder.none,
                            hintText: 'at least 8 characters',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      children: [
                        GetBuilder(
                          init: LoginController(),
                          builder: (controller)=> Checkbox(
                          activeColor: Colors.indigo,
                          onChanged: (value) {
                            control.changeCheck();
                          },
                          value: control.check,
                        ),),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Keep me logged in',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextButton(
                            onPressed: () async {
                              if (control.formKey.currentState!.validate()) {
                                if (control.check = true) {
                                  MyCache.setString(
                                      key: MyChachKey.email,
                                      value: control.email.text);
                                  MyCache.setString(
                                      key: MyChachKey.password,
                                      value: control.password.text);
                                }

                                try {
                                  await ser.signIn(
                                    email: control.email.text,
                                    password: control.password.text,
                                  );

                                  Get.offAll(MessageScreen());
                                } on FirebaseAuthException catch (e) {
                                  Get.defaultDialog(
                                    title: 'failed',
                                    content: Text(e.code),
                                  );
                                }
                              }
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Don\'t have an account?'),
                        SizedBox(
                          width: 10.0,
                        ),
                        GestureDetector(
                          onTap: ()
                          {
                            Get.offNamed('/register');
                          },
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                              color: Colors.indigo,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () async
                        {

                          try {

                            await ser.createWithGoogle();

                            Get.offAll(MessageScreen());
                          } on FirebaseAuthException catch (e) {
                            Get.defaultDialog(
                              title: 'failed',
                              content: Text(e.code),
                            );
                          }
                        },
                        child: Container(
                          width: 210,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey,width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Icon(
                                    FontAwesomeIcons.googlePlusG,
                                  color: Colors.redAccent,
                                ),
                                SizedBox(width: 12,),
                                Text(
                                  'Login with Google',
                                  style: TextStyle(
                                    fontSize: 18
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
