import 'package:contact_app/provider/theme_provider.dart';
import 'package:contact_app/utils/share_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/contact_provider.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  ContactProvider? providerw;
  ContactProvider? providerr;

  @override
  Widget build(BuildContext context) {
    providerw = context.watch<ContactProvider>();
    providerr = context.read<ContactProvider>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Calculator App"),
          actions: [
            Consumer<ThemeProvider>(
              builder: (context, value1, child) => Switch(
                value: value1.islight,
                onChanged: (value) {
                  ShareHelper shr = ShareHelper();
                  shr.setTheme(false);
                  value1.changeTheme();
                },
              ),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: providerw!.contactList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.10,
                width: MediaQuery.of(context).size.width * 0.10,
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.18,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.deepPurple),
                    ),
                    Column(
                      children: [
                        Text("${providerr!.contactList[index].name}"),
                        Text("${providerr!.contactList[index].contact}"),
                        Text("${providerr!.contactList[index].email}"),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'addContact');
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
