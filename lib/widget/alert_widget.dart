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
      return SingleChildScrollView(
        child: AlertDialog(
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
                child: c1.image != null
                    // || providerr!.path != null
                    ? CircleAvatar(
                        radius: 50,
                        backgroundImage: FileImage(File(
                            // providerr!.path != null
                            // ? "${providerr!.path}" :
                        "${c1.image}")),
                      )
                    : CircleAvatar(
                        radius: 70,
                        child: Text("${c1.name?.substring(0, 1).toUpperCase()}",
                            style: Theme.of(context).textTheme.titleLarge),
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
                ContactModel cm = ContactModel(
                    image: c1.image,
                    email: txtEmail.text,
                    contact: txtContact.text,
                    name: txtName.text);
                context.read<ContactProvider>().editContact(cm);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Align(
                  alignment: Alignment.center, child: Text('Update')),
            ),
          ],
        ),
      );
    },
  );
}
