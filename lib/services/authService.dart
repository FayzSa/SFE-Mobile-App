import 'package:firebase_auth/firebase_auth.dart';
import 'package:sfe_mobile_app/models/user_model.dart';
import 'package:sfe_mobile_app/services/databaseService.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// create userObj base on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }
  

// Auth change stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }


  // sign with email and pass

Future restPassword(String email)async{
  return await _auth.sendPasswordResetEmail(email: email);
}
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult rs = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = rs.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //registre with email and pass

  
  
   addUsers(
      String email, String password, String dep, String fullName , bool isAdmin ,{String grade}) async {
    try {
      
      AuthResult rs = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
         
          FirebaseUser user = rs.user;
      // Create Document of the user
      if(isAdmin == true){
        
      await DatabaseService(uid: user.uid)
          .initAdmin(fullName);
      }
      else{
      await DatabaseService(uid: user.uid)
          .initUserData(fullName, dep , isAdmin , grade: grade ?? "Pas Define");}
     
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registreWithEmailAndPassword(
      String email, String password, String dep, String fullName , bool isAdmin) async {
    try {
      AuthResult rs = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = rs.user;
      // Create Document of the user
    
      
      await DatabaseService(uid: user.uid)
          .initUserData(fullName, dep , isAdmin);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // logout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
