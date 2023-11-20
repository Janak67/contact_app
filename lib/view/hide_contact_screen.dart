import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/contact_provider.dart';

class HideContactScreen extends StatefulWidget {
  const HideContactScreen({Key? key}) : super(key: key);

  @override
  State<HideContactScreen> createState() => _HideContactScreenState();
}

class _HideContactScreenState extends State<HideContactScreen> {
  ContactProvider? providerw;
  ContactProvider? providerr;

  @override
  Widget build(BuildContext context) {
    providerw = context.watch<ContactProvider>();
    providerr = context.read<ContactProvider>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Private Contact"),
        ),
        body: ListView.builder(
          itemCount: providerw!.hideContactList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  providerr!.storeIndex(index);
                  providerr!.isLock = true;
                  Navigator.pushNamed(context, 'contactInfo',
                      arguments: providerr!.hideContactList[index]);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.10,
                  width: MediaQuery.of(context).size.width * 0.10,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        providerw!.hideContactList[index].image != null
                            ? CircleAvatar(
                                radius: 30,
                                backgroundImage: FileImage(
                                  File(
                                      "${providerw!.hideContactList[index].image}"),
                                ),
                              )
                            : Align(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  radius: 30,
                                  child: Text(
                                    "${providerw!.hideContactList[index].name!.isNotEmpty ? providerw!.hideContactList[index].name!.substring(0, 1).toUpperCase() : 0}",
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
                              "${providerr!.hideContactList[index].name}",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                                "${providerr!.hideContactList[index].contact}"),
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
      ),
    );
  }
}
