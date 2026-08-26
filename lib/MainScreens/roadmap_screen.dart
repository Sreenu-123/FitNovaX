import 'package:flutter/material.dart';

class RoadmapScreen extends StatefulWidget {
  const RoadmapScreen({super.key});

  @override
  State<RoadmapScreen> createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends State<RoadmapScreen> {
  final Color blue = const Color(0xFF008CFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =====================================================
              // TITLE
              // =====================================================
              const Text(
                'Roadmap',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Your Transformation Journey',
                style: TextStyle(color: Colors.white60, fontSize: 12),
              ),

              const SizedBox(height: 28),

              // =====================================================
              // ROADMAP TIMELINE
              // =====================================================
              SizedBox(
                height: 90,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _roadmapMonth(
                      month: 'Month 1',
                      title: 'Foundation',
                      state: RoadmapState.completed,
                    ),

                    _roadmapLine(active: true),

                    _roadmapMonth(
                      month: 'Month 2',
                      title: 'Strength',
                      state: RoadmapState.current,
                    ),

                    _roadmapLine(active: false),

                    _roadmapMonth(
                      month: 'Month 3',
                      title: 'Shred',
                      state: RoadmapState.locked,
                    ),

                    _roadmapLine(active: false),

                    _roadmapMonth(
                      month: 'Month 4',
                      title: 'Transform',
                      state: RoadmapState.locked,
                    ),

                    _roadmapLine(active: false),

                    _roadmapMonth(
                      month: 'Month 5',
                      title: 'Mastery',
                      state: RoadmapState.locked,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // =====================================================
              // MONTH 3 PROGRESS
              // =====================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),

                decoration: BoxDecoration(
                  color: const Color(0xFF08131F),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF172331)),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Month 3 - Progress',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      '4 of 5 weeks completed',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),

                    const SizedBox(height: 14),

                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),

                            child: LinearProgressIndicator(
                              value: 0.80,
                              minHeight: 8,
                              backgroundColor: const Color(0xFF172331),
                              valueColor: AlwaysStoppedAnimation<Color>(blue),
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        const Text(
                          '80%',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    const Divider(color: Color(0xFF172331), height: 1),

                    const SizedBox(height: 16),

                    const Text(
                      "This Month's Focus",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 14),

                    _focusItem(
                      Icons.fitness_center_rounded,
                      'Increase workout intensity',
                    ),

                    const SizedBox(height: 12),

                    _focusItem(
                      Icons.water_drop_outlined,
                      'Improve strength & endurance',
                    ),

                    const SizedBox(height: 12),

                    _focusItem(
                      Icons.restaurant_outlined,
                      'Track nutrition consistently',
                    ),

                    const SizedBox(height: 12),

                    _focusItem(
                      Icons.location_on_outlined,
                      'Stay consistent every day',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // =====================================================
              // MONTH PROGRESS
              // =====================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),

                decoration: BoxDecoration(
                  color: const Color(0xFF08131F),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF172331)),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Month Progress',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 18),

                    _progressItem(
                      title: 'Workouts',
                      value: '12 / 16',
                      progress: 0.75,
                    ),

                    const SizedBox(height: 16),

                    _progressItem(
                      title: 'Nutrition',
                      value: '24 / 30',
                      progress: 0.80,
                    ),

                    const SizedBox(height: 16),

                    _progressItem(
                      title: 'Cardio',
                      value: '6 / 8',
                      progress: 0.75,
                    ),

                    const SizedBox(height: 16),

                    _progressItem(
                      title: 'Consistency',
                      value: '20 / 25',
                      progress: 0.80,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // =====================================================
              // VIEW MONTH DETAILS BUTTON
              // =====================================================
              SizedBox(
                width: double.infinity,
                height: 48,

                child: ElevatedButton(
                  onPressed: () {
                    // Later: Open month details
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: blue,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  child: const Text(
                    'View Month Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===============================================================
  // ROADMAP MONTH
  // ===============================================================

  Widget _roadmapMonth({
    required String month,
    required String title,
    required RoadmapState state,
  }) {
    final bool completed = state == RoadmapState.completed;
    final bool current = state == RoadmapState.current;

    return SizedBox(
      width: 42,

      child: Column(
        children: [
          Container(
            height: 32,
            width: 32,

            decoration: BoxDecoration(
              shape: BoxShape.circle,

              color: completed
                  ? const Color(0xFF092719)
                  : current
                  ? blue
                  : const Color(0xFF08131F),

              border: Border.all(
                color: completed
                    ? Colors.green
                    : current
                    ? blue
                    : const Color(0xFF172331),
              ),
            ),

            child: Icon(
              completed
                  ? Icons.check_rounded
                  : current
                  ? Icons.looks_3_rounded
                  : Icons.lock_outline_rounded,

              color: completed
                  ? Colors.green
                  : current
                  ? Colors.white
                  : Colors.white38,

              size: completed ? 20 : 17,
            ),
          ),

          const SizedBox(height: 7),

          Text(
            month,
            textAlign: TextAlign.center,
            maxLines: 1,

            style: TextStyle(
              color: state == RoadmapState.locked
                  ? Colors.white54
                  : Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 2),

          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,

            style: const TextStyle(color: Colors.white54, fontSize: 8),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // ROADMAP LINE
  // ===============================================================

  Widget _roadmapLine({required bool active}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 15),

        child: Container(
          height: 3,

          decoration: BoxDecoration(
            color: active ? blue : const Color(0xFF172331),

            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  // ===============================================================
  // FOCUS ITEM
  // ===============================================================

  Widget _focusItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: blue, size: 18),

        const SizedBox(width: 12),

        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ),
      ],
    );
  }

  // ===============================================================
  // PROGRESS ITEM
  // ===============================================================

  Widget _progressItem({
    required String title,
    required String value,
    required double progress,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),

            Text(
              value,
              style: const TextStyle(color: Colors.white70, fontSize: 11),
            ),
          ],
        ),

        const SizedBox(height: 7),

        ClipRRect(
          borderRadius: BorderRadius.circular(10),

          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,

            backgroundColor: const Color(0xFF172331),

            valueColor: AlwaysStoppedAnimation<Color>(blue),
          ),
        ),
      ],
    );
  }
}

// ===============================================================
// ROADMAP STATE
// ===============================================================

enum RoadmapState { completed, current, locked }
