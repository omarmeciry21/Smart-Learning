import 'package:smart_learning/constants.dart';
import 'package:flutter/material.dart';
import 'package:smart_learning/images.dart';
import 'package:smart_learning/models/subject.dart';
import 'package:smart_learning/screens/student/st_lesson_screen.dart';
import 'package:smart_learning/widgets/expanded_blue_button.dart';

class SubjectCardButton extends StatelessWidget {
  SubjectCardButton(
      {@required this.title,
      @required this.imageUrl,
      @required this.grade,
      @required this.id});
  final String title, imageUrl, grade, id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.white,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            isScrollControlled: false,
            builder: (context) => SubjectBottomModalSheet(
              imageUrl: imageUrl,
              title: title,
              grade: grade,
              id: id,
            ),
          );
        },
        child: Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
            color: kBrightBlueColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 0.0,
                  blurRadius: 10.0,
                  offset: Offset(2, 2))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 150,
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  color: kPowderBlueColor,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: FadeInImage(
                      placeholder: AssetImage(LocalImages.imgPhoto),
                      image: NetworkImage(
                        imageUrl,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: kCardTitleStyle.copyWith(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubjectBottomModalSheet extends StatelessWidget {
  const SubjectBottomModalSheet({
    @required this.imageUrl,
    @required this.title,
    @required this.grade,
    @required this.id,
  });

  final String imageUrl;
  final String title;
  final String grade;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Expanded(
        child: Container(
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: FadeInImage(
                placeholder: AssetImage(LocalImages.imgPhoto),
                image: NetworkImage(
                  imageUrl,
                ),
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '$title',
              style: kArticleTitleStyle,
            ),
            Text(
              'Grade: $grade',
              textAlign: TextAlign.end,
              style: kArticalDateStyle,
            ),
          ],
        ),
      ),
      Row(children: [
        ExpandedBlueButton(
          label: 'Go to Lessons of "$title"',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StLessonScreen(
                  subject: Subject(
                      title: title, grade: grade, imageUrl: imageUrl, id: id),
                ),
              ),
            );
          },
        ),
      ])
    ]);
  }
}
