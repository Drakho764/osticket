import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:osticket/pages/home_page.dart';
import 'package:sign_button/sign_button.dart';


class GitHubSession extends StatefulWidget {
  const GitHubSession({super.key});

  @override
  State<GitHubSession> createState() => _GitHubSessionState();
}

class _GitHubSessionState extends State<GitHubSession>{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      height: 60,
      child: SignInButton(
        buttonType:ButtonType.github,
        width: MediaQuery.of(context).size.width,
        onPressed: ()async{
           try{
            UserCredential userCredential =await signInWithGithub();
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
  Future<UserCredential> signInWithGithub() async{
    GithubAuthProvider githubAuthProvider =GithubAuthProvider();
    return await FirebaseAuth.instance.signInWithProvider(githubAuthProvider);
  }
}