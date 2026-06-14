import 'package:firebase_auth/firebase_auth.dart';
import 'package:personal_expense_tracker/models/user.dart';
class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on FirebaseUser
  CustomUser? _userFromFirebaseUser(User? user){
     return user != null ? CustomUser(uid: user.uid) : null;
  }





  // sign in anonymous

  Future signInAnonymous() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  // sign in with email and password

  // register with email and password

  //sign out 
}