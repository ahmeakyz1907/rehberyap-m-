import 'package:flutter/material.dart';
import 'package:rehberr/Add_contact_page.dart';
import 'Model/Contacts.dart';

class ContactPage extends StatefulWidget{

  @override
  _ContactPageState createState() => _ContactPageState();
}
class _ContactPageState extends State<ContactPage>{
  late List<Contact> contacts;

  @override
  void initState(){
    contacts = Contact.contacts;
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    Contact.contacts.sort((Contact a, Contact b)=>a.name[0].compareTo(b.name[0]));
    return Scaffold(
      appBar: AppBar(
        title: Text("Rehber Uygulaması"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) => AddContactPage(contact: Contact(phoneNumber: '', name: ''))));
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (BuildContext context, int index) {
            Contact contact = contacts[index];
            return Dismissible(
                key: Key(contact.name),
                onDismissed: (direction){
                  setState(() {
                    contacts.removeAt(index);
                  });
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text("${contact.name} has been deleted"), action: SnackBarAction(label:"UNDO",
                    onPressed: (){
                      setState(() {
                        contacts.add(contact);
                      });
                    },),),);
                },
                child: ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage("https://placekitten.com/200/200"),
                    child: Text(
                      contact.name[0].toUpperCase(), style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(contact.name),
                  subtitle: Text(contact.phoneNumber),
                ));
          }),
    );
  }
}