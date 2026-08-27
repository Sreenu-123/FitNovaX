import 'package:flutter/material.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  static const Color blue = Color(0xFF008CFF);

  final List<Map<String, dynamic>> reminders = [
    {
      'title': 'Workout',
      'subtitle': 'Time for your daily workout',
      'time': '6:00 PM',
      'icon': Icons.fitness_center_rounded,
      'enabled': true,
    },
    {
      'title': 'Drink Water',
      'subtitle': 'Stay hydrated throughout the day',
      'time': 'Every 2 hours',
      'icon': Icons.water_drop_rounded,
      'enabled': true,
    },
    {
      'title': 'Sleep',
      'subtitle': 'Prepare for a good night of sleep',
      'time': '10:30 PM',
      'icon': Icons.bedtime_rounded,
      'enabled': false,
    },
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
          'Reminders',
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
                'Stay on Track',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Set reminders to stay consistent with your goals.',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),

              const SizedBox(height: 24),

              // ====================================================
              // SUMMARY CARD
              // ====================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: const Color(0xFF08131F),
                  borderRadius: BorderRadius.circular(18),

                  border: Border.all(color: const Color(0xFF142333)),
                ),

                child: Row(
                  children: [
                    Container(
                      height: 52,
                      width: 52,

                      decoration: BoxDecoration(
                        color: blue.withValues(alpha: 0.10),
                        shape: BoxShape.circle,
                      ),

                      child: const Icon(
                        Icons.notifications_active_outlined,
                        color: blue,
                        size: 27,
                      ),
                    ),

                    const SizedBox(width: 14),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Active Reminders',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            'Keep your fitness routine consistent',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Text(
                      '${reminders.where((item) => item['enabled'] == true).length}',
                      style: const TextStyle(
                        color: blue,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ====================================================
              // REMINDERS
              // ====================================================
              const Text(
                'Your Reminders',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              ...List.generate(reminders.length, (index) {
                return _reminderCard(index);
              }),

              const SizedBox(height: 20),

              // ====================================================
              // ADD REMINDER
              // ====================================================
              GestureDetector(
                onTap: _showAddReminderSheet,

                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),

                  decoration: BoxDecoration(
                    color: blue.withValues(alpha: 0.08),

                    borderRadius: BorderRadius.circular(15),

                    border: Border.all(color: blue.withValues(alpha: 0.35)),
                  ),

                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Icon(Icons.add_rounded, color: blue, size: 21),

                      SizedBox(width: 8),

                      Text(
                        'Add New Reminder',
                        style: TextStyle(
                          color: blue,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ====================================================
              // TIP
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
                            'Consistency Tip',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            'Small daily habits become big results. '
                            'Use reminders to stay consistent.',
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
  // REMINDER CARD
  // ==============================================================

  Widget _reminderCard(int index) {
    final reminder = reminders[index];

    final bool enabled = reminder['enabled'];

    return Container(
      margin: const EdgeInsets.only(bottom: 10),

      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: const Color(0xFF08131F),

        borderRadius: BorderRadius.circular(16),

        border: Border.all(
          color: enabled
              ? blue.withValues(alpha: 0.20)
              : const Color(0xFF142333),
        ),
      ),

      child: Row(
        children: [
          // Icon
          Container(
            height: 44,
            width: 44,

            decoration: BoxDecoration(
              color: enabled
                  ? blue.withValues(alpha: 0.10)
                  : Colors.white.withValues(alpha: 0.05),

              borderRadius: BorderRadius.circular(12),
            ),

            child: Icon(
              reminder['icon'],
              color: enabled ? blue : Colors.white38,
              size: 22,
            ),
          ),

          const SizedBox(width: 12),

          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reminder['title'],
                  style: TextStyle(
                    color: enabled ? Colors.white : Colors.white54,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  reminder['subtitle'],
                  style: const TextStyle(color: Colors.white38, fontSize: 10),
                ),

                const SizedBox(height: 5),

                Text(
                  reminder['time'],
                  style: TextStyle(
                    color: enabled ? blue : Colors.white38,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Switch
          Switch(
            value: enabled,

            activeThumbColor: Colors.white,
            activeTrackColor: blue,

            inactiveThumbColor: Colors.white54,
            inactiveTrackColor: const Color(0xFF202832),

            onChanged: (value) {
              setState(() {
                reminder['enabled'] = value;
              });
            },
          ),
        ],
      ),
    );
  }

  // ==============================================================
  // ADD REMINDER SHEET
  // ==============================================================

  void _showAddReminderSheet() {
    showModalBottomSheet(
      context: context,

      backgroundColor: const Color(0xFF08131F),

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),

      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 25),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                Container(
                  height: 4,
                  width: 40,

                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 22),

                const Text(
                  'Add Reminder',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                _reminderOption(
                  icon: Icons.fitness_center_rounded,
                  title: 'Workout Reminder',
                ),

                const SizedBox(height: 10),

                _reminderOption(
                  icon: Icons.restaurant_outlined,
                  title: 'Meal Reminder',
                ),

                const SizedBox(height: 10),

                _reminderOption(
                  icon: Icons.water_drop_outlined,
                  title: 'Water Reminder',
                ),

                const SizedBox(height: 10),

                _reminderOption(
                  icon: Icons.bedtime_outlined,
                  title: 'Sleep Reminder',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ==============================================================
  // REMINDER OPTION
  // ==============================================================

  Widget _reminderOption({required IconData icon, required String title}) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$title selected'),
            duration: const Duration(seconds: 2),
          ),
        );
      },

      child: Container(
        width: double.infinity,

        padding: const EdgeInsets.all(15),

        decoration: BoxDecoration(
          color: const Color(0xFF101C29),

          borderRadius: BorderRadius.circular(14),

          border: Border.all(color: const Color(0xFF172A3A)),
        ),

        child: Row(
          children: [
            Icon(icon, color: blue, size: 23),

            const SizedBox(width: 13),

            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),

            const Spacer(),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white38,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
