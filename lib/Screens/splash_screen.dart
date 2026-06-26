import 'package:flutter/material.dart';

class SplashScreen
    extends
        StatelessWidget {
  @override
  Widget
  build(
    BuildContext
    context,
  ) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/Images/logoNoBack.png',
              width: 180,
              height: 180,
            ),
          ),

          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'FitNovaX',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 33,
                  ),
                ),

                SizedBox(
                  height: 0,
                ),

                Text(
                  'Train. Level Up. Conquer',
                  style: TextStyle(
                    color: Color.fromARGB(
                      255,
                      198,
                      197,
                      197,
                    ),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
