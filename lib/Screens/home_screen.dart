import 'package:flutter/material.dart';

class HomeScreen
    extends
        StatelessWidget {
  const HomeScreen({
    super.key,
  });

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
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.account_circle_outlined,
            color: Colors.white,
            size: 25,
          ),
          onPressed: () {
            // Handle back button press
          },
        ),
        title: const Text(
          "FX",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: const Center(
        child: Text(
          "Home Screen",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(
          20,
        ),
        height: 70,
        decoration: BoxDecoration(
          color: const Color(
            0xFF151515,
          ),
          borderRadius: BorderRadius.circular(
            35,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 20,
              offset: const Offset(
                0,
                8,
              ),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(
                Icons.home,
                color: Colors.white,
              ),
              onPressed: () {
                // Handle home button press
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.restaurant_menu,
                color: Colors.white,
              ),
              onPressed: () {
                // Handle search button press
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.route,
                color: Colors.white,
              ),
              onPressed: () {
                // Handle profile button press
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                // Handle profile button press
              },
            ),
          ],
        ),
      ),
    );
  }
}
