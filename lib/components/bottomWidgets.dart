import 'package:flutter/material.dart';
import 'package:sim_teacommerce/components/clearFullButton.dart';
import 'package:sim_teacommerce/components/defaultButton.dart';

class BottomWidgets extends StatelessWidget {
  const BottomWidgets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClearFullButton(
            darkText: 'Already have an account?',
            colorText: ' SignIn',
            onPressed: () => {},
          ),
          DefaultButton(
            btnText: 'Sign Up',
            onPressed: () => {},
          ),
        ],
      ),
    );
  }
}
