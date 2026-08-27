import 'package:flutter/material.dart';

class WaterTrackerScreen extends StatefulWidget {
  const WaterTrackerScreen({super.key});

  @override
  State<WaterTrackerScreen> createState() => _WaterTrackerScreenState();
}

class _WaterTrackerScreenState extends State<WaterTrackerScreen> {
  static const Color blue = Color(0xFF008CFF);

  final int dailyGoal = 2500;
  int waterIntake = 1250;

  final List<int> waterHistory = [250, 500, 250, 250];

  @override
  Widget build(BuildContext context) {
    final double progress = (waterIntake / dailyGoal).clamp(0.0, 1.0);

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
          'Water Tracker',
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
                'Stay Hydrated',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Track your daily water intake and stay hydrated.',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),

              const SizedBox(height: 24),

              // ====================================================
              // MAIN WATER CARD
              // ====================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),

                decoration: BoxDecoration(
                  color: const Color(0xFF08131F),
                  borderRadius: BorderRadius.circular(20),

                  border: Border.all(color: const Color(0xFF142333)),
                ),

                child: Column(
                  children: [
                    // Water icon
                    Container(
                      height: 70,
                      width: 70,

                      decoration: BoxDecoration(
                        color: blue.withValues(alpha: 0.10),
                        shape: BoxShape.circle,
                      ),

                      child: const Icon(
                        Icons.water_drop_rounded,
                        color: blue,
                        size: 38,
                      ),
                    ),

                    const SizedBox(height: 16),

                    Text(
                      '$waterIntake ml',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'of $dailyGoal ml daily goal',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Progress
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),

                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 10,

                        backgroundColor: const Color(0xFF172331),

                        valueColor: const AlwaysStoppedAnimation<Color>(blue),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${(progress * 100).round()}% completed',
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 10,
                          ),
                        ),

                        Text(
                          '${dailyGoal - waterIntake > 0 ? dailyGoal - waterIntake : 0} ml remaining',
                          style: const TextStyle(
                            color: blue,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ====================================================
              // QUICK ADD
              // ====================================================
              const Text(
                'Quick Add',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(child: _quickAddButton(250)),

                  const SizedBox(width: 10),

                  Expanded(child: _quickAddButton(500)),

                  const SizedBox(width: 10),

                  Expanded(child: _quickAddButton(750)),
                ],
              ),

              const SizedBox(height: 28),

              // ====================================================
              // TODAY'S INTAKE
              // ====================================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Today's Intake",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    '${waterHistory.length} drinks',
                    style: const TextStyle(
                      color: blue,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: const Color(0xFF08131F),
                  borderRadius: BorderRadius.circular(16),

                  border: Border.all(color: const Color(0xFF142333)),
                ),

                child: Column(
                  children: List.generate(waterHistory.length, (index) {
                    return Column(
                      children: [
                        _intakeRow(
                          amount: waterHistory[index],
                          time: _getTime(index),
                        ),

                        if (index != waterHistory.length - 1)
                          const Divider(color: Color(0xFF172331), height: 20),
                      ],
                    );
                  }),
                ),
              ),

              const SizedBox(height: 28),

              // ====================================================
              // DAILY GOAL
              // ====================================================
              const Text(
                'Daily Goal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(17),

                decoration: BoxDecoration(
                  color: const Color(0xFF08131F),
                  borderRadius: BorderRadius.circular(16),

                  border: Border.all(color: const Color(0xFF142333)),
                ),

                child: Row(
                  children: [
                    Container(
                      height: 42,
                      width: 42,

                      decoration: BoxDecoration(
                        color: blue.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: const Icon(
                        Icons.flag_outlined,
                        color: blue,
                        size: 22,
                      ),
                    ),

                    const SizedBox(width: 12),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Daily Water Goal',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          SizedBox(height: 3),

                          Text(
                            'Your current hydration target',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Text(
                      '$dailyGoal ml',
                      style: const TextStyle(
                        color: blue,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ====================================================
              // HYDRATION TIP
              // ====================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: const Color(0xFF08131F),
                  borderRadius: BorderRadius.circular(16),

                  border: Border.all(color: const Color(0xFF142333)),
                ),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Container(
                      height: 36,
                      width: 36,

                      decoration: BoxDecoration(
                        color: blue.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: const Icon(
                        Icons.lightbulb_outline_rounded,
                        color: blue,
                        size: 20,
                      ),
                    ),

                    const SizedBox(width: 12),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hydration Tip',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            'Keep a water bottle with you during '
                            'the day and drink regularly instead '
                            'of waiting until you feel thirsty.',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 11,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==============================================================
  // QUICK ADD BUTTON
  // ==============================================================

  Widget _quickAddButton(int amount) {
    return GestureDetector(
      onTap: () {
        setState(() {
          waterIntake += amount;
          waterHistory.add(amount);
        });
      },

      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),

        decoration: BoxDecoration(
          color: const Color(0xFF08131F),

          borderRadius: BorderRadius.circular(14),

          border: Border.all(color: const Color(0xFF142333)),
        ),

        child: Column(
          children: [
            const Icon(Icons.water_drop_outlined, color: blue, size: 21),

            const SizedBox(height: 6),

            Text(
              '+$amount ml',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==============================================================
  // INTAKE ROW
  // ==============================================================

  Widget _intakeRow({required int amount, required String time}) {
    return Row(
      children: [
        Container(
          height: 38,
          width: 38,

          decoration: BoxDecoration(
            color: blue.withValues(alpha: 0.10),
            shape: BoxShape.circle,
          ),

          child: const Icon(Icons.water_drop_rounded, color: blue, size: 19),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$amount ml',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                time,
                style: const TextStyle(color: Colors.white38, fontSize: 9),
              ),
            ],
          ),
        ),

        const Icon(Icons.check_circle_rounded, color: blue, size: 18),
      ],
    );
  }

  // ==============================================================
  // TEMPORARY TIME
  // ==============================================================

  String _getTime(int index) {
    const times = ['8:30 AM', '11:15 AM', '2:00 PM', '5:30 PM'];

    if (index < times.length) {
      return times[index];
    }

    return 'Today';
  }
}
