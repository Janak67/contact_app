import 'package:contact_app/utils/share_helper.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IntroductionScreen(
          pages: [
            PageViewModel(
              title: "Title of introduction page",
              body:
                  "Welcome to the app! This is a description of how it works.",
            ),
            PageViewModel(
              title: "Title of introduction page",
              body:
                  "Welcome to the app! This is a description of how it works.",
            ),
            PageViewModel(
              title: "Title of introduction page",
              body:
                  "Welcome to the app! This is a description of how it works.",
            ),
          ],
          showDoneButton: true,
          onDone: () {
            ShareHelper shr = ShareHelper();
            shr.setIntroStatus();
            Navigator.pushReplacementNamed(context, 'contact');
          },
          done: const Text("Done"),
          showNextButton: true,
          next: const Text("Next"),
        ),
      ),
    );
  }
}
