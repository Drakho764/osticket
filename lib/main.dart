import 'package:osticket/firebase_options.dart';
import 'package:osticket/pages/Loginpage.dart';
import 'package:osticket/pages/add_ticket.dart';
import 'package:osticket/pages/edit_ticket.dart';
import 'package:osticket/services/auth/auth_gate.dart';
import 'package:osticket/services/auth/auth_service.dart';
import 'package:osticket/services/auth/login_or_register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(create: (context) => AuthService(),
    child: const MyApp(),),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
      routes: {
      '/add':(context)=>const AddTicket(),
      '/edit':(context)=>const EditTicket(),
      }

    );
  }
}
