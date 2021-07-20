import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_learning/constants.dart';
import 'package:smart_learning/models/subject.dart';
import 'package:smart_learning/screens/chat/chat_room_view_screen.dart';

class ChatRoomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 12.0,
                ),
                child: Column(
                    children: kGrades
                        .map((e) => ChatSectionWidget(
                              grade: e,
                            ))
                        .toList()))));
  }
}

class ChatSectionWidget extends StatelessWidget {
  ChatSectionWidget({Key key, @required this.grade}) : super(key: key);

  final int grade;
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Grade $grade',
              style: kGradeTitleStyle,
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('subjects_info').snapshots(),
              builder: (context, snapshots) {
                List<Widget> subjectCards = [];
                if (!snapshots.hasData) {
                  return CircularProgressIndicator(
                      backgroundColor: kBrightBlueColor);
                }

                final subjects = snapshots.data.docs.reversed;
                for (var subject in subjects
                    .where((element) => element.get('grade') == grade)) {
                  Subject currentSubject = Subject(
                    title: subject.get('title').toString(),
                    grade: subject.get('grade').toString(),
                    imageUrl: subject.get('imageUrl').toString(),
                    id: subject.get('id').toString(),
                  );
                  subjectCards.add(
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ChatRoomViewScreen(subject: currentSubject),
                          ),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: ListTile(
                            title: Text(
                              currentSubject.title,
                              style: kCardTitleStyle.copyWith(
                                  color: kBrightBlueColor, fontSize: 20),
                            ),
                            subtitle: Text(
                              'Grade: ' + currentSubject.grade,
                              style: kCardSubTitleStyle.copyWith(
                                  color: kBrightBlueColor, fontSize: 12),
                            ),
                            leading: CircleAvatar(
                              child: Icon(
                                Icons.people,
                                color: Colors.white,
                                size: 30,
                              ),
                              backgroundColor: kBrightBlueColor,
                              radius: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return subjectCards.isNotEmpty
                    ? Container(
                        width: double.infinity,
                        height: 150,
                        child: ListView.builder(
                          itemCount: subjectCards.length,
                          itemBuilder: (context, n) => subjectCards[n],
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        child: Text(
                          'No Subjects Available...',
                          textAlign: TextAlign.center,
                          style: kGradeTitleStyle.copyWith(
                            color: kBrownishGreyColor.withOpacity(0.5),
                          ),
                        ),
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}
