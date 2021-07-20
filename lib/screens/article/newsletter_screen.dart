import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_learning/constants.dart';
import 'package:smart_learning/screens/article/article_view_screen.dart';
import 'package:smart_learning/screens/general/login_screen.dart';
import 'package:smart_learning/screens/general/register_screen.dart';
import 'package:smart_learning/screens/student/student_home_screen.dart';
import 'package:smart_learning/screens/teacher/teacher_home_screen.dart';
import 'package:smart_learning/widgets/image_card_button.dart';
import 'package:smart_learning/widgets/expanded_blue_button.dart';
import 'package:smart_learning/widgets/newsletter_appbar.dart';
import 'package:smart_learning/models/article.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class NewsletterScreen extends StatefulWidget {
  static const id = 'newsletter_screen';

  @override
  _NewsletterScreenState createState() => _NewsletterScreenState();
}

class _NewsletterScreenState extends State<NewsletterScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    try {
      defaultPaging(context);
    } catch (e) {
      print(e);
    }
  }

  void defaultPaging(BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    if (_auth.currentUser != null) {
      DocumentSnapshot userDetails =
          await _firestore.collection('users').doc(_auth.currentUser.uid).get();
      String type = userDetails.data()['user_type'].toString();
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  type == 'student' ? StudentHomeScreen() : TeacherHomeScreen(),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            NewsletterBar(),
            Expanded(
              child: ArticlesStream(),
            ),
            Row(
              children: [
                ExpandedBlueButton(
                  label: 'Log in',
                  onTap: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                ),
                ExpandedBlueButton(
                  label: 'Register',
                  onTap: () {
                    Navigator.pushNamed(context, RegisterScreen.id);
                  },
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}

class ArticlesStream extends StatefulWidget {
  @override
  _ArticlesStreamState createState() => _ArticlesStreamState();
}

class _ArticlesStreamState extends State<ArticlesStream> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('articles').snapshots(),
        builder: (context, snapshot) {
          List<Widget> imageCards = [];
          if (!snapshot.hasData)
            return Container(
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: kBrightBlueColor,
                ),
              ),
            );

          final articles = snapshot.data.docs.reversed;
          for (var article in articles) {
            imageCards.add(
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ArticleViewScreen(
                        article: Article(
                          imageUrl: article.get('imageUrl').toString(),
                          title: article.get('title').toString(),
                          date: article.get('date').toString(),
                          body: article.get('body').toString(),
                        ),
                      ),
                    ),
                  );
                },
                child: ImageCardButton(
                  imageUrl: article.get('imageUrl').toString(),
                  title: article.get('title').toString(),
                  subTitle: article.get('date').toString(),
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: imageCards.length,
            itemBuilder: (context, index) => imageCards[index],
          );
        },
      ),
    );
  }
}
