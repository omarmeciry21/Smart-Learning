import 'package:flutter/material.dart';
import 'package:smart_learning/screens/general/login_screen.dart';
import 'package:smart_learning/screens/article/newsletter_screen.dart';
import 'package:smart_learning/screens/general/register_screen.dart';
import 'package:smart_learning/screens/general/splash_screen.dart';
import 'package:smart_learning/screens/student/student_home_screen.dart';
import 'package:smart_learning/screens/teacher/teacher_home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        NewsletterScreen.id: (context) => NewsletterScreen(),
        StudentHomeScreen.id: (context) => StudentHomeScreen(),
        TeacherHomeScreen.id: (context) => TeacherHomeScreen(),
      },
    );
  }
}
