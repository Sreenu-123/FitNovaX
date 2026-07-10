import 'package:flutter/material.dart';

class FitnessLevelScreen
    extends
        StatefulWidget {
  @override
  State<
    FitnessLevelScreen
  >
  createState() =>
      _FitnessLevelScreenState();
}

class _FitnessLevelScreenState
    extends
        State<
          FitnessLevelScreen
        > {
  int?
  selectedFitnessLevel;
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
        title: Text(
          'Fitness Level',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'What is your Fitness Level?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 5,
              ),
              child: Text(
                'Choose your current fitness experience',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                setState(
                  () {
                    selectedFitnessLevel = 0;
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                padding: const EdgeInsets.all(
                  24,
                ),
                decoration: BoxDecoration(
                  color:
                      selectedFitnessLevel ==
                          0
                      ? Colors.blue
                      : const Color(
                          0xFF1A1A1A,
                        ),
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                  border: Border.all(
                    color:
                        selectedFitnessLevel ==
                            0
                        ? Colors.blue
                        : Colors.grey.shade800,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.fitness_center,
                      color: Colors.white,
                      size: 35,
                    ),

                    SizedBox(
                      width: 15,
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Beginner',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        SizedBox(
                          height: 5,
                        ),

                        Text(
                          'New to fitness or just getting started',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                setState(
                  () {
                    selectedFitnessLevel = 1;
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                padding: const EdgeInsets.all(
                  24,
                ),
                decoration: BoxDecoration(
                  color:
                      selectedFitnessLevel ==
                          1
                      ? Colors.blue
                      : const Color(
                          0xFF1A1A1A,
                        ),
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                  border: Border.all(
                    color:
                        selectedFitnessLevel ==
                            1
                        ? Colors.blue
                        : Colors.grey.shade800,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.fitness_center,
                      color: Colors.white,
                      size: 35,
                    ),

                    SizedBox(
                      width: 15,
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Intermediate',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        SizedBox(
                          height: 5,
                        ),

                        Text(
                          'Regularly working out with some experience',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                setState(
                  () {
                    selectedFitnessLevel = 2;
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                padding: const EdgeInsets.all(
                  24,
                ),
                decoration: BoxDecoration(
                  color:
                      selectedFitnessLevel ==
                          2
                      ? Colors.blue
                      : const Color(
                          0xFF1A1A1A,
                        ),
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                  border: Border.all(
                    color:
                        selectedFitnessLevel ==
                            2
                        ? Colors.blue
                        : Colors.grey.shade800,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.fitness_center,
                      color: Colors.white,
                      size: 35,
                    ),

                    SizedBox(
                      width: 15,
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Advanced',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        SizedBox(
                          height: 5,
                        ),

                        Text(
                          'Experienced with structured training ',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 170,
              height: 50,
              child: ElevatedButton(
                onPressed:
                    // Next Screen
                    selectedFitnessLevel ==
                        null
                    ? null
                    : () {
                        // Next Screen
                      },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                  ),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
