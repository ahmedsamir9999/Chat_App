import 'dart:io';

import 'package:chat/models/MessageModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MessageService {
  final auth = FirebaseAuth.instance;
  final cloudStorage = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance ;


  Stream<QuerySnapshot<Object?>> messageCloud = FirebaseFirestore.instance
      .collection('message')
      .orderBy('time',descending: true)
      .snapshots();

  addMessage({
    // required MessageModel messageModel,
    String? imageUrl ,
    required String message
  }) async {
    await cloudStorage.collection('messages').add(
      // MessageModel().toJson()
        {
          'message': message,
          'id': auth.currentUser?.uid,
          'time': DateTime.now().toString(),
          'imageUrl': imageUrl
        }
    );
  }

  addImageToChat({
    required String imageUrl, String? message }) async
  {
    await cloudStorage.collection('messages').add(
      // MessageModel().toJson()
        {
          'message': message,
          'imageUrl': imageUrl,
          'id': auth.currentUser?.uid,
          'time': DateTime.now().toString()
        }
    );
  }


  Future<String> uploadImageToFirebaseStorage ({required String imagePath , required imageName }) async
  {
    final path = storage.ref().child('Image In Chat / ${DateTime.now().toString()}');
    final uploadImage =  path.putFile(File(imagePath.toString()));
    final imageUrl = (await(await uploadImage).ref.getDownloadURL()).toString() ;
    return imageUrl ;
  }

}
