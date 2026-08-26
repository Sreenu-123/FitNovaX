import 'package:flutter/material.dart';
import 'package:fit_nova_x/MainScreens/workout_schedule_screen.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final Color blue = const Color(0xFF008CFF);

  int? expandedCategory;

  void openWorkoutSchedule() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WorkoutScheduleScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // ============================================================
      // APP BAR
      // ============================================================
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,

        title: const Text(
          'Workouts',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: openWorkoutSchedule,
            icon: const Icon(Icons.tune_rounded, color: Colors.white, size: 25),
          ),
        ],
      ),

      // ============================================================
      // BODY
      // ============================================================
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 30),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // ====================================================
              // FEATURED WORKOUT
              // ====================================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  const Text(
                    'Featured Workout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  TextButton(
                    onPressed: openWorkoutSchedule,

                    child: Text(
                      'View All',
                      style: TextStyle(
                        color: blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              GestureDetector(
                onTap: openWorkoutSchedule,

                child: Container(
                  height: 260,
                  width: double.infinity,

                  decoration: BoxDecoration(
                    color: const Color(0xFF08111A),

                    borderRadius: BorderRadius.circular(16),

                    border: Border.all(color: const Color(0xFF172331)),
                  ),

                  child: Stack(
                    children: [
                      // ==================================================
                      // BACKGROUND CIRCLE
                      // ==================================================
                      Positioned(
                        right: -60,
                        top: 0,

                        child: Container(
                          height: 220,
                          width: 220,

                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: blue.withValues(alpha: 0.08),
                          ),
                        ),
                      ),

                      // ==================================================
                      // FEATURED CONTENT
                      // ==================================================
                      Padding(
                        padding: const EdgeInsets.all(18),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            const Text(
                              'Push Day',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 6),

                            const Text(
                              'Build Upper Body\nStrength',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                                height: 1.4,
                              ),
                            ),

                            const Spacer(),

                            const Row(
                              children: [
                                Icon(
                                  Icons.fitness_center,
                                  color: Colors.white70,
                                  size: 15,
                                ),

                                SizedBox(width: 6),

                                Text(
                                  '6 Exercises • 45 Min',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 14),

                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: openWorkoutSchedule,

                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: blue,

                                    minimumSize: const Size(75, 40),

                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),

                                  child: const Text(
                                    'Start',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                const Spacer(),

                                Container(
                                  height: 48,
                                  width: 48,

                                  decoration: BoxDecoration(
                                    color: blue,
                                    shape: BoxShape.circle,
                                  ),

                                  child: const Icon(
                                    Icons.play_arrow_rounded,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // ====================================================
              // WORKOUT CATEGORIES
              // ====================================================
              const Text(
                'Workout Categories',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 14),

              // ====================================================
              // PUSH
              // ====================================================
              _categoryCard(
                0,
                Icons.fitness_center_rounded,
                'Push',
                'Build pushing strength',
                [
                  'Bench Press',
                  'Shoulder Press',
                  'Incline Dumbbell Press',
                  'Triceps Pushdown',
                ],
              ),

              const SizedBox(height: 12),

              // ====================================================
              // PULL
              // ====================================================
              _categoryCard(
                1,
                Icons.sync_alt_rounded,
                'Pull',
                'Build pulling strength',
                [
                  'Lat Pulldown',
                  'Seated Cable Row',
                  'Barbell Row',
                  'Bicep Curl',
                ],
              ),

              const SizedBox(height: 12),

              // ====================================================
              // LEGS
              // ====================================================
              _categoryCard(
                2,
                Icons.directions_run_rounded,
                'Legs',
                'Build lower body strength',
                ['Squats', 'Leg Press', 'Romanian Deadlift', 'Leg Curl'],
              ),

              const SizedBox(height: 12),

              // ====================================================
              // CORE
              // ====================================================
              _categoryCard(
                3,
                Icons.tune_rounded,
                'Core',
                'Build a stronger core',
                ['Plank', 'Crunches', 'Leg Raises', 'Russian Twist'],
              ),

              const SizedBox(height: 12),

              // ====================================================
              // HIIT
              // ====================================================
              _categoryCard(
                4,
                Icons.timer_outlined,
                'HIIT',
                'Burn calories and get fit',
                ['Jumping Jacks', 'Mountain Climbers', 'Burpees', 'High Knees'],
              ),

              const SizedBox(height: 12),

              // ====================================================
              // FULL BODY
              // ====================================================
              _categoryCard(
                5,
                Icons.accessibility_new_rounded,
                'Full Body',
                'Complete full body workout',
                ['Squats', 'Push Ups', 'Rows', 'Lunges'],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // EXPANDABLE CATEGORY CARD
  // ============================================================

  Widget _categoryCard(
    int index,
    IconData icon,
    String title,
    String subtitle,
    List<String> exercises,
  ) {
    final bool isExpanded = expandedCategory == index;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),

      decoration: BoxDecoration(
        color: const Color(0xFF0A141F),

        borderRadius: BorderRadius.circular(14),

        border: Border.all(
          color: isExpanded ? blue : const Color(0xFF172331),

          width: isExpanded ? 1.5 : 1,
        ),
      ),

      child: Column(
        children: [
          // ========================================================
          // CARD HEADER
          // ========================================================
          InkWell(
            borderRadius: BorderRadius.circular(14),

            onTap: () {
              setState(() {
                if (expandedCategory == index) {
                  expandedCategory = null;
                } else {
                  expandedCategory = index;
                }
              });
            },

            child: Padding(
              padding: const EdgeInsets.all(14),

              child: Row(
                children: [
                  Container(
                    height: 48,
                    width: 48,

                    decoration: BoxDecoration(
                      color: blue.withValues(alpha: 0.12),

                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Icon(icon, color: blue, size: 26),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          subtitle,
                          style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),

                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,

                    duration: const Duration(milliseconds: 200),

                    child: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.white60,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ========================================================
          // EXPANDED CONTENT
          // ========================================================
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),

            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,

            firstChild: const SizedBox.shrink(),

            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),

              child: Column(
                children: [
                  const Divider(color: Color(0xFF172331), height: 1),

                  const SizedBox(height: 12),

                  ...exercises.map((exercise) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 9),

                      child: Row(
                        children: [
                          Container(
                            height: 7,
                            width: 7,

                            decoration: BoxDecoration(
                              color: blue,
                              shape: BoxShape.circle,
                            ),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: Text(
                              exercise,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ),

                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white38,
                            size: 13,
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
