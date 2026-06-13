import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/screen/authenticate/sign_in.dart';

class Authenticate extends StatelessWidget {
  const Authenticate({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SignIn(),
    );
  }
}