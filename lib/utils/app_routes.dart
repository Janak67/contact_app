import 'package:contact_app/view/add_contact_screen.dart';
import 'package:contact_app/view/contact_screen.dart';
import 'package:flutter/cupertino.dart';

Map<String, WidgetBuilder> screen_routes = {
  '/': (context) => const ContactScreen(),
  'addContact': (context) => const AddContactScreen(),
};
