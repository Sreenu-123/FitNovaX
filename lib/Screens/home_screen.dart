import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fit_nova_x/ProfileScreen/profile_screen.dart';
import 'package:fit_nova_x/services/profile_persistence_service.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onWorkoutTap;

  const HomeScreen({super.key, required this.onWorkoutTap});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color blue = Color.fromARGB(255, 0, 140, 255);

  Map<String, dynamic> profile = <String, dynamic>{
    'name': '',
    'email': '',
    'age': '',
    'height': '',
    'weight': '',
    'goal': 'Build Muscle',
    'profileImagePath': null,
  };

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final loaded = await ProfilePersistenceService.loadProfile(
      fallback: profile,
    );

    if (!mounted) return;

    setState(() {
      profile = loaded;
    });
  }

  Future<void> _openProfile() async {
    final updatedProfile = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            ProfileScreen(initialProfile: Map<String, dynamic>.from(profile)),
      ),
    );

    if (!mounted) return;

    if (updatedProfile != null) {
      setState(() {
        profile = updatedProfile;
      });
    }

    await _loadProfile();
  }

  ImageProvider<Object>? _profileImage() {
    final path = profile['profileImagePath'] as String?;

    if (path == null || path.isEmpty) return null;

    final file = File(path);

    if (!file.existsSync()) return null;

    return FileImage(file);
  }

  String get _displayName {
    final name = (profile['name'] as String?)?.trim() ?? '';

    return name.isEmpty ? 'there' : name;
  }

  @override
  Widget build(BuildContext context) {
    final image = _profileImage();

    return Scaffold(
      backgroundColor: Colors.black,
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
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Notifications will be added later.'),
                ),
              );
            },
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Semantics(
              button: true,
              label: 'Open profile',
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: _openProfile,
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromARGB(255, 25, 35, 45),
                    border: Border.all(color: blue, width: 1.2),
                    image: image == null
                        ? null
                        : DecorationImage(image: image, fit: BoxFit.cover),
                  ),
                  child: image == null
                      ? const Icon(Icons.person, color: blue, size: 21)
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Morning, $_displayName 👋',
                style: const TextStyle(
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

              // START WORKOUT
              GestureDetector(
                onTap: widget.onWorkoutTap,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: const LinearGradient(
                      colors: [blue, Color.fromARGB(255, 10, 55, 130)],
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
              const SizedBox(height: 16),

              // STREAK + ACHIEVEMENT
              Row(
                children: [
                  Expanded(
                    child: _statCard(
                      icon: Icons.local_fire_department_rounded,
                      title: 'Current Streak',
                      value: '7 Days',
                      iconColor: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _statCard(
                      icon: Icons.emoji_events_rounded,
                      title: 'Latest Achievement',
                      value: '7 Day Streak',
                      iconColor: Colors.amber,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // TODAY'S OVERVIEW
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

              // QUICK ACTIONS
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

              // TODAY'S PLAN
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
                      child: const Icon(
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

  Widget _statCard({
    required IconData icon,
    required String title,
    required String value,
    required Color iconColor,
  }) {
    return Container(
      height: 78,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 12, 18, 25),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color.fromARGB(255, 30, 40, 50)),
      ),
      child: Row(
        children: [
          Container(
            height: 38,
            width: 38,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 21),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey, fontSize: 10),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
            style: const TextStyle(
              color: blue,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }

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
                  valueColor: const AlwaysStoppedAnimation<Color>(blue),
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
