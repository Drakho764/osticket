import 'package:osticket/components/my_button.dart';
import 'package:osticket/components/my_text_field.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  void singUp() async {
    if (passwordController.text != confirmpasswordController.text){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Las contraseñas no coinciden")));
      return;
    }
    final authService= Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signInWithEmailAndPassword(emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()),));
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
                  "Crea tu cuenta ya",
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
                    hintText: "Ingresa tu Contraseña",
                    obscureText: false),
                const SizedBox(
                  height: 50,
                ),
                MyTextField(
                    controller: confirmpasswordController,
                    hintText: "Ingresa de nuevo tu Contraseña",
                    obscureText: false),
                const SizedBox(
                  height: 50,
                ),
                Mybutton(onTap: singUp, text: "Registrar"),
                const SizedBox(
                  height: 50,
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Ya tienes cuenta?"),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap:widget.onTap,
                      child: const Text(
                        "Iniciar sesión",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    )
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
