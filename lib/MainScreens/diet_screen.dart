import 'package:flutter/material.dart';

class DietScreen
    extends
        StatefulWidget {
  @override
  State<
    DietScreen
  >
  createState() =>
      _DietScreenState();
}

class _DietScreenState
    extends
        State<
          DietScreen
        > {
  @override
  Widget
  build(
    BuildContext
    context,
  ) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Diet Plan',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(
          20,
        ),
        child: Text(
          'Your Diet Plan',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
