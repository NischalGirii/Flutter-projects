import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/screen/authenticate/authenticate.dart';
import 'package:personal_expense_tracker/screen/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    // return either Home or Authenticate widget
    return Authenticate();
  }
}