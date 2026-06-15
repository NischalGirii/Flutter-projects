import 'package:flutter/material.dart';
import 'package:personal_task_manager_app/home.dart';
import 'package:personal_task_manager_app/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController userController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Future<void> onLogin(BuildContext context) async{
      final pref = await SharedPreferences.getInstance();

      String? savedUsername = pref.getString("username");
      String? savedPassword = pref.getString("password");

      String enteredUsername = userController.text;
      String enteredPassword = passwordController.text;

      if(enteredUsername == savedUsername && enteredPassword == savedPassword){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(Username: enteredUsername)));
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid username or password")));
      }

    }



    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30,),
          Text("Login",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (value) {
                if(value == null || value.isEmpty) {
                  return "please enter email";
                }
                if(!value.contains("@")){
                  return "Enter valid Email";
                }
                return null;
              } ,
              controller: userController,
              decoration: InputDecoration(
                label: Text("Username"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (value) {
                if(value == null || value.isEmpty){
                  return "Enter password";
                }
                if(!RegExp(r'[a-z]').hasMatch(value)) {
                  return "Password must contain atleast one lower case character.";
                }
                if(!RegExp(r'[A-Z]').hasMatch(value)) {
                  return "Password must contain atleast one upper case character.";
                }
                if(!RegExp(r'[0-9]').hasMatch(value)){
                  return "Password must contain atleast one number.";
                }
                if(!RegExp(r'[!@#$%^&*()]').hasMatch(value)){
                  return "Password must contain atleat one special character.";
                }
                return null;
              },
              controller: passwordController,
              decoration: InputDecoration(
                label: Text("Password"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16)
                )
              ),
            ),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blueAccent,
              fixedSize: Size(400, 50)
            ),
            onPressed: () {
              onLogin(context);
            }, child: Text("Log in")),


          SizedBox(height: 50,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.blueAccent,
              backgroundColor: Colors.white,
              fixedSize: Size(400, 50)
            ),
            onPressed: () {
              Navigator.pop(context, MaterialPageRoute(builder: (context)=>Register()));
            }, child: Text("Create new account"))


        ],
      ),
    );
  }
}