import 'package:flutter/material.dart';
import 'package:smart_learning/constants.dart';

class MessageWidget extends StatelessWidget {
  final text, sender;
  final bool isMe;
  MessageWidget({
    @required this.isMe,
    @required this.text,
    @required this.sender,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Wrap(
          alignment: isMe ? WrapAlignment.end : WrapAlignment.start,
          children: [
            Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    sender,
                    style: TextStyle(
                      color: kBrightBlueColor,
                      fontFamily: 'Raleway-Regular',
                      fontSize: 10.0,
                    ),
                  ),
                  Material(
                    borderRadius: BorderRadius.only(
                        topLeft:
                            isMe ? Radius.circular(30.0) : Radius.circular(0),
                        topRight:
                            isMe ? Radius.circular(0) : Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0)),
                    color: isMe ? kBrightBlueColor : Colors.white,
                    elevation: 5.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: isMe ? Colors.white : kBrightBlueColor,
                        ),
                      ),
                    ),
                  ),
                ]),
          ]),
    );
  }
}
