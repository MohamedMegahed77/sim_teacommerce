import 'package:flutter/material.dart';
import 'package:sim_teacommerce/components/defaultTextField.dart';
import 'package:sim_teacommerce/constants.dart';

class CenterTextfields extends StatelessWidget {
  const CenterTextfields({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultTextField(
            hintText: 'Fullname',
            icon: Icons.person,
            keyboardType: TextInputType.text,
            obscureText: false,
          ),
          SizedBox(height: kDefaultPadding),
          DefaultTextField(
            hintText: 'Email address',
            icon: Icons.mail,
            keyboardType: TextInputType.emailAddress,
            obscureText: false,
          ),
          SizedBox(height: kDefaultPadding),
          DefaultTextField(
            hintText: 'Password',
            icon: Icons.lock,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
          ),
          SizedBox(height: kDefaultPadding),
          DefaultTextField(
            hintText: 'Confirm Password',
            icon: Icons.lock,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
