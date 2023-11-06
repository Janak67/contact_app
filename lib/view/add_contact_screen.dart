import 'dart:io';

import 'package:contact_app/model/contact_model.dart';
import 'package:contact_app/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({Key? key}) : super(key: key);

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtContact = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  ContactProvider? providerw;
  ContactProvider? providerr;

  @override
  Widget build(BuildContext context) {
    providerw = context.watch<ContactProvider>();
    providerr = context.read<ContactProvider>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Contact"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Theme(
                data: ThemeData(
                  colorScheme: Theme.of(context).colorScheme.copyWith(
                        primary: Colors.grey,
                        background: Colors.grey,
                        secondary: Colors.green,
                      ),
                ),
                child: Stepper(
                  currentStep: providerw!.stepIndex,
                  onStepContinue: () {
                    providerw!.nextStep();
                  },
                  onStepCancel: () {
                    providerw!.cancelStep();
                  },
                  steps: [
                    Step(
                      title: const Text("Image"),
                      content: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                alignment: Alignment.bottomCenter,
                                title: const Text("Edit Profile Picture"),
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                        ImagePicker picker = ImagePicker();
                                        XFile? image = await picker.pickImage(
                                            source: ImageSource.gallery);
                                        providerr!.updateImagePath(image!.path);
                                      },
                                      child: const Text("Choose Photo")),
                                  TextButton(
                                      onPressed: () async {
                                        ImagePicker picker = ImagePicker();
                                        XFile? image = await picker.pickImage(
                                            source: ImageSource.camera);
                                        providerr!.updateImagePath(image!.path);
                                      },
                                      child: const Text("Take Photo")),
                                ],
                              );
                            },
                          );
                        },
                        child: Consumer<ContactProvider>(
                          builder: (context, value, child) => CircleAvatar(
                            backgroundColor: Colors.black,
                            backgroundImage: value.path != null
                                ? FileImage(File(value.path!))
                                : null,
                            radius: 60,
                          ),
                        ),
                      ),
                    ),
                    Step(
                        title: const Text("Name of Contact"),
                        content: TextField(
                          controller: txtName,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.name,
                        )),
                    Step(
                      title: const Text("Contact Number"),
                      content: TextField(
                        controller: txtContact,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Step(
                        title: const Text("Contact Email"),
                        content: TextField(
                          controller: txtEmail,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        )),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    ContactModel cm = ContactModel(
                        name: txtName.text,
                        contact: txtContact.text,
                        email: txtEmail.text,
                        image: providerr!.path);
                    providerr!.addContact(cm);
                    Navigator.pop(context);
                    providerr!.clean();
                  },
                  child: const Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}
