import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_learning/constants.dart';
import 'package:smart_learning/models/message.dart';
import 'package:smart_learning/models/subject.dart';
import 'package:smart_learning/widgets/message_widget.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;

class ChatRoomViewScreen extends StatelessWidget {
  final Subject subject;
  final TextEditingController messageController = TextEditingController();

  void addMessage() {
    _firestore.collection('messages').add({
      'sender': _auth.currentUser.email.toString(),
      'date': DateTime.now().toString(),
      'text': messageController.text.toString(),
      'subject_id': subject.id.toString()
    });
    messageController.clear();
  }

  ChatRoomViewScreen({@required this.subject});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${subject.title} - Grade ${subject.grade}',
          style: kCardTitleStyle.copyWith(fontSize: 25.0),
        ),
        backgroundColor: kBrightBlueColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MessageStream(subjectId: subject.id),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your message...'),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      addMessage();
                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: kBrightBlueColor,
                      child: Icon(
                        Icons.send_rounded,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  final String subjectId;
  MessageStream({@required this.subjectId});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('date').snapshots(),
      builder: (context, snapshots) {
        if (!snapshots.hasData) {
          return Expanded(
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: kBrightBlueColor,
              ),
            ),
          );
        }

        final messages = snapshots.data.docs.reversed.where(
            (element) => element.get('subject_id').toString() == subjectId);
        List<MessageWidget> messageList = [];
        for (var message in messages) {
          Message currentMessage = Message(
            date: message.get('date').toString(),
            sender: message.get('sender').toString(),
            subjectId: message.get('subject_id').toString(),
            text: message.get('text').toString(),
          );
          messageList.add(MessageWidget(
              isMe: _auth.currentUser.email == currentMessage.sender,
              text: currentMessage.text,
              sender: currentMessage.sender));
        }
        return messageList.isNotEmpty
            ? Expanded(
                child: ListView.builder(
                  itemCount: messageList.length,
                  reverse: true,
                  itemBuilder: (context, n) => messageList[n],
                ),
              )
            : Container(
                width: double.infinity,
                child: Text(
                  'No Messages yet...',
                  textAlign: TextAlign.center,
                  style: kGradeTitleStyle.copyWith(
                    color: kBrownishGreyColor.withOpacity(0.5),
                  ),
                ),
              );
      },
    );
  }
}
