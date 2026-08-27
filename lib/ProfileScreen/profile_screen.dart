import 'package:flutter/material.dart';
import 'package:fit_nova_x/ProfileScreen/edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Color blue = const Color(0xFF00C8FF);

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
          'Profile',
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
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 30),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ====================================================
              // PROFILE HEADER
              // ====================================================
              Center(
                child: Column(
                  children: [
                    Container(
                      height: 92,
                      width: 92,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,

                        color: const Color(0xFF08131E),

                        border: Border.all(color: blue, width: 2),

                        boxShadow: [
                          BoxShadow(
                            color: blue.withValues(alpha: 0.15),
                            blurRadius: 18,
                          ),
                        ],
                      ),

                      child: Icon(Icons.person_rounded, color: blue, size: 55),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Sreenu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      'Fitness Enthusiast',
                      style: TextStyle(color: Colors.white60, fontSize: 12),
                    ),

                    const SizedBox(height: 14),

                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfileScreen(),
                          ),
                        );
                      },

                      icon: Icon(Icons.edit_outlined, color: blue, size: 16),

                      label: Text(
                        'Edit Profile',
                        style: TextStyle(
                          color: blue,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: blue.withValues(alpha: 0.5)),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),

                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 9,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ====================================================
              // FITNESS STATS
              // ====================================================
              const Text(
                'Fitness Stats',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _statCard(
                      icon: Icons.fitness_center_rounded,
                      value: '24',
                      label: 'Workouts',
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _statCard(
                      icon: Icons.local_fire_department_rounded,
                      value: '12',
                      label: 'Day Streak',
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _statCard(
                      icon: Icons.timer_outlined,
                      value: '18h',
                      label: 'Total Time',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ====================================================
              // BODY INFORMATION
              // ====================================================
              const Text(
                'Body Information',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),

                decoration: BoxDecoration(
                  color: const Color(0xFF08131E),

                  borderRadius: BorderRadius.circular(14),

                  border: Border.all(color: const Color(0xFF172331)),
                ),

                child: Column(
                  children: [
                    _infoRow(Icons.height_rounded, 'Height', '175 cm'),

                    const Divider(color: Color(0xFF172331), height: 22),

                    _infoRow(Icons.monitor_weight_outlined, 'Weight', '72 kg'),

                    const Divider(color: Color(0xFF172331), height: 22),

                    _infoRow(Icons.cake_outlined, 'Age', '21 years'),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ====================================================
              // CURRENT GOAL
              // ====================================================
              const Text(
                'Current Goal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: const Color(0xFF08131E),

                  borderRadius: BorderRadius.circular(14),

                  border: Border.all(color: const Color(0xFF172331)),
                ),

                child: Row(
                  children: [
                    Container(
                      height: 48,
                      width: 48,

                      decoration: BoxDecoration(
                        color: blue.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: Icon(
                        Icons.trending_up_rounded,
                        color: blue,
                        size: 26,
                      ),
                    ),

                    const SizedBox(width: 13),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Build Muscle',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            'Increase strength and muscle mass',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white38,
                      size: 14,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ====================================================
              // ACHIEVEMENTS
              // ====================================================
              const Text(
                'Achievements',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _achievementCard(
                      Icons.local_fire_department_rounded,
                      '7 Day\nStreak',
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _achievementCard(
                      Icons.fitness_center_rounded,
                      'First 10\nWorkouts',
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _achievementCard(
                      Icons.emoji_events_outlined,
                      'Consistency\nKing',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ====================================================
              // ACCOUNT
              // ====================================================
              const Text(
                'Account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              _accountItem(
                Icons.person_outline_rounded,
                'Personal Information',
                () {},
              ),

              _accountItem(
                Icons.lock_outline_rounded,
                'Change Password',
                () {},
              ),

              _accountItem(Icons.logout_rounded, 'Log Out', () {}),
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
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),

      decoration: BoxDecoration(
        color: const Color(0xFF08131E),

        borderRadius: BorderRadius.circular(14),

        border: Border.all(color: const Color(0xFF172331)),
      ),

      child: Column(
        children: [
          Icon(icon, color: blue, size: 22),

          const SizedBox(height: 8),

          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white54, fontSize: 9),
          ),
        ],
      ),
    );
  }

  // ==============================================================
  // INFO ROW
  // ==============================================================

  Widget _infoRow(IconData icon, String title, String value) {
    return Row(
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
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ==============================================================
  // ACHIEVEMENT CARD
  // ==============================================================

  Widget _achievementCard(IconData icon, String title) {
    return Container(
      height: 105,

      padding: const EdgeInsets.all(10),

      decoration: BoxDecoration(
        color: const Color(0xFF08131E),

        borderRadius: BorderRadius.circular(14),

        border: Border.all(color: const Color(0xFF172331)),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: blue, size: 25),

          const SizedBox(height: 9),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 10,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  // ==============================================================
  // ACCOUNT ITEM
  // ==============================================================

  Widget _accountItem(IconData icon, String title, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),

      decoration: BoxDecoration(
        color: const Color(0xFF08131E),

        borderRadius: BorderRadius.circular(14),

        border: Border.all(color: const Color(0xFF172331)),
      ),

      child: ListTile(
        onTap: onTap,

        leading: Icon(icon, color: blue, size: 22),

        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 13),
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white38,
          size: 14,
        ),
      ),
    );
  }
}
