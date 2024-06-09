import 'package:osticket/components/my_button.dart';
import 'package:osticket/components/my_text_field.dart';
import 'package:osticket/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async{
    final authService = Provider.of<AuthService>(context, listen: false);
    try{
      await authService.signInWithEmailandPassword(
        emailController.text, 
        passwordController.text
        );
    }catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(toString(),),),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                  width: 120,
                  height: 120,
                  child:
                  Image.asset('assets/images/lynx.png'),
                ),
                
                
                Text(
                  "Bienvenido a OsTicket",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 50,
                ),
                MyTextField(
                    controller: emailController,
                    hintText: "Ingresa tu correo de la empresa",
                    obscureText: false),
                const SizedBox(
                  height: 50,
                ),
                MyTextField(
                    controller: passwordController,
                    hintText: "Contraseña",
                    obscureText: true),
                const SizedBox(
                  height: 50,
                ),
                Mybutton(onTap:signIn, text: "Iniciar Sesión"),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("No tienes cuenta?"),
                    const SizedBox(width: 4,),
                    GestureDetector(
                      onTap:widget.onTap,
                      child: const Text("Registrar", 
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                      )
                      ),
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
