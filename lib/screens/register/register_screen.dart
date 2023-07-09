
import 'package:chat/models/UserModel.dart';
import 'package:chat/screens/register/register%20controller/register_controller.dart';
import 'package:chat/screens/register/register%20services/register_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../login/loginscreen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final ser = RegisterServices();
  final control = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: control.formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Register',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    'Name',
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
                      controller: control.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name is Empty';
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIconColor: Colors.indigo,
                        prefixIcon: Icon(Icons.person),
                        border: InputBorder.none,
                        hintText: 'name',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
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
                      init: RegisterController(),
                      builder: (controller) => TextFormField(
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
                            onPressed: () {
                              control.changeObscure();
                            },
                            icon: control.obscure == false
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          ),
                          border: InputBorder.none,
                          hintText: 'at least 8 characters',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60.0,
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
                            control.isLoading = true;
                            try {
                              await ser.register(
                                email: control.email.text,
                                password: control.password.text,
                              );

                              await ser.addUserToFirebase(
                                  userModel: UserModel(
                                name: control.name.text,
                                email: control.email.text,
                                password: control.password.text,
                              ));

                              Get.offAll(LoginScreen());
                            } on FirebaseAuthException catch (e) {
                              Get.defaultDialog(
                                title: 'failed',
                                content: Text(e.code),
                              );
                            }
                            control.isLoading = false;
                          }
                        },
                        child: GetBuilder(
                            init: RegisterController(),
                            builder: (controller) => control.isLoading == false
                                ? Text(
                                    'Register',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'Loading...',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('have an account?'),
                      SizedBox(
                        width: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.offNamed('/');
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.indigo,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
