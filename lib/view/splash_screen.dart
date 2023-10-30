import 'package:contact_app/utils/share_helper.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? status;

  @override
  void initState() {
    super.initState();
    createdata();
  }

  void createdata() async {
    ShareHelper shr = ShareHelper();
    await shr.getIntroStatus();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacementNamed(context,  status==true || status==null? 'intro':'contact');
      },
    );
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Image.asset(
            "assets/img/contact1.png",
            height: 100,
            width: 100,
          ),
        ),
      ),
    );
  }
}
