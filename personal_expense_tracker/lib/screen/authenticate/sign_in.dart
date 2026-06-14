import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/screen/authenticate/authenticate.dart';
import 'package:personal_expense_tracker/services/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  final AuthService _auth = AuthService();

  TextEditingController username = TextEditingController();
  TextEditingController password= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     
     body: Padding(
       padding: const EdgeInsets.all(8.0),
       child: Column(spacing: 20,
        children: [
          SizedBox(height: 30,),
          Image.asset('assets/images/logo.png',width: 60,height: 60,fit: BoxFit.cover),
          Divider(),
          SizedBox(height: 20,),
          Text("Login into Personal Expense",
          style: TextStyle(
            fontSize: 20,
          ),),

          SizedBox(height: 30,),
          TextField(
            controller: TextEditingController(),
            decoration: InputDecoration(
              
              hint: Text("Enter username or email"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16)
              )
            ),
          ),
          
          // SizedBox(height: 20,),
           TextField(
          
            controller: TextEditingController(),
            decoration: InputDecoration(
              
              hint: Text("Enter password"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16)
              )
            ),
          ),

          SizedBox(height: 30,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(480, 40),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white
            ),
            onPressed: () {
              
            }, 
          child: Text("Login") ),

         
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(480, 40),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white
            ),
            onPressed: () async {
              dynamic result = await _auth.signInAnonymous();
              if (result == null){
                print("error siginig in");
              }
              else{
                print("signed in");
                 print(result.uid);
              }
             
            }, 
          child: Text("Login Anonymous") ),

          

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(480, 40),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              side: BorderSide(
                color: Colors.black,
                 
              )
            ),
            
            onPressed: () {}, 
          child: Text("Create new account"))
        ],
       ),
     ),

     
    );
  }
}