import 'package:flutter/material.dart';
import 'package:smart_learning/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_learning/widgets/expanded_blue_button.dart';
import 'package:toast/toast.dart';

class TeLessonScreen extends StatefulWidget {
  @override
  _TeLessonScreenState createState() => _TeLessonScreenState();
}

class _TeLessonScreenState extends State<TeLessonScreen> {
  String gradeValue = '7', subjectId = '';
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController contentController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  bool canCreate = true;

  bool _keyboardIsVisible() {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Grade: ',
                    style: kButtonTextStyle.copyWith(
                      color: kBrightBlueColor,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  DropdownButton<String>(
                    value: gradeValue,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 20,
                    elevation: 9,
                    style: kButtonTextStyle.copyWith(
                      color: kBrightBlueColor,
                      fontSize: 20,
                    ),
                    underline: Container(
                      height: 2,
                      color: kBrightBlueColor,
                    ),
                    onChanged: (data) {
                      setState(() {
                        gradeValue = data;
                        print(data);
                      });
                    },
                    items: <String>['7', '8', '9']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Subject: ',
                    style: kButtonTextStyle.copyWith(
                      color: kBrightBlueColor,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection('subjects_info').snapshots(),
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
                      final subjects = snapshots.data.docs.reversed.where(
                          (element) =>
                              element.get('grade').toString() == gradeValue);
                      List<DropdownMenuItem> subjectItems = [];
                      for (var subject in subjects) {
                        subjectItems.add(DropdownMenuItem(
                          child: Text(subject.get('title').toString()),
                          value: subject.get('id').toString(),
                        ));
                      }
                      if (subjectItems.isNotEmpty) {
                        subjectId = subjectItems[0].value;
                        canCreate = true;
                      } else {
                        subjectId = 'No Subject Available';
                        canCreate = false;
                      }
                      return DropdownButton(
                        value: subjectId,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 20,
                        elevation: 9,
                        disabledHint: Text('No subjects'),
                        style: kButtonTextStyle.copyWith(
                          color: kBrightBlueColor,
                          fontSize: 20,
                        ),
                        underline: Container(
                          height: 2,
                          color: kBrightBlueColor,
                        ),
                        onChanged: subjectId != 'No Subject Available'
                            ? (data) {
                                setState(() {
                                  subjectId = data;
                                });
                              }
                            : null,
                        items: subjectItems,
                      );
                    },
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'Title: ',
                    style: kButtonTextStyle.copyWith(
                      color: kBrightBlueColor,
                      fontSize: 20,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: titleController,
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter Lesson Title',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Content: ',
                style: kButtonTextStyle.copyWith(
                  color: kBrightBlueColor,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                constraints: BoxConstraints(minHeight: 100),
                child: TextField(
                  maxLines: 12,
                  controller: contentController,
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter Lesson Content',
                  ),
                ),
              ),
              Row(
                children: [
                  ExpandedBlueButton(
                    label: 'Create new Lesson',
                    onTap: () {
                      if (!canCreate ||
                          contentController.text.length == 0 ||
                          contentController.text.length == 0) {
                        String message;
                        if (contentController.text.length == 0 ||
                            contentController.text.length == 0)
                          message = 'Please, fill all the fields.';
                        if (!canCreate)
                          message = 'Please, choose a valid subject.';
                        Toast.show(message, context,
                            textColor: Colors.white,
                            backgroundColor: Colors.redAccent,
                            duration: Toast.LENGTH_LONG,
                            gravity: Toast.BOTTOM);
                      } else {
                        _firestore.collection('lessons').add({
                          'body': contentController.text,
                          'date': Timestamp.now(),
                          'title': titleController.text,
                          'id': DateTime.now().millisecondsSinceEpoch,
                          'subject_id': subjectId.toString(),
                        });
                        Toast.show('Added Successfully', context,
                            textColor: Colors.white,
                            backgroundColor: Colors.blueAccent,
                            duration: Toast.LENGTH_LONG,
                            gravity: Toast.BOTTOM);
                        titleController.clear();
                        contentController.clear();
                      }
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
