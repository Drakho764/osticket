import 'package:flutter/material.dart';
import 'package:osticket/components/my_button.dart';
import 'package:osticket/services/db/firebase_service.dart';

class EditTicket extends StatefulWidget {
  const EditTicket({super.key});


  @override
  State<EditTicket> createState() => _EditTicketState();

}

class _EditTicketState extends State<EditTicket> {
  TextEditingController tickcontroller= TextEditingController(text:"");
   void signIn() async{
    await editTicket(arguments[uid], tickcontroller.text);
    
  }
  @override
  Widget build(BuildContext context) {
    final Map arguments= ModalRoute.of(context)!.settings.arguments as Map;
    tickcontroller.text=arguments['ticket'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Ticket"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          TextField(
            controller: tickcontroller,
            decoration: const InputDecoration(
            hintText: "Ingresa la modificacion"
          ),),
           Mybutton(onTap:signIn, text: "Actualizar"),
                  const SizedBox(
                    height: 50,
                  ),
        ],
        ),
      ),
    );
  }
}