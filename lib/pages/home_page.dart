import 'package:osticket/pages/chat_page.dart';
import 'package:osticket/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:osticket/services/db/firebase_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.singOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OsTicket"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(onPressed: signOut, icon: const Icon(Icons.logout))
        ],
      ),
      body: FutureBuilder(
          future: getTicket(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data?[index]['ticket']),
                    onTap: (){
                      Navigator.pushNamed(context, '/edit',arguments: {
                        "ticket":snapshot.data?[index]['ticket']
                      });
                    },
                    );
                },
              );
            }else{
              return const Center(child: CircularProgressIndicator(),);
            }
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async {
          await Navigator.pushNamed(context, '/add');
          setState((){});
        },
        child: const Icon(Icons.add),
      )
    
    );
  }
}
