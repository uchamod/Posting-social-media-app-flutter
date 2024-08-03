import 'package:flutter/material.dart';

class SerchPage extends StatefulWidget {
  const SerchPage({super.key});

  @override
  State<SerchPage> createState() => _SerchPageState();
}

class _SerchPageState extends State<SerchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          
          decoration: InputDecoration(
            filled: true,
            fillColor: ,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(width: 0)

            )
          ),
        ),
      ),
      body: Center(
        child: Text("this is serch page"),
      ),
    );
  }
}
