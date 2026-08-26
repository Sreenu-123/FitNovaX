import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final Color blue = const Color(0xFF008CFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(14, 20, 14, 20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // -------------------------
              // HEADER
              // -------------------------
              const Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Explore More Features',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),

              const SizedBox(height: 28),

              // -------------------------
              // MENU ITEMS
              // -------------------------
              _menuCard(
                icon: Icons.grid_view_rounded,
                title: 'Body Stats',
                subtitle: 'Track your body measurements',
                onTap: () {},
              ),

              _menuCard(
                icon: Icons.photo_library_outlined,
                title: 'Progress Photos',
                subtitle: 'Visualize your transformation',
                onTap: () {},
              ),

              _menuCard(
                icon: Icons.bedtime_outlined,
                title: 'Sleep Tracker',
                subtitle: 'Track your sleep and recovery',
                onTap: () {},
              ),

              _menuCard(
                icon: Icons.water_drop_outlined,
                title: 'Water Tracker',
                subtitle: 'Stay hydrated, stay healthy',
                onTap: () {},
              ),

              _menuCard(
                icon: Icons.notifications_none_rounded,
                title: 'Reminders',
                subtitle: 'Never miss your workouts',
                onTap: () {},
              ),

              _menuCard(
                icon: Icons.workspace_premium_outlined,
                title: 'Achievements',
                subtitle: 'Your badges and milestones',
                onTap: () {},
              ),

              _menuCard(
                icon: Icons.medication_outlined,
                title: 'Supplements',
                subtitle: 'Manage your supplements',
                onTap: () {},
              ),

              _menuCard(
                icon: Icons.health_and_safety_outlined,
                title: 'Health Records',
                subtitle: 'Store your health data',
                onTap: () {},
              ),

              _menuCard(
                icon: Icons.settings_outlined,
                title: 'Settings',
                subtitle: 'App preferences and settings',
                onTap: () {},
              ),

              _menuCard(
                icon: Icons.help_outline_rounded,
                title: 'Help & Support',
                subtitle: 'Get help and contact us',
                onTap: () {},
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // MENU CARD
  // ============================================================

  Widget _menuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),

      decoration: BoxDecoration(
        color: const Color(0xFF08131E),

        borderRadius: BorderRadius.circular(14),

        border: Border.all(color: const Color(0xFF132333), width: 1),
      ),

      child: Material(
        color: Colors.transparent,

        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),

            child: Row(
              children: [
                // -------------------------
                // ICON
                // -------------------------
                Container(
                  height: 40,
                  width: 40,

                  decoration: BoxDecoration(
                    color: blue.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Icon(icon, color: blue, size: 24),
                ),

                const SizedBox(width: 12),

                // -------------------------
                // TEXT
                // -------------------------
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 3),

                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),

                // -------------------------
                // ARROW
                // -------------------------
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white70,
                  size: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
