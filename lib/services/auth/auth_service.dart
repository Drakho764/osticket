import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends ChangeNotifier{
  final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;
  final FirebaseFirestore _firestore= FirebaseFirestore.instance;
  User? user;

  Future<UserCredential> signInWithEmailandPassword(String email, String password) async{
    try{
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      _firestore.collection('users').doc(userCredential.user!.uid).set({
          'uid':userCredential.user!.uid,
          'email':email,
        }, SetOptions(merge: true));
      return userCredential;
    } 
     
    on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
  }

  Future<UserCredential> signInWithEmailAndPassword(String email, password)async{
    try {
      UserCredential userCredential=
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, 
        password: password);

        _firestore.collection('users').doc(userCredential.user!.uid).set({
          'uid':userCredential.user!.uid,
          'email':email,
        });
        return userCredential;
    }  on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }

  }
   Future<UserCredential?> signInWithGogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final cred = GoogleAuthProvider.credential(idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
      return await _firebaseAuth.signInWithCredential(cred);
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<User?> signInWithFacebook() async{
    FacebookLogin objfacebook = new FacebookLogin();
    FacebookLoginResult objfacebookaccount = await objfacebook.logIn(customPermissions: ['email']);
    
    if(objfacebookaccount !=null){
      FacebookAccessToken? objtoken = objfacebookaccount.accessToken;
      AuthCredential objcred = FacebookAuthProvider.credential(objtoken!.token);
      try{
        UserCredential objusercred = await FirebaseAuth.instance.signInWithCredential(objcred);
        user = objusercred.user;
        return user;
      }on FirebaseAuthException catch(e){
        print("error facebook");
      }
    }
  }

  Future<void> singOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}