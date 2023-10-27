import 'package:contact_app/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({Key? key}) : super(key: key);

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Contact"),
        ),
        body: Consumer<ContactProvider>(
          builder: (context, value, child) => Theme(
            data: ThemeData(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: Colors.grey,
                background: Colors.grey,
                secondary: Colors.green,
              ),
            ),
            child: Stepper(
              currentStep: value.stepIndex,
              onStepContinue: () {
                value.nextStep();
              },
              onStepCancel: () {
                value.cancelStep();
              },
              steps: const [
                Step(title: Text("Add Image"), content: Text("Image")),
                Step(
                    title: Text("Name of Contact"),
                    content: TextField(
                      decoration: InputDecoration(border: OutlineInputBorder(),),
                      keyboardType: TextInputType.name,
                    )),
                Step(
                  title: Text("Contact Number"),
                  content: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder(),),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Step(
                    title: Text("Contact Email"),
                    content: TextField(
                      decoration: InputDecoration(border: OutlineInputBorder(),),
                      keyboardType: TextInputType.emailAddress,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
