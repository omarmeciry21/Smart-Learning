import 'package:flutter/material.dart';
import 'package:smart_learning/constants.dart';

class ExpandedBlueButton extends StatelessWidget {
  ExpandedBlueButton({
    @required this.label,
    @required this.onTap,
    this.isActive = true,
  });

  final String label;
  final Function onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                return isActive ? kBrightBlueColor : kPaleBlueColor;
              },
            ),
          ),
          onPressed: onTap,
          child: Text(
            label,
            style: kButtonTextStyle.copyWith(
                color: isActive ? Colors.white : kPowderBlueColor),
          ),
        ),
      ),
    );
  }
}
