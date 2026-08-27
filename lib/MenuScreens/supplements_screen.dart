import 'package:flutter/material.dart';

class SupplementsScreen extends StatefulWidget {
  const SupplementsScreen({super.key});

  @override
  State<SupplementsScreen> createState() => _SupplementsScreenState();
}

class _SupplementsScreenState extends State<SupplementsScreen> {
  static const Color blue = Color(0xFF008CFF);

  final List<Map<String, dynamic>> supplements = [
    {
      'name': 'Whey Protein',
      'purpose': 'Muscle recovery & protein intake',
      'timing': 'After Workout',
      'icon': Icons.local_drink_rounded,
      'taken': false,
    },
    {
      'name': 'Creatine',
      'purpose': 'Strength & workout performance',
      'timing': 'Daily',
      'icon': Icons.bolt_rounded,
      'taken': true,
    },
    {
      'name': 'Omega 3',
      'purpose': 'Heart & overall health',
      'timing': 'With Meal',
      'icon': Icons.favorite_outline_rounded,
      'taken': false,
    },
    {
      'name': 'Multivitamin',
      'purpose': 'Daily nutritional support',
      'timing': 'Morning',
      'icon': Icons.medication_outlined,
      'taken': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final int takenCount = supplements
        .where((supplement) => supplement['taken'] == true)
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
          'Supplements',
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
                'Daily Supplements',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Keep track of your daily supplement routine.',
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
                  borderRadius: BorderRadius.circular(19),

                  border: Border.all(color: const Color(0xFF142333)),
                ),

                child: Row(
                  children: [
                    Container(
                      height: 54,
                      width: 54,

                      decoration: BoxDecoration(
                        color: blue.withValues(alpha: 0.10),
                        shape: BoxShape.circle,
                      ),

                      child: const Icon(
                        Icons.medication_outlined,
                        color: blue,
                        size: 28,
                      ),
                    ),

                    const SizedBox(width: 14),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Today\'s Routine',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            'Stay consistent with your routine',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '$takenCount/${supplements.length}',
                          style: const TextStyle(
                            color: blue,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const Text(
                          'taken',
                          style: TextStyle(color: Colors.white38, fontSize: 9),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ====================================================
              // SUPPLEMENT LIST
              // ====================================================
              const Text(
                'Your Supplements',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              ...List.generate(supplements.length, (index) {
                return _supplementCard(index);
              }),

              const SizedBox(height: 18),

              // ====================================================
              // ADD SUPPLEMENT
              // ====================================================
              GestureDetector(
                onTap: _showAddSupplementSheet,

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
                        'Add Supplement',
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
              // NOTE
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
                        Icons.info_outline_rounded,
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
                            'Important',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            'Supplements should complement a balanced '
                            'diet, not replace it. Follow product '
                            'directions and consult a qualified '
                            'professional when needed.',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 10,
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
  // SUPPLEMENT CARD
  // ==============================================================

  Widget _supplementCard(int index) {
    final supplement = supplements[index];

    final bool taken = supplement['taken'];

    return Container(
      margin: const EdgeInsets.only(bottom: 10),

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: const Color(0xFF08131F),

        borderRadius: BorderRadius.circular(17),

        border: Border.all(
          color: taken ? blue.withValues(alpha: 0.25) : const Color(0xFF142333),
        ),
      ),

      child: Row(
        children: [
          // ICON
          Container(
            height: 50,
            width: 50,

            decoration: BoxDecoration(
              color: taken
                  ? blue.withValues(alpha: 0.10)
                  : Colors.white.withValues(alpha: 0.05),

              borderRadius: BorderRadius.circular(14),
            ),

            child: Icon(
              supplement['icon'],
              color: taken ? blue : Colors.white54,
              size: 25,
            ),
          ),

          const SizedBox(width: 13),

          // CONTENT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  supplement['name'],
                  style: TextStyle(
                    color: taken ? Colors.white : Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  supplement['purpose'],
                  style: const TextStyle(color: Colors.white30, fontSize: 10),
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    const Icon(Icons.schedule_rounded, color: blue, size: 12),

                    const SizedBox(width: 4),

                    Text(
                      supplement['timing'],
                      style: const TextStyle(
                        color: blue,
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // TAKEN BUTTON
          GestureDetector(
            onTap: () {
              setState(() {
                supplement['taken'] = !taken;
              });
            },

            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),

              height: 38,
              width: 38,

              decoration: BoxDecoration(
                color: taken ? blue : const Color(0xFF172331),

                shape: BoxShape.circle,
              ),

              child: Icon(
                taken ? Icons.check_rounded : Icons.add_rounded,
                color: taken ? Colors.white : Colors.white54,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==============================================================
  // ADD SUPPLEMENT SHEET
  // ==============================================================

  void _showAddSupplementSheet() {
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
                  'Add Supplement',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                _supplementOption(
                  icon: Icons.local_drink_rounded,
                  title: 'Protein',
                ),

                const SizedBox(height: 10),

                _supplementOption(icon: Icons.bolt_rounded, title: 'Creatine'),

                const SizedBox(height: 10),

                _supplementOption(
                  icon: Icons.favorite_outline_rounded,
                  title: 'Omega 3',
                ),

                const SizedBox(height: 10),

                _supplementOption(
                  icon: Icons.medication_outlined,
                  title: 'Multivitamin',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ==============================================================
  // SUPPLEMENT OPTION
  // ==============================================================

  Widget _supplementOption({required IconData icon, required String title}) {
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
