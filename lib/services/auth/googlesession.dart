import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:osticket/pages/home_page.dart';
import 'package:osticket/services/auth/auth_service.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

class Googlesession extends StatefulWidget {
  const Googlesession({super.key});

  @override
  State<Googlesession> createState() => _GooglesessionState();
}

class _GooglesessionState extends State<Googlesession> {
  final _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      height: 60,
      child: SignInButton(
        buttonType: ButtonType.google,
        width: MediaQuery.of(context).size.width,
        onPressed: () async{

           try{
            await _auth.signInWithGogle();
            if (context.mounted) {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage()));
            }
          }catch (e){
            AnimatedSnackBar.material(e.toString(), type: AnimatedSnackBarType.warning).show(context);
            
          }
        },
      ),
    );
  }
  
 
}
