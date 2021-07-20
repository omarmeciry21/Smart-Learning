import 'package:flutter/material.dart';

/*
*Colors constants
*/

const kBrightBlueColor = Color(0xff116fff);
const kLessBrightBlueColor = Color(0xff4E92F9);

const kPowderBlueColor = Color(0xFFbed8ff);

const kPaleBlueColor = Color(0xFFf3f8fe);

const kBrownishGreyColor = Color(0xFF666666);

const kWarmGreyColor = Color(0xFF707070);

const kCardTitleStyle = TextStyle(
    color: Colors.white, fontSize: 26, fontFamily: 'Raleway-SemiBold');

const kCardSubTitleStyle =
    TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Raleway-Regular');

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kLessBrightBlueColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kBrightBlueColor, width: 3.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kButtonTextStyle = TextStyle(
  fontFamily: 'Raleway-SemiBold',
  fontSize: 20.0,
  color: Colors.white,
);

ButtonStyle kTextButtonStyle = TextButton.styleFrom(
  backgroundColor: kBrightBlueColor,
  primary: Colors.white,
  textStyle: kButtonTextStyle,
  minimumSize: Size(double.infinity, 50),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
);

const kArticalDateStyle = TextStyle(
  color: kBrightBlueColor,
  fontFamily: 'Raleway-SemiBold',
  fontSize: 16.0,
);

const kArticleTitleStyle = TextStyle(
  color: kBrightBlueColor,
  fontFamily: 'Raleway-Bold',
  fontSize: 40.0,
);

const kArticleBodyStyle = TextStyle(
  color: kBrightBlueColor,
  fontFamily: 'Raleway-Regular',
  fontSize: 20.0,
);

const kGradeTitleStyle = TextStyle(
  fontFamily: 'Raleway-SemiBold',
  fontSize: 20,
  color: kBrownishGreyColor,
);

const kGrades = [7, 8, 9];
