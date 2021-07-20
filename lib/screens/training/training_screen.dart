import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_learning/constants.dart';
import 'package:smart_learning/models/training.dart';
import 'package:smart_learning/screens/training/training_view_screen.dart';
import 'package:smart_learning/widgets/image_card_button.dart';

class TrainingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TrainingStream();
  }
}

class TrainingStream extends StatefulWidget {
  @override
  _TrainingStreamState createState() => _TrainingStreamState();
}

class _TrainingStreamState extends State<TrainingStream> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('trainings').snapshots(),
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

          final trainings = snapshot.data.docs.reversed;
          for (var training in trainings) {
            Training currentTraining = Training(
              title: training.get('title').toString(),
              description: training.get('description').toString(),
              website: training.get('website').toString(),
              type: training.get('type').toString(),
              imageUrl: training.get('imageUrl').toString(),
              courseUrl: training.get('courseUrl').toString(),
            );
            imageCards.add(
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrainingViewScreen(
                        training: currentTraining,
                      ),
                    ),
                  );
                },
                child: ImageCardButton(
                  imageUrl: currentTraining.imageUrl,
                  title: currentTraining.title,
                  subTitle: currentTraining.type,
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
