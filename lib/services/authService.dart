import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brew_crew/models/user_model.dart';

class AuthService{

final FirebaseAuth _auth = FirebaseAuth.instance; 

// create userObj base on firebase user 
User _userFromFirebaseUser(FirebaseUser user){

      return user != null ? User(uid: user.uid) : null;
}

// Auth change stream 
 Stream<User> get user {
  return _auth.onAuthStateChanged
    .map(_userFromFirebaseUser);
}

// Sing In Anonymosly
Future signInAnon() async{
    try {

    AuthResult rs = await _auth.signInAnonymously();
    FirebaseUser user = rs.user;
    return _userFromFirebaseUser(user);
        } 
    catch (e) {
      print(e.toString());
      return null;

    }

}
  // sign with email and pass

  Future signInWithEmailAndPassword(String email , String password)async
  {
    try {
      
      
      AuthResult rs = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = rs.user;

  
      return _userFromFirebaseUser(user);

    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //registre with email and pass 

  Future registreWithEmailAndPassword(String email , String password)async
  {
    try {
      
      
      AuthResult rs = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = rs.user;
      // Create Document of the user 
      await DatabaseService(uid: user.uid).updateUserData("0", "New Crew Member", 100);
      return _userFromFirebaseUser(user);

    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // logout 
  Future signOut() async
  {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}