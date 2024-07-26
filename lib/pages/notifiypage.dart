import 'package:flutter/material.dart';

class Notifiypage extends StatefulWidget {
  const Notifiypage({super.key});

  @override
  State<Notifiypage> createState() => _NotifiypageState();
}

class _NotifiypageState extends State<Notifiypage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
        child: Text("this is notify page"),
      ),
    );
  }
}
