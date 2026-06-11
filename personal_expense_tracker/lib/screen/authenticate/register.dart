import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
   
Future<void> signUp(String email, String password) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    print("User Created");
  } on FirebaseAuthException catch (e) {
    print(e.message);
  }
}


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
       padding: const EdgeInsets.all(8.0),
       child: Column(spacing: 20,
        children: [
          SizedBox(height: 30,),
          Image.asset('assets/images/logo.png',width: 60,height: 60,fit: BoxFit.cover),
          Divider(),
          SizedBox(height: 20,),
          Text("Register into Personal Expense",
          style: TextStyle(
            fontSize: 20,
          ),),

          SizedBox(height: 30,),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              
              hint: Text("Enter username or email"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16)
              )
            ),
          ),
          
          // SizedBox(height: 20,),
           TextField(
          
            controller: passwordController,
            decoration: InputDecoration(
              
              hint: Text("Enter password"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16)
              )
            ),
          ),

          // SizedBox(height: 30,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(480, 40),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white
            ),
            onPressed: () {
              signUp(
              emailController.text,
              passwordController.text,
            );
            }, 
          child: Text("Regsiter") )
        ],
       ),
     ),
    );
  }
}