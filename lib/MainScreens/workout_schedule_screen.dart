import 'package:flutter/material.dart';

class WorkoutScheduleScreen
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
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Workout Schedule',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Weekly Plan',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(
                20,
              ),
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                  255,
                  25,
                  25,
                  25,
                ),
                borderRadius: BorderRadius.circular(
                  15,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.fitness_center,
                        color: Colors.white,
                        size: 20,
                      ),
                      Text(
                        ' Monday',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),

                  Text(
                    'Push Day',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),

                  SizedBox(
                    height: 5,
                  ),

                  Text(
                    'Chest • Shoulders • Triceps',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(
                20,
              ),
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                  255,
                  25,
                  25,
                  25,
                ),
                borderRadius: BorderRadius.circular(
                  15,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.directions_run,
                        color: Colors.white,
                        size: 20,
                      ),
                      Text(
                        ' Tuesday',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Leg Day',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Quads • Hamstrings • Calves',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
