import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_learning/constants.dart';
import 'package:smart_learning/models/lesson.dart';
import 'package:smart_learning/models/subject.dart';

// ignore: must_be_immutable
class StLessonScreen extends StatelessWidget {
  final Subject subject;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  StLessonScreen({@required this.subject});

  @override
  Widget build(BuildContext context) {
    //print(subject.id);
    return Scaffold(
      appBar: AppBar(
        title: Text('${subject.title} - Grade ${subject.grade}'),
        backgroundColor: kBrightBlueColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('lessons').snapshots(),
          builder: (context, snapshots) {
            if (!snapshots.hasData) {
              return CircularProgressIndicator(
                backgroundColor: kBrightBlueColor,
              );
            }

            final lessons = snapshots.data.docs.reversed.where((element) =>
                element.get('subject_id').toString() == subject.id);
            if (lessons.isEmpty)
              return Container(
                child: Center(
                  child: Text(
                    'No lessons available...',
                    style: kGradeTitleStyle.copyWith(
                      color: kBrownishGreyColor.withOpacity(0.5),
                    ),
                  ),
                ),
              );
            List<ListTile> lessonItems = [];
            int i = 1;
            for (var lesson in lessons) {
              Lesson currentLesson = Lesson(
                title: lesson.get('title').toString().trim(),
                date: lesson.get('date').toString(),
                body: lesson.get('body').toString().trim(),
                id: lesson.get('id').toString(),
                subjectId: lesson.get('subject_id').toString(),
              );

              bool hasLongTitle = currentLesson.title.trim().length > 17;
              bool hasLongBody = currentLesson.body.length > 20;
              lessonItems.add(
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: kBrightBlueColor,
                    child: Center(
                      child: Text(
                        '$i',
                        style:
                            kCardTitleStyle.copyWith(fontSize: 40, height: 1),
                      ),
                    ),
                    radius: 30,
                  ),
                  title: Text(
                    "${currentLesson.title.substring(0, hasLongTitle ? 15 : currentLesson.title.length)}" +
                        "${hasLongTitle ? '...' : ''}",
                    style: kCardTitleStyle.copyWith(color: kBrightBlueColor),
                  ),
                  subtitle: Text(
                    "${currentLesson.body.substring(0, hasLongBody ? 20 : currentLesson.body.length)}" +
                        "${hasLongBody ? '...' : ''}",
                    style: kCardSubTitleStyle.copyWith(color: kBrightBlueColor),
                  ),
                  trailing: TextButton(
                    child: Text("View"),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 20.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'L$i: ${currentLesson.title}',
                                    style: kArticleTitleStyle.copyWith(
                                        fontSize: 32.0),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    '${subject.title} - Grade ${subject.grade}',
                                    style: kArticleTitleStyle.copyWith(
                                      fontSize: 16.0,
                                      fontFamily: 'Raleway-Regular',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    '${currentLesson.body}',
                                    style: kArticleTitleStyle.copyWith(
                                      fontSize: 20.0,
                                      fontFamily: 'Raleway-Medium',
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              );
              i++;
            }
            i = 1;
            return ListView.builder(
                itemCount: lessonItems.length,
                itemBuilder: (context, n) => lessonItems[n]);
          },
        ),
      ),
    );
  }
}
