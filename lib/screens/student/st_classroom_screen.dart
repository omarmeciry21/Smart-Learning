import 'package:flutter/material.dart';
import 'package:smart_learning/constants.dart';
import 'package:smart_learning/widgets/subject_card_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StClassroomScreen extends StatelessWidget {
  static const id = 'st_classroom_screen';

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
                .map((e) => GradeSectionWidget(
                      grade: e,
                    ))
                .toList()),
      ),
    ));
  }
}

class GradeSectionWidget extends StatelessWidget {
  const GradeSectionWidget({Key key, @required this.grade}) : super(key: key);

  final int grade;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 150.0,
      ),
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
                List<SubjectCardButton> subjectCards = [];
                if (!snapshots.hasData) {
                  return CircularProgressIndicator(
                      backgroundColor: kBrightBlueColor);
                }

                final subjects = snapshots.data.docs.reversed;
                for (var subject in subjects
                    .where((element) => element.get('grade') == grade)) {
                  subjectCards.add(
                    SubjectCardButton(
                      title: subject.get('title'),
                      imageUrl: subject.get('imageUrl'),
                      grade: subject.get('grade').toString(),
                      id: subject.get('id').toString(),
                    ),
                  );
                }
                return subjectCards.isNotEmpty
                    ? Container(
                        width: double.infinity,
                        height: 150,
                        child: ListView.builder(
                          itemCount: subjectCards.length,
                          scrollDirection: Axis.horizontal,
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

/*
Container(
                    width: double.infinity,
                    height: 150,
                    child: ListView.builder(
                      itemCount: subjects.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, n) => SubjectCardButton(
                          title: subjects[n].title,
                          imageUrl: subjects[n].imageUrl),
                    ),
                  ),
                  */
