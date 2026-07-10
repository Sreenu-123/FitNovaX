import 'package:flutter/material.dart';

class WorkoutLocationScreen
    extends
        StatefulWidget {
  const WorkoutLocationScreen({
    super.key,
  });

  @override
  State<
    WorkoutLocationScreen
  >
  createState() =>
      _WorkoutLocationScreenState();
}

class _WorkoutLocationScreenState
    extends
        State<
          WorkoutLocationScreen
        > {
  int?
  selectedLocation;
  @override
  Widget
  build(
    BuildContext
    context,
  ) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Workout Location',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Where do you workout?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 5,
              ),
              child: Text(
                'Choose where you usually train.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                setState(
                  () {
                    selectedLocation = 0;
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
                      selectedLocation ==
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
                        selectedLocation ==
                            0
                        ? Colors.blue
                        : Colors.grey.shade800,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.home,
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
                          'Home',
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
                          'Train using bodyweight or home equipment',
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
                    selectedLocation = 1;
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
                      selectedLocation ==
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
                        selectedLocation ==
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
                          'Gym',
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
                          'Full Gym Equipment and Facilities',
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
                    selectedLocation = 2;
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
                      selectedLocation ==
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
                        selectedLocation ==
                            2
                        ? Colors.blue
                        : Colors.grey.shade800,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.swap_horiz,
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
                          'Both',
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
                          'Train at Home and at the Gym',
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
                    selectedLocation ==
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
