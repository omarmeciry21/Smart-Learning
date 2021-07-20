import 'package:flutter/foundation.dart';

class Message {
  final String date, sender, subjectId, text;

  Message({
    @required this.date,
    @required this.sender,
    @required this.subjectId,
    @required this.text,
  });
}
