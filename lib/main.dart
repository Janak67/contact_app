import 'package:contact_app/provider/theme_provider.dart';
import 'package:contact_app/utils/app_routes.dart';
import 'package:contact_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: value.islight ? lightTheme : darkTheme,
          routes: screen_routes,
        ),
      ),
    ),
  );
}
