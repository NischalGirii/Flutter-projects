import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/screen/authenticate/authenticate.dart';
import 'package:personal_expense_tracker/screen/home/home.dart';
import 'package:provider/provider.dart';
import 'package:personal_expense_tracker/models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<CustomUser?>(context);
    
    // return either Home or Authenticate widget
    if (user == null) {
      return const Authenticate();
    } else {
      return const Home();
    }
  }
}