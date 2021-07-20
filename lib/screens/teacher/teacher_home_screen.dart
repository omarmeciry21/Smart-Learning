import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_learning/constants.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:smart_learning/screens/chat/chat_room_screen.dart';
import 'package:smart_learning/screens/student/st_classroom_screen.dart';
import 'package:smart_learning/screens/teacher/te_lesson_screen.dart';
import 'package:smart_learning/screens/training/training_screen.dart';

class TeacherHomeScreen extends StatefulWidget {
  static const id = 'teacher_home_screen';
  @override
  _TeacherHomeScreenState createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  int selectedIndex = 0;
  final studentScreens = [TeLessonScreen(), TrainingScreen(), ChatRoomScreen()];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Smart Learning',
            style: kCardTitleStyle.copyWith(fontSize: 25.0),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: kBrightBlueColor,
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.white),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
            )
          ],
        ),
        bottomNavigationBar: FFNavigationBar(
          theme: FFNavigationBarTheme(
            barBackgroundColor: Colors.white,
            selectedItemBorderColor: kPowderBlueColor,
            selectedItemBackgroundColor: kBrightBlueColor,
            selectedItemIconColor: Colors.white,
            selectedItemLabelColor: kBrightBlueColor,
          ),
          selectedIndex: selectedIndex,
          onSelectTab: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: [
            FFNavigationBarItem(
              iconData: Icons.create,
              label: 'Content',
            ),
            FFNavigationBarItem(
              iconData: Icons.view_day_rounded,
              label: 'Training',
            ),
            FFNavigationBarItem(
              iconData: Icons.message_rounded,
              label: 'Chat',
            ),
          ],
        ),
        body: studentScreens[selectedIndex],
      ),
    );
  }
}
