import 'package:flutter/material.dart';

class GoalScreen
    extends
        StatefulWidget {
  const GoalScreen({
    super.key,
  });

  @override
  State<
    GoalScreen
  >
  createState() =>
      _GoalScreenState();
}

class _GoalScreenState
    extends
        State<
          GoalScreen
        > {
  int?
  selectedGoal;
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
          'Goal Screen',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Select Your Goal',
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
              'Choose your fitness goal to get started.',
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
                  selectedGoal = 0;
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
                    selectedGoal ==
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
                      selectedGoal ==
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
                        'Build Muscle',
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
                        'Gain strength and muscle mass',
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
                  selectedGoal = 1;
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
                    selectedGoal ==
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
                      selectedGoal ==
                          1
                      ? Colors.blue
                      : Colors.grey.shade800,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.monitor_weight,
                    color: Colors.green,
                    size: 35,
                  ),

                  SizedBox(
                    width: 15,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lose Weight',
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
                        'Burn fat and reduce body weight',
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
                  selectedGoal = 2;
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
                    selectedGoal ==
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
                      selectedGoal ==
                          2
                      ? Colors.blue
                      : Colors.grey.shade800,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.orange,
                    size: 35,
                  ),

                  SizedBox(
                    width: 15,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Stay Fit',
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
                        'Maintain a healthy lifestyle ',
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
                  selectedGoal = 3;
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
                    selectedGoal ==
                        3
                    ? Colors.blue
                    : const Color(
                        0xFF1A1A1A,
                      ),
                borderRadius: BorderRadius.circular(
                  15,
                ),
                border: Border.all(
                  color:
                      selectedGoal ==
                          3
                      ? Colors.blue
                      : Colors.grey.shade800,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.directions_run,
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
                        'Improve Endurance',
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
                        'Increase stamina and cardio fitness',
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
            height: 35,
          ),

          SizedBox(
            width: 170,
            height: 50,
            child: ElevatedButton(
              onPressed:
                  // Next Screen
                  selectedGoal ==
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
    );
  }
}
