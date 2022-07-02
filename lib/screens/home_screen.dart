import 'package:activos_app/screens/nav_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
      ),
      drawer: NavBar(),
      body: const Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
