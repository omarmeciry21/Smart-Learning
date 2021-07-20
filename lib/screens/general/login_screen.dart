import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:smart_learning/constants.dart';
import 'package:smart_learning/images.dart';
import 'package:smart_learning/screens/student/student_home_screen.dart';
import 'package:smart_learning/screens/teacher/teacher_home_screen.dart';
import 'package:toast/toast.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final emailController = TextEditingController();

  final passController = TextEditingController();

  String email = '', pass = '';

  bool progressHUD = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: progressHUD,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  child: Container(
                    width: 150.0,
                    height: 150.0,
                    child: Image.asset(LocalImages.imgBrain),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  controller: emailController,
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Email'),
                  onChanged: (value) {
                    email = value;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  controller: passController,
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Password'),
                  onChanged: (value) {
                    pass = value;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextButton(
                  onPressed: () async {
                    try {
                      if (email.isNotEmpty && pass.isNotEmpty) {
                        setState(() {
                          progressHUD = true;
                        });
                        UserCredential user =
                            await _auth.signInWithEmailAndPassword(
                                email: email, password: pass);
                        if (user != null) {
                          DocumentSnapshot userDetails = await _firestore
                              .collection('users')
                              .doc('${user.user.uid}')
                              .get();
                          String selectedUser = userDetails.data()['user_type'];
                          Navigator.pushReplacementNamed(
                              context,
                              selectedUser == 'student'
                                  ? StudentHomeScreen.id
                                  : TeacherHomeScreen.id);
                          Toast.show('Logged in Successfully', context,
                              duration: Toast.LENGTH_LONG,
                              backgroundColor: Colors.lightBlueAccent,
                              textColor: Colors.blueAccent[900],
                              gravity: Toast.BOTTOM);
                          emailController.clear();
                          passController.clear();
                        }
                        setState(() {
                          progressHUD = false;
                        });
                      }
                    } catch (e) {
                      print(e);

                      setState(() {
                        progressHUD = false;
                      });
                    }
                  },
                  child: Text('Log in'),
                  style: kTextButtonStyle,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
