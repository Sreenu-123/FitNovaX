import 'dart:math' as math;
import 'package:flutter/material.dart';

class DietScreen extends StatefulWidget {
  const DietScreen({super.key});

  @override
  State<DietScreen> createState() => _DietScreenState();
}

class _DietScreenState extends State<DietScreen> {
  final Color blue = const Color.fromARGB(255, 0, 100, 255);

  int selectedDiet = 0;
  int selectedDay = 0;

  final List<Map<String, String>> days = [
    {'day': 'Today', 'date': '21'},
    {'day': 'Tue', 'date': '22'},
    {'day': 'Wed', 'date': '23'},
    {'day': 'Thu', 'date': '24'},
    {'day': 'Fri', 'date': '25'},
    {'day': 'Sat', 'date': '26'},
    {'day': 'Sun', 'date': '27'},
  ];

  final List<Map<String, dynamic>> meals = [
    {
      'name': 'Breakfast',
      'time': '8:00 AM',
      'food': 'Oats with Fruits & Nuts',
      'calories': '450 kcal',
      'icon': Icons.free_breakfast_rounded,
    },
    {
      'name': 'Lunch',
      'time': '1:00 PM',
      'food': 'Grilled Chicken, Rice & Salad',
      'calories': '550 kcal',
      'icon': Icons.restaurant_rounded,
    },
    {
      'name': 'Snack',
      'time': '4:30 PM',
      'food': 'Greek Yogurt with Honey',
      'calories': '200 kcal',
      'icon': Icons.icecream_rounded,
    },
    {
      'name': 'Dinner',
      'time': '8:00 PM',
      'food': 'Salmon, Quinoa & Veggies',
      'calories': '250 kcal',
      'icon': Icons.dinner_dining_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 15, 16, 25),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------------- HEADER ----------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Diet',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.white,
                      size: 27,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // ---------------- DIET TOGGLE ----------------
              Container(
                height: 48,
                padding: const EdgeInsets.all(4),

                decoration: BoxDecoration(
                  color: const Color(0xFF101821),
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Row(
                  children: [
                    Expanded(child: _dietTab(title: 'Normal Diet', index: 0)),

                    Expanded(child: _dietTab(title: 'AI Diet', index: 1)),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ---------------- DATE SELECTOR ----------------
              SizedBox(
                height: 68,

                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: days.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 7),

                  itemBuilder: (context, index) {
                    final isSelected = selectedDay == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDay = index;
                        });
                      },

                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),

                        width: 48,

                        decoration: BoxDecoration(
                          color: isSelected ? blue : const Color(0xFF101821),

                          borderRadius: BorderRadius.circular(11),

                          border: Border.all(
                            color: isSelected ? blue : const Color(0xFF18222D),
                          ),
                        ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Text(
                              days[index]['day']!,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.white70,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              days[index]['date']!,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),

              // ---------------- CALORIE SUMMARY ----------------
              const Text(
                'Calorie Summary',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 15),

              Row(
                children: [
                  SizedBox(
                    height: 175,
                    width: 175,

                    child: CustomPaint(
                      painter: _CaloriePainter(),

                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: const [
                            Text(
                              '1450',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Text(
                              '/2100 kcal',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 25),

                  Expanded(
                    child: Column(
                      children: [
                        _macroRow(
                          color: Colors.blue,
                          name: 'Protein',
                          value: '120 / 150g',
                        ),

                        const SizedBox(height: 18),

                        _macroRow(
                          color: Colors.deepPurpleAccent,
                          name: 'Carbs',
                          value: '180 / 250g',
                        ),

                        const SizedBox(height: 18),

                        _macroRow(
                          color: Colors.cyan,
                          name: 'Fats',
                          value: '45 / 70g',
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ---------------- TODAY'S MEALS ----------------
              const Text(
                "Today's Meals",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

              Column(
                children: meals.map((meal) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 9),

                    child: _mealCard(
                      name: meal['name'],
                      time: meal['time'],
                      food: meal['food'],
                      calories: meal['calories'],
                      icon: meal['icon'],
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 12),

              // ---------------- LOG FOOD ----------------
              SizedBox(
                width: double.infinity,
                height: 56,

                child: ElevatedButton(
                  onPressed: () {},

                  style: ElevatedButton.styleFrom(
                    backgroundColor: blue,
                    elevation: 0,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),

                  child: const Text(
                    '+ Log Food',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
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

  // ---------------- DIET TAB ----------------

  Widget _dietTab({required String title, required int index}) {
    final bool isSelected = selectedDiet == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDiet = index;
        });
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),

        decoration: BoxDecoration(
          color: isSelected ? blue : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
        ),

        alignment: Alignment.center,

        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  // ---------------- MACRO ROW ----------------

  Widget _macroRow({
    required Color color,
    required String name,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          height: 14,
          width: 14,

          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),

        const SizedBox(width: 12),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),

            const SizedBox(height: 3),

            Text(
              value,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }

  // ---------------- MEAL CARD ----------------

  Widget _mealCard({
    required String name,
    required String time,
    required String food,
    required String calories,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(9),

      decoration: BoxDecoration(
        color: const Color(0xFF0D151E),
        borderRadius: BorderRadius.circular(13),

        border: Border.all(color: const Color(0xFF17232F)),
      ),

      child: Row(
        children: [
          Container(
            height: 58,
            width: 58,

            decoration: BoxDecoration(
              color: const Color(0xFF17202A),
              borderRadius: BorderRadius.circular(11),
            ),

            child: Icon(icon, color: Colors.orange, size: 30),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  time,
                  style: const TextStyle(color: Colors.white54, fontSize: 11),
                ),

                const SizedBox(height: 3),

                Text(
                  food,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(color: Colors.white70, fontSize: 11),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Text(
            calories,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// CALORIE RING
// ============================================================

class _CaloriePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final radius = size.width / 2 - 15;

    final backgroundPaint = Paint()
      ..color = const Color(0xFF18232E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF008CFF), Color(0xFF0062FF)],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    const double progress = 1450 / 2100;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
