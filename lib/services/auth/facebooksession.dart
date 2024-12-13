import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:osticket/pages/home_page.dart';
import 'package:osticket/services/auth/auth_service.dart';
import 'package:sign_button/sign_button.dart';

class Facebooksession extends StatefulWidget {
  const Facebooksession({super.key});

  @override
  State<Facebooksession> createState() => _FacebooksessionState();
}

class _FacebooksessionState extends State<Facebooksession> {
  final _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      height: 60,
      child: SignInButton(
        buttonType: ButtonType.facebook,
        width: MediaQuery.of(context).size.width,
        onPressed: () async {
          try {
            await _auth.signInWithFacebook();
            if (context.mounted) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            }
          } catch (e) {
            AnimatedSnackBar.material(e.toString(),
                    type: AnimatedSnackBarType.warning)
                .show(context);
          }
        },
      ),
    );
  }
}
