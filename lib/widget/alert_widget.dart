import 'package:contact_app/model/contact_model.dart';
import 'package:contact_app/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void updateWidget(BuildContext context,ContactModel c1) {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtContact = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Edit Contact'),
        actions: [
          TextField(
            controller: txtName,
            decoration: const InputDecoration(
                border: UnderlineInputBorder(), labelText: 'Name'),
          ),
          TextField(
            controller: txtContact,
            decoration: const InputDecoration(
                border: UnderlineInputBorder(), labelText: 'Contact'),
          ),
          TextField(
            controller: txtEmail,
            decoration: const InputDecoration(
                border: UnderlineInputBorder(), labelText: 'Email'),
          ),
          ElevatedButton(
            onPressed: () {
              ContactModel c1 = ContactModel();
              c1.name = txtName.text;
              c1.contact = txtContact.text;
              c1.email = txtEmail.text;
              context.read<ContactProvider>().editContact(c1);
              Navigator.pop(context);
            },
            child:
                const Align(alignment: Alignment.center, child: Text('Update')),
          ),
        ],
      );
    },
  );
}
