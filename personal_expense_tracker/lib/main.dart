import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/firebase_options.dart';
import 'package:personal_expense_tracker/models/user.dart';
import 'package:personal_expense_tracker/screen/authenticate/authenticate.dart';
import 'package:personal_expense_tracker/screen/authenticate/sign_in.dart';
import 'package:personal_expense_tracker/screen/wrapper.dart';
import 'package:personal_expense_tracker/services/auth.dart';
import 'package:provider/provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CustomUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
         
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        ),
        home: Wrapper(),
      ),
    );
  }

 
  
}
