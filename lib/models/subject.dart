import 'package:flutter/foundation.dart';

class Subject {
  final String title, imageUrl;
  final String grade;
  final String id;

  Subject(
      {@required this.title,
      @required this.grade,
      @required this.imageUrl,
      @required this.id});
}
