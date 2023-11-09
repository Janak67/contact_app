import 'package:contact_app/view/add_contact_screen.dart';
import 'package:contact_app/view/contact_info_screen.dart';
import 'package:contact_app/view/contact_screen.dart';
import 'package:contact_app/view/hide_contact_screen.dart';
import 'package:contact_app/view/intro_screen.dart';
import 'package:contact_app/view/splash_screen.dart';
import 'package:flutter/cupertino.dart';

Map<String, WidgetBuilder> screen_routes = {
  '/': (context) => const SplashScreen(),
  'intro': (context) => const IntroScreen(),
  'contact': (context) => const ContactScreen(),
  'addContact': (context) => const AddContactScreen(),
  'contactInfo':(context) => const ContactInfoScreen(),
  'hideContact':(context) => const HideContactScreen(),
};
