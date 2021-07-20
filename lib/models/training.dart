import 'package:flutter/foundation.dart';

class Training {
  final String title, description, website, type, imageUrl, courseUrl;

  Training({
    @required this.title,
    @required this.description,
    @required this.website,
    @required this.type,
    @required this.imageUrl,
    @required this.courseUrl,
  });
}
