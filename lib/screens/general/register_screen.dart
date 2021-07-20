import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_learning/images.dart';
import 'package:smart_learning/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:smart_learning/screens/student/student_home_screen.dart';
import 'package:smart_learning/screens/teacher/teacher_home_screen.dart';
import 'package:toast/toast.dart';

class RegisterScreen extends StatefulWidget {
  static const id = 'register_screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final emailController = TextEditingController();

  final passController = TextEditingController();
  final nameController = TextEditingController();

  String email = '', pass = '', name = '';
  String _selectedUser = 'student';
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
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.center,
                  controller: nameController,
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Full Name'),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                SizedBox(
                  height: 10.0,
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
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Row(children: [
                        Radio(
                          value: 'student',
                          groupValue: _selectedUser,
                          onChanged: (value) {
                            setState(() {
                              _selectedUser = value;
                            });
                          },
                        ),
                        Text('Student'),
                      ]),
                    ),
                    Container(
                      child: Row(children: [
                        Radio(
                          value: 'teacher',
                          groupValue: _selectedUser,
                          onChanged: (value) {
                            setState(() {
                              _selectedUser = value;
                            });
                          },
                        ),
                        Text('Teacher'),
                      ]),
                    ),
                  ],
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
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: pass);
                        if (user != null) {
                          _firestore
                              .collection('users')
                              .doc('${user.user.uid}')
                              .set({
                            'name': name,
                            'email': email,
                            'pass': pass,
                            'user_type': _selectedUser,
                          });
                          Navigator.pushReplacementNamed(
                              context,
                              _selectedUser == 'student'
                                  ? StudentHomeScreen.id
                                  : TeacherHomeScreen.id);
                          Toast.show('Registered Successfully', context,
                              duration: Toast.LENGTH_LONG,
                              backgroundColor: Colors.lightBlueAccent,
                              textColor: Colors.blueAccent[900],
                              gravity: Toast.BOTTOM);
                          emailController.clear();
                          passController.clear();
                          nameController.clear();
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
                  child: Text('Register'),
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
