import 'package:flutter/foundation.dart';

class Lesson {
  final String title, id, body, subjectId, date;

  Lesson({
    @required this.title,
    @required this.date,
    @required this.body,
    @required this.id,
    @required this.subjectId,
  });
}
