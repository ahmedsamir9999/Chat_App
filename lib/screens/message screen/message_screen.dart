import 'package:chat/customs/custom_image.dart';
import 'package:chat/customs/custom_message.dart';
import 'package:chat/models/MessageModel.dart';

import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'message controller/messageController.dart';
import 'message services/message_services.dart';

class MessageScreen extends StatelessWidget {
  MessageScreen({super.key});

  final ser = MessageService();
  final control = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          GetBuilder(
              init: MessageController(),
              builder: (controller) => StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('messages')
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<MessageModel> messages = [];
                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        messages
                            .add(MessageModel.fromJson(snapshot.data?.docs[i]));
                      }
                      print(messages.length);
                      print(snapshot.data!.docs.length);
                      return Expanded(
                        child: ListView.builder(
                          reverse: true,
                          controller: controller.control,
                          itemCount: messages.length,
                          itemBuilder: (context, index) => messages[index].id ==
                              ser.auth.currentUser?.uid
                              ? messages[index].imageUrl?.isNotEmpty == true
                              ? CustomImage(
                            imageUrl: messages[index].imageUrl,
                            alin: Alignment.bottomRight,
                          )
                              : Align(
                            alignment: Alignment.bottomRight,
                            child: CustomMessage(
                              message: messages[index].message,
                              bottomRight: 0,
                              paddingRight: 10,
                            ),
                          )
                              : messages[index].imageUrl?.isNotEmpty == true
                              ? GestureDetector(
                            onTap: () {
                              Get.defaultDialog(
                                  content: Expanded(
                                    child: Image.network(
                                      messages[index].imageUrl.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ));
                            },
                            child: CustomImage(
                              imageUrl: messages[index].imageUrl,
                              alin: Alignment.bottomLeft,
                            ),
                          )
                              : Align(
                            alignment: Alignment.bottomLeft,
                            child: CustomMessage(
                              message: messages[index].message,
                              bottomLeft: 0,
                              paddingLift: 10,
                              color: Colors.grey,
                              textColor: Colors.black,
                            ),
                          ),
                        ),
                      );
                    }
                    return const Expanded(
                      child: Center(
                        child: Text('Loding...'),
                      ),
                    );
                  })),
          MessageBar(
            onSend: (value) async {
              await ser.addMessage(
                //     messageModel: MessageModel(
                //   message: value.toString() ,
                //   id: ser.auth.currentUser?.uid,
                //   time: DateTime.now().toString(),
                // )
                  message: value);
              control.control?.animateTo(
                0,
                duration: Duration(seconds: 1),
                curve: Curves.easeIn,
              );
            },
            actions: [
              InkWell(
                onTap: () {},
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 24,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: InkWell(
                  onTap: () async {
                    showModalBottomSheet(
                      clipBehavior: Clip.antiAlias,
                      constraints: BoxConstraints.tightForFinite(
                          height: 100, width: 400),
                      context: context,
                      builder: (context) => Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              control.image = null;
                              await control.pickImageFromCamera();
                              Navigator.pop(context);
                              await ser.addImageToChat(
                                  imageUrl: await control
                                      .uploadImageToFirebaseStorage(
                                      imageName:
                                      DateTime.now().toString()));
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.camera,
                                  size: 40,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('camera',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () async {
                              control.image = null;
                              await control.pickImageFromGallery();
                              Navigator.pop(context);
                              await ser.addImageToChat(
                                  imageUrl: await control
                                      .uploadImageToFirebaseStorage(
                                      imageName:
                                      DateTime.now().toString()));
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.photo_camera_back_outlined,
                                  size: 40,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Gallery',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );

                    // control.image = null;
                    //  await control.pickImage();
                    // await ser.addImageToChat(
                    //     imageUrl: await control.uploadImageToFirebaseStorage(
                    //         imageName: DateTime.now().toString()));
                  },
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
