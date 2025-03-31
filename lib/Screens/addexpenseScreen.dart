import 'package:flutter/material.dart';

class Addexpensescreen extends StatefulWidget {
  const Addexpensescreen({super.key});

  @override
  State<Addexpensescreen> createState() => _AddexpensescreenState();
}

class _AddexpensescreenState extends State<Addexpensescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D2D2D),
      appBar: AppBar(
        title: const Text('Analytics'),
        backgroundColor: Colors.transparent,
      ),
      body: const Center(
        child: Text(
          'Add Expense Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
