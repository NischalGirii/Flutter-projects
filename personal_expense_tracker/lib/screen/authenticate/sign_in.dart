import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/screen/authenticate/authenticate.dart';
import 'package:personal_expense_tracker/screen/authenticate/register.dart';
import 'package:personal_expense_tracker/services/auth.dart';

class SignIn extends StatefulWidget {
  // const SignIn({super.key});
  final Function toggleView;
  SignIn({required this.toggleView});
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  String email = '';
  String password = '';
   String error = '';

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

          Form(
            
            key: _formKey,
            child: Column(
              spacing: 20,
              children: [
                TextFormField(
                  
                  validator: (value) => value!.isEmpty ? "Enter a valid email" : null,
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


                  TextFormField(
                  validator:(value) => value!.length <8 ? "Password must be atleast 8 character":null ,
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
              ],
            ),
          
          ),
          SizedBox(height: 12,),
        
          Text(error,
          style: TextStyle(color: Colors.red, fontSize: 14),),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(480, 40),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white
            ),
            onPressed: () async{
               if(_formKey.currentState!.validate()){
                dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                if(result == null){
                  setState(() {
                    error = 'Could Not Signin With Thought Credentials';
                  });
                }
              }

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
            
            onPressed: () {
              widget.toggleView();
            }, 
          child: Text("Create new account"))
        ],
       ),
     ),

     
    );
  }
}