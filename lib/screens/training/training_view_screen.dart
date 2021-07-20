import 'package:flutter/material.dart';
import 'package:smart_learning/images.dart';
import 'package:smart_learning/constants.dart';
import 'package:smart_learning/models/training.dart';
import 'package:smart_learning/screens/training/training_webview_screen.dart';
import 'package:smart_learning/widgets/expanded_blue_button.dart';

class TrainingViewScreen extends StatelessWidget {
  final Training training;
  TrainingViewScreen({@required this.training});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 350.0,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: FadeInImage(
                    placeholder: AssetImage(LocalImages.imgPhoto),
                    image: NetworkImage(
                      training.imageUrl,
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
                      '${training.title}',
                      style: kArticleTitleStyle,
                    ),
                    Text(
                      '${training.type}',
                      textAlign: TextAlign.end,
                      style: kArticalDateStyle,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    training.description != null
                        ? Text(
                            '${training.description}',
                            textAlign: TextAlign.justify,
                            style: kArticleBodyStyle,
                          )
                        : Container(),
                  ],
                ),
              ),
              Row(
                children: [
                  ExpandedBlueButton(
                    label: 'Go to Course',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TrainingWebviewScreen(training: training),
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
        SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
