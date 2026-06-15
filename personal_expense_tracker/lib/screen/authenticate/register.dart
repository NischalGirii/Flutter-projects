import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:personal_expense_tracker/services/auth.dart';

class Register extends StatefulWidget {
  // const Register({super.key});

  final Function toggleView;
  Register({required this.toggleView});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  
  final AuthService _auth = AuthService();
  String email = '';
  String password = '';
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
          TextFormField(
            onChanged:(value) {
              setState(() =>email = value);
            },
            
            decoration: InputDecoration(
              hint: Text("Enter email"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16)
              )
            ),
          ),
          
          // SizedBox(height: 20,),
           TextFormField(
            obscureText: true,
            onChanged: (value) {
              setState(() => password = value);
              
            },
            
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
            onPressed: () async{
              print(email);
              print(password);

            }, 
          child: Text("Register") ),

         
         

          

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(480, 40), 
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              side: BorderSide(
                color: Colors.black,
                 
              )
            ),
            
            onPressed: () {
              widget.toggleView();
            }, 
          child: Text("I already have an account"))
        ],
       ),
     ),

    );
  }
}