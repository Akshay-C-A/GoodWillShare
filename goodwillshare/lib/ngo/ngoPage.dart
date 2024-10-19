import 'package:flutter/material.dart';

class NGO_Page extends StatefulWidget {
  const NGO_Page({super.key});

  @override
  State<NGO_Page> createState() => _NGO_PageState();
}

class _NGO_PageState extends State<NGO_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NGO Page"),
      ),
      body: Text("Hello"),
    );
  }
}
