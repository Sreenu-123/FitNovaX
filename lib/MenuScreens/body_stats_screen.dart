import 'package:flutter/material.dart';

class BodyStatsScreen extends StatefulWidget {
  const BodyStatsScreen({super.key});

  @override
  State<BodyStatsScreen> createState() => _BodyStatsScreenState();
}

class _BodyStatsScreenState extends State<BodyStatsScreen> {
  static const Color blue = Color(0xFF008CFF);

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
          'Body Stats',
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
                'Your Body Stats',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Track and monitor your physical progress.',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),

              const SizedBox(height: 24),

              // ====================================================
              // MAIN STATS
              // ====================================================
              Row(
                children: [
                  Expanded(
                    child: _statCard(
                      icon: Icons.height_rounded,
                      value: '175',
                      unit: 'cm',
                      title: 'Height',
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _statCard(
                      icon: Icons.monitor_weight_outlined,
                      value: '72',
                      unit: 'kg',
                      title: 'Weight',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: _statCard(
                      icon: Icons.cake_outlined,
                      value: '21',
                      unit: 'yrs',
                      title: 'Age',
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _statCard(
                      icon: Icons.speed_rounded,
                      value: '23.5',
                      unit: 'BMI',
                      title: 'Body Mass Index',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // ====================================================
              // BMI
              // ====================================================
              const Text(
                'BMI',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: const Color(0xFF08131F),
                  borderRadius: BorderRadius.circular(16),

                  border: Border.all(color: const Color(0xFF142333)),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '23.5',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 11,
                            vertical: 6,
                          ),

                          decoration: BoxDecoration(
                            color: blue.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: const Text(
                            'Normal',
                            style: TextStyle(
                              color: blue,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),

                      child: LinearProgressIndicator(
                        value: 0.52,
                        minHeight: 8,

                        backgroundColor: const Color(0xFF172331),

                        valueColor: const AlwaysStoppedAnimation<Color>(blue),
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Underweight',
                          style: TextStyle(color: Colors.white38, fontSize: 9),
                        ),
                        Text(
                          'Normal',
                          style: TextStyle(color: Colors.white54, fontSize: 9),
                        ),
                        Text(
                          'Overweight',
                          style: TextStyle(color: Colors.white38, fontSize: 9),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ====================================================
              // BODY MEASUREMENTS
              // ====================================================
              const Text(
                'Body Measurements',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
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
                  children: [
                    _measurementRow('Chest', '98 cm'),

                    _divider(),

                    _measurementRow('Waist', '82 cm'),

                    _divider(),

                    _measurementRow('Arms', '34 cm'),

                    _divider(),

                    _measurementRow('Thighs', '56 cm'),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ====================================================
              // UPDATE BUTTON
              // ====================================================
              SizedBox(
                width: double.infinity,
                height: 52,

                child: ElevatedButton.icon(
                  onPressed: () {
                    // Later: Update body stats
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: blue,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),

                  icon: const Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                    size: 19,
                  ),

                  label: const Text(
                    'Update Body Stats',
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

  // ==============================================================
  // STAT CARD
  // ==============================================================

  Widget _statCard({
    required IconData icon,
    required String value,
    required String unit,
    required String title,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: const Color(0xFF08131F),

        borderRadius: BorderRadius.circular(16),

        border: Border.all(color: const Color(0xFF142333)),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 38,
            width: 38,

            decoration: BoxDecoration(
              color: blue.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(11),
            ),

            child: Icon(icon, color: blue, size: 21),
          ),

          const SizedBox(height: 13),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(width: 4),

              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(
                  unit,
                  style: const TextStyle(color: Colors.white54, fontSize: 10),
                ),
              ),
            ],
          ),

          const SizedBox(height: 3),

          Text(
            title,
            style: const TextStyle(color: Colors.white54, fontSize: 11),
          ),
        ],
      ),
    );
  }

  // ==============================================================
  // MEASUREMENT ROW
  // ==============================================================

  Widget _measurementRow(String title, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ),

        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ==============================================================
  // DIVIDER
  // ==============================================================

  Widget _divider() {
    return const Divider(color: Color(0xFF172331), height: 22);
  }
}
