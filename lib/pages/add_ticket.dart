import 'package:flutter/material.dart';
import 'package:osticket/components/my_button.dart';
import 'package:osticket/services/db/firebase_service.dart';

class AddTicket extends StatefulWidget {
  const AddTicket({super.key});


  @override
  State<AddTicket> createState() => _AddTicketState();

}

class _AddTicketState extends State<AddTicket> {
  TextEditingController tickcontroller= TextEditingController(text:"");
   void signIn() async{
    await addTicket(tickcontroller.text).then((_){
      Navigator.pop(context);
    });
    
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrar Ticket"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          TextField(
            controller: tickcontroller,
            decoration: const InputDecoration(
            hintText: "Ingresa la falla"
          ),),
           Mybutton(onTap:signIn, text: "Subir Ticket"),
                  const SizedBox(
                    height: 50,
                  ),
        ],
        ),
      ),
    );
  }
}