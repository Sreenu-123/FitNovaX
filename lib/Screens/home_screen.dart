import 'package:flutter/material.dart';
import 'package:fit_nova_x/ProfileScreen/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onWorkoutTap;

  const HomeScreen({super.key, required this.onWorkoutTap});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Color blue = const Color.fromARGB(255, 34, 174, 239);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,

        title: const Text(
          'FitNovaX',
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Colors.white,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 17,
              backgroundColor: const Color.fromARGB(255, 25, 35, 45),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 0, 174, 239),
                  size: 20,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),

      // ================= BODY =================
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

          padding: const EdgeInsets.fromLTRB(18, 8, 18, 20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= GREETING =================
              const Text(
                'Good Morning, Sreenu 👋',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                'Ready to crush your goals today?',
                style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
              ),

              const SizedBox(height: 20),

              // ================= START WORKOUT =================
              GestureDetector(
                onTap: widget.onWorkoutTap,

                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),

                    gradient: LinearGradient(
                      colors: [blue, const Color.fromARGB(255, 20, 80, 180)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),

                  child: Row(
                    children: [
                      Container(
                        height: 52,
                        width: 52,

                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(15),
                        ),

                        child: const Icon(
                          Icons.fitness_center_rounded,
                          color: Colors.white,
                          size: 27,
                        ),
                      ),

                      const SizedBox(width: 14),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              'Start Workout',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 4),

                            Text(
                              "Let's begin your workout",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        height: 38,
                        width: 38,

                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          shape: BoxShape.circle,
                        ),

                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // ================= TODAY'S OVERVIEW =================
              _sectionTitle(title: "Today's Overview", action: 'View All'),

              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    child: _progressCard(
                      title: 'Workout',
                      value: '68%',
                      icon: Icons.fitness_center_rounded,
                      progress: 0.68,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _progressCard(
                      title: 'Nutrition',
                      value: '75%',
                      icon: Icons.restaurant_rounded,
                      progress: 0.75,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _progressCard(
                      title: 'Recovery',
                      value: '82%',
                      icon: Icons.bedtime_rounded,
                      progress: 0.82,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // ================= QUICK ACTIONS =================
              _sectionTitle(title: 'Quick Actions'),

              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    child: _quickAction(
                      icon: Icons.restaurant_menu_rounded,
                      title: 'Log Meal',
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _quickAction(
                      icon: Icons.monitor_weight_outlined,
                      title: 'Track Weight',
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _quickAction(
                      icon: Icons.water_drop_outlined,
                      title: 'Water',
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _quickAction(
                      icon: Icons.notifications_none_rounded,
                      title: 'Reminders',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // ================= TODAY'S PLAN =================
              _sectionTitle(title: "Today's Plan", action: 'View All'),

              const SizedBox(height: 14),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(17),

                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 12, 18, 25),
                  borderRadius: BorderRadius.circular(16),

                  border: Border.all(
                    color: const Color.fromARGB(255, 30, 40, 50),
                  ),
                ),

                child: Row(
                  children: [
                    Container(
                      height: 48,
                      width: 48,

                      decoration: BoxDecoration(
                        color: blue.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),

                      child: Icon(
                        Icons.fitness_center_rounded,
                        color: blue,
                        size: 24,
                      ),
                    ),

                    const SizedBox(width: 14),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            'Push Day',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          SizedBox(height: 5),

                          Text(
                            'Chest • Shoulders • Triceps',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),

                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey,
                      size: 16,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION TITLE
  // ============================================================

  Widget _sectionTitle({required String title, String? action}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),

        if (action != null)
          Text(
            action,
            style: TextStyle(
              color: blue,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }

  // ============================================================
  // PROGRESS CARD
  // ============================================================

  Widget _progressCard({
    required String title,
    required String value,
    required IconData icon,
    required double progress,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),

      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 12, 18, 25),

        borderRadius: BorderRadius.circular(16),

        border: Border.all(color: const Color.fromARGB(255, 30, 40, 50)),
      ),

      child: Column(
        children: [
          Icon(icon, color: blue, size: 17),

          const SizedBox(height: 9),

          SizedBox(
            height: 58,
            width: 58,

            child: Stack(
              alignment: Alignment.center,

              children: [
                CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 4,
                  backgroundColor: Colors.grey.shade900,

                  valueColor: AlwaysStoppedAnimation<Color>(blue),
                ),

                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 11)),
        ],
      ),
    );
  }

  // ============================================================
  // QUICK ACTION
  // ============================================================

  Widget _quickAction({required IconData icon, required String title}) {
    return Container(
      height: 82,

      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 12, 18, 25),

        borderRadius: BorderRadius.circular(14),

        border: Border.all(color: const Color.fromARGB(255, 30, 40, 50)),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Icon(icon, color: blue, size: 22),

          const SizedBox(height: 7),

          Text(
            title,
            textAlign: TextAlign.center,

            style: const TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
