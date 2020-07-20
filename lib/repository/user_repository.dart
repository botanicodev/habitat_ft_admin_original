import 'package:firebase_auth/firebase_auth.dart';

class UserRepository{
  final FirebaseAuth _firebaseAuth;

  UserRepository({FirebaseAuth firebaseAuth}):
  _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;


  Future<void> signInWithEmailAndPassword(String email, String password){
    return _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  } 
}