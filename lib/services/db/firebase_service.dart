import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db =FirebaseFirestore.instance;

Future<List> getTicket() async{
  List ticket=[];
  CollectionReference colectionreferenceticket= db.collection('tickets');
  QuerySnapshot queryticket=await colectionreferenceticket.get();
  queryticket.docs.forEach((documento){
    ticket.add(documento.data());
  });
  await Future.delayed(const Duration(seconds: 2));
  return ticket;
}

Future<void> addTicket(String tick) async{
  await db.collection('tickets').add({"ticket":tick});

}

Future<void> editTicket(String uid, String newtick) async{
  await db.collection('tickets').doc(uid).set({"ticket":newtick});

}
