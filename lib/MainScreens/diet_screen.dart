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

  bool isRegenerating = false;

  final TextEditingController foodController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();

  String selectedMealType = 'Breakfast';

  final List<Map<String, String>> days = [
    {'day': 'Mon', 'date': '21'},
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

  final List<Map<String, dynamic>> aiMeals = [
    {
      'name': 'Breakfast',
      'time': '8:00 AM',
      'food': 'Power Energy, Brown Bread, Banana, Almonds',
      'calories': '520 kcal',
      'icon': Icons.free_breakfast_rounded,
    },
    {
      'name': 'Lunch',
      'time': '1:00 PM',
      'food': 'Chicken Breast, Brown Rice, Mixed Veggies, Salad',
      'calories': '650 kcal',
      'icon': Icons.restaurant_rounded,
    },
    {
      'name': 'Snack',
      'time': '4:30 PM',
      'food': 'Whey Protein Shake, Peanut Butter, Apple',
      'calories': '300 kcal',
      'icon': Icons.local_drink_rounded,
    },
    {
      'name': 'Dinner',
      'time': '8:00 PM',
      'food': 'Grilled Fish, Quinoa, Steamed Vegetables',
      'calories': '550 kcal',
      'icon': Icons.dinner_dining_rounded,
    },
  ];

  @override
  void dispose() {
    foodController.dispose();
    caloriesController.dispose();
    super.dispose();
  }

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
              // =====================================================
              // HEADER
              // =====================================================
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

              // =====================================================
              // DIET TOGGLE
              // =====================================================
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

                    Expanded(child: _dietTab(title: 'AI Diet ✨', index: 1)),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // =====================================================
              // NORMAL / AI DIET
              // =====================================================
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),

                child: selectedDiet == 0 ? _buildNormalDiet() : _buildAiDiet(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===============================================================
  // NORMAL DIET
  // ===============================================================

  Widget _buildNormalDiet() {
    return Column(
      key: const ValueKey('normalDiet'),

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        // ---------------- DATE SELECTOR ----------------
        SizedBox(
          height: 68,

          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: days.length,

            separatorBuilder: (_, _) => const SizedBox(width: 7),

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
                          color: isSelected ? Colors.white : Colors.white70,

                          fontSize: 12,

                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        days[index]['date']!,

                        style: const TextStyle(
                          color: Colors.white,

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

                        style: TextStyle(color: Colors.white70, fontSize: 12),
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

        // ===========================================================
        // LOG FOOD BUTTON
        // ===========================================================
        SizedBox(
          width: double.infinity,
          height: 56,

          child: ElevatedButton(
            onPressed: _showLogFoodSheet,

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
    );
  }

  // ===============================================================
  // LOG FOOD BOTTOM SHEET
  // ===============================================================

  void _showLogFoodSheet() {
    foodController.clear();
    caloriesController.clear();

    selectedMealType = 'Breakfast';

    showModalBottomSheet(
      context: context,

      isScrollControlled: true,

      backgroundColor: const Color(0xFF0B1722),

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),

      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 22,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                ),

                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      // HEADER
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          const Text(
                            'Log Food',

                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },

                            icon: const Icon(
                              Icons.close_rounded,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      const Text(
                        'Add the food you have eaten today.',

                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),

                      const SizedBox(height: 22),

                      // FOOD NAME
                      const Text(
                        'Food Name',

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextField(
                        controller: foodController,

                        style: const TextStyle(color: Colors.white),

                        decoration: InputDecoration(
                          hintText: 'e.g. Chicken Sandwich',

                          hintStyle: const TextStyle(color: Colors.white38),

                          prefixIcon: const Icon(
                            Icons.restaurant_rounded,
                            color: Colors.white54,
                          ),

                          filled: true,

                          fillColor: const Color(0xFF101C28),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),

                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // MEAL TYPE
                      const Text(
                        'Meal Type',

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14),

                        decoration: BoxDecoration(
                          color: const Color(0xFF101C28),

                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedMealType,

                            dropdownColor: const Color(0xFF101C28),

                            isExpanded: true,

                            icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.white54,
                            ),

                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),

                            items: const [
                              DropdownMenuItem(
                                value: 'Breakfast',
                                child: Text('Breakfast'),
                              ),
                              DropdownMenuItem(
                                value: 'Lunch',
                                child: Text('Lunch'),
                              ),
                              DropdownMenuItem(
                                value: 'Snack',
                                child: Text('Snack'),
                              ),
                              DropdownMenuItem(
                                value: 'Dinner',
                                child: Text('Dinner'),
                              ),
                            ],

                            onChanged: (value) {
                              if (value == null) return;

                              setSheetState(() {
                                selectedMealType = value;
                              });
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // CALORIES
                      const Text(
                        'Calories',

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextField(
                        controller: caloriesController,

                        keyboardType: TextInputType.number,

                        style: const TextStyle(color: Colors.white),

                        decoration: InputDecoration(
                          hintText: 'e.g. 450',

                          hintStyle: const TextStyle(color: Colors.white38),

                          suffixText: 'kcal',

                          suffixStyle: TextStyle(
                            color: blue,
                            fontWeight: FontWeight.w600,
                          ),

                          prefixIcon: const Icon(
                            Icons.local_fire_department_rounded,
                            color: Colors.orangeAccent,
                          ),

                          filled: true,

                          fillColor: const Color(0xFF101C28),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),

                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      // SAVE BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 54,

                        child: ElevatedButton(
                          onPressed: () {
                            _saveFood(context);
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: blue,

                            elevation: 0,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),

                          child: const Text(
                            'Save Food',

                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ===============================================================
  // SAVE FOOD
  // ===============================================================

  void _saveFood(BuildContext sheetContext) {
    final String foodName = foodController.text.trim();

    final String calories = caloriesController.text.trim();

    if (foodName.isEmpty || calories.isEmpty) {
      ScaffoldMessenger.of(sheetContext).showSnackBar(
        const SnackBar(content: Text('Please enter food name and calories.')),
      );

      return;
    }

    setState(() {
      meals.add({
        'name': selectedMealType,
        'time': 'Just now',
        'food': foodName,
        'calories': '$calories kcal',
        'icon': selectedMealType == 'Breakfast'
            ? Icons.free_breakfast_rounded
            : selectedMealType == 'Lunch'
            ? Icons.restaurant_rounded
            : selectedMealType == 'Snack'
            ? Icons.local_drink_rounded
            : Icons.dinner_dining_rounded,
      });
    });

    Navigator.pop(sheetContext);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$foodName added to your meals!')));
  }

  // ===============================================================
  // AI DIET
  // ===============================================================

  Widget _buildAiDiet() {
    return Column(
      key: const ValueKey('aiDiet'),

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          crossAxisAlignment: CrossAxisAlignment.end,

          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const Text(
                  'Your AI Diet Plan',

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  '2,200 kcal / day',

                  style: TextStyle(
                    color: blue,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            OutlinedButton(
              onPressed: _editPreferences,

              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFF101821),

                side: const BorderSide(color: Color(0xFF182633)),

                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 8,
                ),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),

              child: const Text(
                'Edit Preferences',

                style: TextStyle(color: Colors.white70, fontSize: 10),
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        Row(
          children: [
            Expanded(
              child: _aiMacroCard(
                icon: Icons.fitness_center_rounded,
                title: 'Protein',
                value: '150g',
                color: Colors.blue,
              ),
            ),

            const SizedBox(width: 8),

            Expanded(
              child: _aiMacroCard(
                icon: Icons.grain_rounded,
                title: 'Carbs',
                value: '250g',
                color: Colors.deepPurpleAccent,
              ),
            ),

            const SizedBox(width: 8),

            Expanded(
              child: _aiMacroCard(
                icon: Icons.water_drop_outlined,
                title: 'Fats',
                value: '70g',
                color: Colors.greenAccent,
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        const Text(
          'AI Generated Plan',

          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          'Based on your goal: Muscle Gain',

          style: TextStyle(
            color: blue,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 12),

        Column(
          children: aiMeals.map((meal) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 9),

              child: _aiMealCard(
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

        SizedBox(
          width: double.infinity,
          height: 69,

          child: ElevatedButton(
            onPressed: isRegenerating ? null : _regeneratePlan,

            style: ElevatedButton.styleFrom(
              backgroundColor: blue,

              disabledBackgroundColor: blue.withValues(alpha: 0.6),

              elevation: 0,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
            ),

            child: isRegenerating
                ? const SizedBox(
                    height: 23,
                    width: 23,

                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text(
                        '⟳  Regenerate Plan',

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      SizedBox(height: 4),

                      Text(
                        'AI will update your plan',

                        style: TextStyle(color: Colors.white70, fontSize: 10),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  // ===============================================================
  // DIET TAB
  // ===============================================================

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

  // ===============================================================
  // AI MACRO CARD
  // ===============================================================

  Widget _aiMacroCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      height: 96,

      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),

      decoration: BoxDecoration(
        color: const Color(0xFF0A1622),

        borderRadius: BorderRadius.circular(12),

        border: Border.all(color: const Color(0xFF172534)),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Container(
            height: 25,
            width: 25,

            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),

              shape: BoxShape.circle,
            ),

            child: Icon(icon, color: color, size: 15),
          ),

          const SizedBox(height: 7),

          Text(
            title,

            style: const TextStyle(color: Colors.white70, fontSize: 10),
          ),

          const SizedBox(height: 2),

          Text(
            value,

            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // AI MEAL CARD
  // ===============================================================

  Widget _aiMealCard({
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
        color: const Color(0xFF0B1722),

        borderRadius: BorderRadius.circular(13),

        border: Border.all(color: const Color(0xFF172634)),
      ),

      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,

            decoration: BoxDecoration(
              color: const Color(0xFF17232D),

              borderRadius: BorderRadius.circular(11),
            ),

            child: Icon(icon, color: Colors.orangeAccent, size: 30),
          ),

          const SizedBox(width: 11),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  name,

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  time,

                  style: const TextStyle(color: Colors.white54, fontSize: 10),
                ),

                const SizedBox(height: 3),

                Text(
                  food,

                  maxLines: 2,

                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 10,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 7),

          Text(
            calories,

            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // NORMAL MACRO ROW
  // ===============================================================

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

  // ===============================================================
  // NORMAL MEAL CARD
  // ===============================================================

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

  // ===============================================================
  // EDIT PREFERENCES
  // ===============================================================

  void _editPreferences() {
    showModalBottomSheet(
      context: context,

      backgroundColor: const Color(0xFF0B1722),

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),

      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(22),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const Text(
                  'AI Diet Preferences',

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Update your preferences to personalize your AI generated diet plan.',

                  style: TextStyle(color: Colors.white60, fontSize: 12),
                ),

                const SizedBox(height: 20),

                _preferenceItem(Icons.flag_outlined, 'Goal', 'Build Muscle'),

                _preferenceItem(
                  Icons.local_fire_department_outlined,
                  'Daily Calories',
                  '2,200 kcal',
                ),

                _preferenceItem(
                  Icons.restaurant_outlined,
                  'Diet Type',
                  'Balanced',
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  height: 50,

                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    child: const Text(
                      'Save Preferences',

                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ===============================================================
  // PREFERENCE ITEM
  // ===============================================================

  Widget _preferenceItem(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),

      padding: const EdgeInsets.all(13),

      decoration: BoxDecoration(
        color: const Color(0xFF101C28),

        borderRadius: BorderRadius.circular(12),
      ),

      child: Row(
        children: [
          Icon(icon, color: blue, size: 21),

          const SizedBox(width: 12),

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
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // REGENERATE AI PLAN
  // ===============================================================

  Future<void> _regeneratePlan() async {
    setState(() {
      isRegenerating = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      isRegenerating = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Your AI diet plan has been regenerated!')),
    );
  }
}

// ===============================================================
// CALORIE RING
// ===============================================================

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
