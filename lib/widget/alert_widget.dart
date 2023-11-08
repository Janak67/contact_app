import 'dart:io';
import 'package:contact_app/model/contact_model.dart';
import 'package:contact_app/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

void updateWidget(BuildContext context, ContactModel c1) {
  TextEditingController txtName = TextEditingController(text: c1.name);
  TextEditingController txtContact = TextEditingController(text: c1.contact);
  TextEditingController txtEmail = TextEditingController(text: c1.email);
  ContactProvider? providerr;
  providerr = context.read<ContactProvider>();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Edit Contact'),
        actions: [
          InkWell(
            onTap: () async {
              ImagePicker picker = ImagePicker();
              XFile? image =
                  await picker.pickImage(source: ImageSource.gallery);
              providerr!.updateImagePath(image!.path);
            },
            child: Align(
              alignment: Alignment.center,
              child: c1.image == null
                  ? CircleAvatar(
                      radius: 70,
                      child: Text("${c1.name?.substring(0, 1).toUpperCase()}",
                          style: Theme.of(context).textTheme.titleLarge),
                    )
                  : CircleAvatar(
                      radius: 50,
                      backgroundImage: FileImage(File("${c1.image}")),
                    ),
            ),
          ),
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
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              ContactModel c1 = ContactModel();
              c1.name = txtName.text;
              c1.contact = txtContact.text;
              c1.email = txtEmail.text;
              c1.image = providerr!.path;
              context.read<ContactProvider>().editContact(c1);
              Navigator.pop(context);
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
