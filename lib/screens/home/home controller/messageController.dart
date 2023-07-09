import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../home services/message_services.dart';

class MessageController extends GetxController
{
  ScrollController? control ;
  File? image;
  final ser = MessageService();



  pickImage() async {
    final imagePick =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    image = File(imagePick!.path);

  }


  Future<String> uploadImageToFirebaseStorage ({
   // required String imagePath ,
    required imageName
  }) async
  {

    // final imagePick =
    // await ImagePicker().pickImage(source: ImageSource.gallery);
    // image = File(imagePick!.path);

    final path = ser.storage.ref().child('message image / ${imageName.toString()}');
    final uploadImage =  path.putFile(File(image!.path.toString()));
    final imageUrl = (await(await uploadImage).ref.getDownloadURL()).toString() ;
    return imageUrl ;

  }


}