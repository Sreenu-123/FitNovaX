import 'package:flutter/material.dart';

class RoadmapScreen
    extends
        StatefulWidget {
  @override
  State<
    RoadmapScreen
  >
  createState() =>
      _RoadmapScreenState();
}

class _RoadmapScreenState
    extends
        State<
          RoadmapScreen
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
          'Roadmap',
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
          'Your Roadmap',
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
