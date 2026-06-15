import 'package:flutter/material.dart';
import 'package:personal_task_manager_app/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatelessWidget {
   Register({super.key});
  
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Future<void> onSubmit(BuildContext context) async{
      final pref = await SharedPreferences.getInstance();

      await pref.setString("username", usernameController.text);
      await pref.setString("password", passwordController.text);

      usernameController.clear();
      passwordController.clear();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Register Successfully")));

      Navigator.push(context, MaterialPageRoute(builder: (context)=> const Login()));
    }

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30,),
          Text("Register",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (value) {
                if(value == null || value.isEmpty){
                  return "please enter email";
                }
                if(!value.contains("@")){
                  return "Enter valid Email";
                }
                return null;
              },
              controller: usernameController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
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
                labelText: "Password",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              fixedSize: Size(400, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(16))
            ),
            onPressed: () {onSubmit(context);}, 
          child: Text("Register"))
        ],
      ),
    );
  }
}