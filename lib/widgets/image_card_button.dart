import 'package:flutter/material.dart';
import 'package:smart_learning/images.dart';
import 'package:smart_learning/constants.dart';

class ImageCardButton extends StatelessWidget {
  const ImageCardButton({
    Key key,
    @required this.imageUrl,
    @required this.title,
    @required this.subTitle,
  }) : super(key: key);

  final imageUrl, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: kBrightBlueColor,
        ),
        height: 250,
        child: Column(
          children: [
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: kPowderBlueColor,
              ),
              child: FittedBox(
                fit: BoxFit.cover,
                clipBehavior: Clip.hardEdge,
                child: Center(
                  child: FadeInImage(
                    placeholder: AssetImage(LocalImages.imgPhoto),
                    image: NetworkImage(imageUrl),
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: kCardTitleStyle,
                    ),
                    Text(
                      subTitle,
                      textAlign: TextAlign.end,
                      style: kCardSubTitleStyle,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
