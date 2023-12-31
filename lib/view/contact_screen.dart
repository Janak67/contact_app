import 'dart:io';
import 'dart:math';

import 'package:contact_app/provider/theme_provider.dart';
import 'package:contact_app/utils/share_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/contact_provider.dart';
import '../utils/colors_list.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  ContactProvider? providerw;
  ContactProvider? providerr;

  getRandomColor() {
    Random random = Random();
    return backgroundColor[random.nextInt(backgroundColor.length)];
  }

  @override
  Widget build(BuildContext context) {
    providerw = context.watch<ContactProvider>();
    providerr = context.read<ContactProvider>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Contact App"),
          actions: [
            Consumer<ThemeProvider>(
              builder: (context, value1, child) => Switch(
                value: value1.islight,
                onChanged: (value) {
                  ShareHelper shr = ShareHelper();
                  shr.setTheme(value);
                  value1.changeTheme();
                },
              ),
            ),
          ],
          leading: IconButton(
              onPressed: () async {
                bool? isLogin = await providerr!.bioMatrix();
                if (isLogin != null) {
                  if (isLogin == true) {
                    providerr!.isPrivate = true;
                    Navigator.pushNamed(context, 'hideContact');
                  }
                }
              },
              icon: const Icon(Icons.remove_red_eye_outlined)),
        ),
        body: ListView.builder(
          itemCount: providerw!.contactList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  providerr!.storeIndex(index);
                  providerr!.isLock = false;
                  Navigator.pushNamed(context, 'contactInfo',
                      arguments: providerr!.contactList[index]);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.10,
                  width: MediaQuery.of(context).size.width * 0.10,
                  decoration: BoxDecoration(
                      color: grey,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        providerw!.contactList[index].image != null
                            ? CircleAvatar(
                                radius: 30,
                                backgroundImage: FileImage(
                                  File(
                                      "${providerw!.contactList[index].image}"),
                                ),
                              )
                            : Align(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  radius: 30,
                                  child: Text(
                                    "${providerw!.contactList[index].name!.isNotEmpty ? providerw!.contactList[index].name!.substring(0, 1).toUpperCase() : 0}",
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                              ),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${providerr!.contactList[index].name}",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text("${providerr!.contactList[index].contact}"),
                          ],
                        ),
                      ],
                    ),
                  ),
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
