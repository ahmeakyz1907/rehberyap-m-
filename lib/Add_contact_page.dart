
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rehberr/Model/Contacts.dart';
import 'package:image_picker/image_picker.dart';

class AddContactPage extends StatelessWidget
{
  const AddContactPage({Key? key, required Contact contact}) : super(key: key);

  @override
Widget build(BuildContext context) {
  Contact.contacts.add(Contact(name: "Test", phoneNumber: "0555 555 55 55"));

  return Scaffold(
    appBar: AppBar(title: const Text("Yeni Kişi Ekle"),),
    body: SingleChildScrollView(child: AddContactForm()),
  );
}
}

class AddContactForm extends StatefulWidget{
  @override
  _AddContactFormState createState() => _AddContactFormState();
}

class _AddContactFormState extends State<AddContactForm>{
  final _formKey = GlobalKey<FormState>();
  late File _file;

  @override
  Widget build(BuildContext context){
    late String name;
    late String phoneNumber;



    return Column(
      children: <Widget>[
        Stack(children: [
          Image.asset("Assets/person.jpg",fit: BoxFit.fill,width: double.infinity),

          Positioned( bottom: 8, right: 8, child: IconButton(onPressed: getFile , icon: Icon(Icons.camera_alt),color: Colors.white,
          ))
        ]),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child:TextFormField(
                      decoration: InputDecoration(hintText: "Kişi Adı"),
                      validator: (value){
                        if(value!.isEmpty) {
                          return "Name required";
                        }
                      },
                      onSaved: (value){
                        name = value!;
                      }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child:TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        hintText: "Telefon Numarası"),
                    validator: (value){
                      if(value!.isEmpty) {
                        return "Phone Number required";
                      }
                    },
                    onSaved: (value){
                      phoneNumber = value!;
                    },
                  ),
                ),
                RaisedButton(color: Colors.blue, textColor: Colors.white,child: Text("Kaydet"),onPressed: (){
                  if(_formKey.currentState!.validate()){
                    _formKey.currentState!.save();

                    Contact.contacts.add(Contact(name: name, phoneNumber: phoneNumber));
                    var snackBar = Scaffold.of(context).showSnackBar(
                      SnackBar(
                          duration: Duration(milliseconds: 300),
                          content: Text("$name has been saved")),);
                    snackBar.closed.then((onValue){
                      Navigator.pop(context);
                    });
                  }
                },
                ),
              ],
            ),
          ),
        ),],);
  }

  void getFile() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _file = image as File;
    });
  }
}