import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_7.dart';
import 'package:gsg_firebase/auth/helpers/firestore_helper.dart';
import 'package:gsg_firebase/auth/providers/auth_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gsg_firebase/utils/constants.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();

  List<Map> messages = [];

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  sendToFirestore() async {
    FirestoreHelper.firestoreHelper.addMessageToFirestore(
      {
        'message': messageController.text,
        'dateTime': DateTime.now(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Group Chat'),
        ),
        body: Consumer<AuthProvider>(
          builder: (context, value, child) {
            return Container(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 8.0,
                      ),
                      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        builder: (context, snapshot) {
                          messages = snapshot.data.docs.reversed
                              .map((e) => e.data())
                              .toList();
                          return messages.length == 0
                              ? Center(
                                  child: Text(
                                    'There is no message added here',
                                    style: TextStyle(
                                      color: colorPrimary,
                                      fontSize: 24.0,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  itemBuilder: (context, index) {
                                    bool isMe = messages[index]['userId'] ==
                                        Provider.of<AuthProvider>(context,
                                                listen: false)
                                            .myId;
                                    return isMe
                                        ? ChatBubble(
                                            clipper: ChatBubbleClipper7(
                                                type: BubbleType.sendBubble),
                                            alignment: Alignment.topRight,
                                            margin: EdgeInsets.only(top: 8.0),
                                            backGroundColor: colorPrimary,
                                            child: Container(
                                              constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.7,
                                              ),
                                              child: messages[index]
                                                          ['imageUrl'] ==
                                                      null
                                                  ? Text(
                                                      messages[index]
                                                          ['message'],
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )
                                                  : CachedNetworkImage(
                                                      imageUrl: messages[index]
                                                          ['imageUrl'],
                                                      placeholder: (context,
                                                              url) =>
                                                          CircularProgressIndicator(),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    ),
                                            ),
                                          )
                                        : ChatBubble(
                                            clipper: ChatBubbleClipper7(
                                                type:
                                                    BubbleType.receiverBubble),
                                            backGroundColor: Color(0xffE7E7ED),
                                            margin: EdgeInsets.only(top: 8.0),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.7,
                                              ),
                                              child: messages[index]
                                                          ['imageUrl'] ==
                                                      null
                                                  ? Text(
                                                      messages[index]
                                                          ['message'],
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    )
                                                  : CachedNetworkImage(
                                                      imageUrl: messages[index]
                                                          ['imageUrl'],
                                                      placeholder: (context,
                                                              url) =>
                                                          CircularProgressIndicator(),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    ),
                                            ),
                                          );
                                  },
                                  itemCount: messages.length,
                                  reverse: true,
                                );
                        },
                        stream: FirestoreHelper.firestoreHelper
                            .getFirestoreMessagesStream(),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade300,
                        filled: true,
                        hintText: 'Type a message...',
                        contentPadding: EdgeInsets.all(20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        prefixIcon: IconButton(
                          icon: Icon(Icons.image),
                          onPressed: () {
                            value.sendImageToChat();
                          },
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: colorPrimary,
                          ),
                          onPressed: () {
                            sendToFirestore();
                            messageController.clear();
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}
