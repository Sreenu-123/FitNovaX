import 'package:flutter/material.dart';

class SleepTrackerScreen extends StatefulWidget {
  const SleepTrackerScreen({super.key});

  @override
  State<SleepTrackerScreen> createState() => _SleepTrackerScreenState();
}

class _SleepTrackerScreenState extends State<SleepTrackerScreen> {
  static const Color blue = Color(0xFF008CFF);

  double sleepHours = 7.5;
  String sleepQuality = 'Good';

  final List<Map<String, dynamic>> weeklySleep = [
    {'day': 'Mon', 'hours': 7.5},
    {'day': 'Tue', 'hours': 8.0},
    {'day': 'Wed', 'hours': 6.5},
    {'day': 'Thu', 'hours': 7.0},
    {'day': 'Fri', 'hours': 8.0},
    {'day': 'Sat', 'hours': 7.5},
    {'day': 'Sun', 'hours': 6.5},
  ];

  @override
  Widget build(BuildContext context) {
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
          'Sleep Tracker',
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
                'Sleep & Recovery',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Track your sleep and improve your recovery.',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),

              const SizedBox(height: 24),

              // ====================================================
              // TODAY'S SLEEP
              // ====================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: const Color(0xFF08131F),
                  borderRadius: BorderRadius.circular(18),

                  border: Border.all(color: const Color(0xFF142333)),
                ),

                child: Column(
                  children: [
                    Container(
                      height: 62,
                      width: 62,

                      decoration: BoxDecoration(
                        color: blue.withValues(alpha: 0.10),
                        shape: BoxShape.circle,
                      ),

                      child: const Icon(
                        Icons.bedtime_rounded,
                        color: blue,
                        size: 31,
                      ),
                    ),

                    const SizedBox(height: 14),

                    const Text(
                      'Last Night',
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      '${sleepHours.toStringAsFixed(1)} hrs',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),

                      decoration: BoxDecoration(
                        color: blue.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: Text(
                        sleepQuality,
                        style: const TextStyle(
                          color: blue,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ====================================================
              // WEEKLY OVERVIEW
              // ====================================================
              const Text(
                'Weekly Overview',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(14, 20, 14, 16),

                decoration: BoxDecoration(
                  color: const Color(0xFF08131F),
                  borderRadius: BorderRadius.circular(16),

                  border: Border.all(color: const Color(0xFF142333)),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  crossAxisAlignment: CrossAxisAlignment.end,

                  children: weeklySleep.map((item) {
                    final double hours = item['hours'];

                    return _sleepBar(day: item['day'], hours: hours);
                  }).toList(),
                ),
              ),

              const SizedBox(height: 28),

              // ====================================================
              // SLEEP GOAL
              // ====================================================
              const Text(
                'Sleep Goal',
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

                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Recommended Sleep',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ),

                        const Text(
                          '8 hrs',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),

                      child: LinearProgressIndicator(
                        value: sleepHours / 8,
                        minHeight: 8,

                        backgroundColor: const Color(0xFF172331),

                        valueColor: const AlwaysStoppedAnimation<Color>(blue),
                      ),
                    ),

                    const SizedBox(height: 9),

                    Align(
                      alignment: Alignment.centerRight,

                      child: Text(
                        '${(8 - sleepHours).clamp(0, 8).toStringAsFixed(1)} hrs remaining',
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ====================================================
              // SLEEP QUALITY
              // ====================================================
              const Text(
                'How did you sleep?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  _qualityButton(
                    icon: Icons.sentiment_dissatisfied_outlined,
                    title: 'Poor',
                  ),

                  const SizedBox(width: 8),

                  _qualityButton(
                    icon: Icons.sentiment_neutral_outlined,
                    title: 'Okay',
                  ),

                  const SizedBox(width: 8),

                  _qualityButton(
                    icon: Icons.sentiment_satisfied_outlined,
                    title: 'Good',
                  ),

                  const SizedBox(width: 8),

                  _qualityButton(
                    icon: Icons.sentiment_very_satisfied_outlined,
                    title: 'Great',
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // ====================================================
              // LOG SLEEP BUTTON
              // ====================================================
              SizedBox(
                width: double.infinity,
                height: 52,

                child: ElevatedButton.icon(
                  onPressed: _logSleep,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: blue,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),

                  icon: const Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size: 20,
                  ),

                  label: const Text(
                    'Log Sleep',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ====================================================
              // RECOVERY TIP
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
                            'Recovery Tip',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            'Good sleep helps your body recover '
                            'and supports better workout performance.',
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
  // SLEEP BAR
  // ==============================================================

  Widget _sleepBar({required String day, required double hours}) {
    final double height = (hours / 8) * 100;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          '${hours.toStringAsFixed(1)}h',
          style: const TextStyle(color: Colors.white54, fontSize: 8),
        ),

        const SizedBox(height: 6),

        Container(
          height: height,
          width: 24,

          decoration: BoxDecoration(
            color: blue.withValues(alpha: 0.75),
            borderRadius: BorderRadius.circular(7),
          ),
        ),

        const SizedBox(height: 7),

        Text(day, style: const TextStyle(color: Colors.white54, fontSize: 9)),
      ],
    );
  }

  // ==============================================================
  // QUALITY BUTTON
  // ==============================================================

  Widget _qualityButton({required IconData icon, required String title}) {
    final bool selected = sleepQuality == title;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            sleepQuality = title;
          });
        },

        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),

          decoration: BoxDecoration(
            color: selected
                ? blue.withValues(alpha: 0.12)
                : const Color(0xFF08131F),

            borderRadius: BorderRadius.circular(13),

            border: Border.all(
              color: selected
                  ? blue.withValues(alpha: 0.6)
                  : const Color(0xFF142333),
            ),
          ),

          child: Column(
            children: [
              Icon(icon, color: selected ? blue : Colors.white54, size: 21),

              const SizedBox(height: 5),

              Text(
                title,
                style: TextStyle(
                  color: selected ? blue : Colors.white54,
                  fontSize: 9,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==============================================================
  // LOG SLEEP
  // ==============================================================

  void _logSleep() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sleep logged successfully'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
