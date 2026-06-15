import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/services/auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Personal Expense Tracker",
        style: TextStyle(
          color: Colors.white
        ),),
        
        elevation: 0.0,
        backgroundColor: Colors.black,
        actions: <Widget>[
          TextButton.icon (
            icon: Icon(Icons.person),
            label: Text("Logout"),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            
            onPressed: () async{
               await _auth.signOut();
            })
        ],
      ),
     body: Column(
          children: [
            // Image.asset('assets/images/logo.png',height: 100,width:100,),
          ],
        ),
    );
  }
}