import 'package:flutter/material.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  static const Color blue = Color(0xFF008CFF);

  final List<Map<String, dynamic>> achievements = [
    {
      'title': 'First Workout',
      'description': 'Complete your first workout',
      'icon': Icons.fitness_center_rounded,
      'unlocked': true,
      'progress': 1.0,
      'current': '1',
      'target': '1',
    },
    {
      'title': '7 Day Streak',
      'description': 'Work out for 7 consecutive days',
      'icon': Icons.local_fire_department_rounded,
      'unlocked': true,
      'progress': 1.0,
      'current': '7',
      'target': '7',
    },
    {
      'title': 'Hydration Hero',
      'description': 'Reach your water goal for 7 days',
      'icon': Icons.water_drop_rounded,
      'unlocked': false,
      'progress': 0.57,
      'current': '4',
      'target': '7',
    },
    {
      'title': '10 Workouts',
      'description': 'Complete 10 workouts',
      'icon': Icons.emoji_events_rounded,
      'unlocked': false,
      'progress': 0.70,
      'current': '7',
      'target': '10',
    },
    {
      'title': 'Early Bird',
      'description': 'Complete 5 morning workouts',
      'icon': Icons.wb_sunny_outlined,
      'unlocked': false,
      'progress': 0.40,
      'current': '2',
      'target': '5',
    },
    {
      'title': 'Fitness Master',
      'description': 'Complete 50 workouts',
      'icon': Icons.workspace_premium_rounded,
      'unlocked': false,
      'progress': 0.14,
      'current': '7',
      'target': '50',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final int unlockedCount = achievements
        .where((achievement) => achievement['unlocked'] == true)
        .length;

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),

        title: const Text(
          'Achievements',
          style: TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

          padding: const EdgeInsets.fromLTRB(16, 10, 16, 30),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ====================================================
              // HEADER
              // ====================================================
              const Text(
                'Your Achievements',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Keep pushing yourself and unlock new milestones.',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),

              const SizedBox(height: 24),

              // ====================================================
              // SUMMARY CARD
              // ====================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: const Color(0xFF08131F),
                  borderRadius: BorderRadius.circular(20),

                  border: Border.all(color: const Color(0xFF142333)),
                ),

                child: Row(
                  children: [
                    Container(
                      height: 62,
                      width: 62,

                      decoration: BoxDecoration(
                        color: blue.withValues(alpha: 0.10),
                        shape: BoxShape.circle,
                      ),

                      child: const Icon(
                        Icons.emoji_events_rounded,
                        color: blue,
                        size: 32,
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Milestones Unlocked',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            '$unlockedCount of ${achievements.length} achievements',
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 11,
                            ),
                          ),

                          const SizedBox(height: 10),

                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),

                            child: LinearProgressIndicator(
                              value: unlockedCount / achievements.length,

                              minHeight: 7,

                              backgroundColor: const Color(0xFF172331),

                              valueColor: const AlwaysStoppedAnimation<Color>(
                                blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ====================================================
              // UNLOCKED
              // ====================================================
              const Text(
                'Unlocked',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              ...List.generate(achievements.length, (index) {
                if (achievements[index]['unlocked'] != true) {
                  return const SizedBox();
                }

                return _achievementCard(achievements[index]);
              }),

              const SizedBox(height: 18),

              // ====================================================
              // IN PROGRESS
              // ====================================================
              const Text(
                'In Progress',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              ...List.generate(achievements.length, (index) {
                if (achievements[index]['unlocked'] == true) {
                  return const SizedBox();
                }

                return _achievementCard(achievements[index]);
              }),
            ],
          ),
        ),
      ),
    );
  }

  // ==============================================================
  // ACHIEVEMENT CARD
  // ==============================================================

  Widget _achievementCard(Map<String, dynamic> achievement) {
    final bool unlocked = achievement['unlocked'];
    final double progress = achievement['progress'];

    return Container(
      width: double.infinity,

      margin: const EdgeInsets.only(bottom: 10),

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: const Color(0xFF08131F),

        borderRadius: BorderRadius.circular(17),

        border: Border.all(
          color: unlocked
              ? blue.withValues(alpha: 0.25)
              : const Color(0xFF142333),
        ),
      ),

      child: Row(
        children: [
          // ========================================================
          // ICON
          // ========================================================
          Container(
            height: 52,
            width: 52,

            decoration: BoxDecoration(
              color: unlocked
                  ? blue.withValues(alpha: 0.12)
                  : Colors.white.withValues(alpha: 0.05),

              borderRadius: BorderRadius.circular(15),
            ),

            child: Icon(
              achievement['icon'],
              color: unlocked ? blue : Colors.white30,
              size: 27,
            ),
          ),

          const SizedBox(width: 14),

          // ========================================================
          // CONTENT
          // ========================================================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        achievement['title'],
                        style: TextStyle(
                          color: unlocked ? Colors.white : Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    if (unlocked)
                      const Icon(
                        Icons.check_circle_rounded,
                        color: blue,
                        size: 18,
                      )
                    else
                      const Icon(
                        Icons.lock_outline_rounded,
                        color: Colors.white30,
                        size: 17,
                      ),
                  ],
                ),

                const SizedBox(height: 4),

                Text(
                  achievement['description'],
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),

                const SizedBox(height: 9),

                if (!unlocked) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),

                    child: LinearProgressIndicator(
                      value: progress,

                      minHeight: 5,

                      backgroundColor: const Color(0xFF172331),

                      valueColor: const AlwaysStoppedAnimation<Color>(blue),
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    '${achievement['current']} / ${achievement['target']}',
                    style: const TextStyle(color: Colors.white38, fontSize: 9),
                  ),
                ] else
                  const Text(
                    'Achievement unlocked',
                    style: TextStyle(
                      color: blue,
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
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
