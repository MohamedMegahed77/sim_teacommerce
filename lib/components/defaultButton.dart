import 'package:flutter/material.dart';
import 'package:sim_teacommerce/constants.dart';

class DefaultButton extends StatelessWidget {
  final String btnText;
  final Function? onPressed;
  const DefaultButton({
    Key? key,
    required this.btnText,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding),
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: FlatButton(
        padding: EdgeInsets.symmetric(vertical: kLessPadding),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(kShape)),
        color: kPrimaryColor,
        textColor: kWhiteColor,
        highlightColor: kTransparent,
        onPressed: () => onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 3,
            ),
            // Text(btnText.toUpperCase())
          ],
        ),
      ),
    );
  }
}
