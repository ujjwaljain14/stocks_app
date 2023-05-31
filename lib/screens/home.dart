import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget{

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: TextButton(
          child: const Text('Log Out'),
          onPressed: ()=>Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
