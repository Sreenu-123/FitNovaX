import 'dart:io';

import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import 'package:fit_nova_x/services/profile_persistence_service.dart';

class ProfileScreen extends StatefulWidget {
  final Map<String, dynamic> initialProfile;

  const ProfileScreen({super.key, required this.initialProfile});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const Color blue = Color(0xFF00C8FF);

  late Map<String, dynamic> profile;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    profile = Map<String, dynamic>.from(widget.initialProfile);
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final loaded = await ProfilePersistenceService.loadProfile(
      fallback: profile,
    );

    if (!mounted) return;

    setState(() {
      profile = loaded;
      isLoading = false;
    });
  }

  Future<void> _openEditProfile() async {
    final updatedProfile = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (_) => EditProfileScreen(
          initialProfile: Map<String, dynamic>.from(profile),
        ),
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
    final path = profile['profileImagePath']?.toString();

    if (path == null || path.isEmpty) return null;

    final file = File(path);

    if (!file.existsSync()) return null;

    return FileImage(file);
  }

  Widget _avatar() {
    final image = _profileImage();

    return Container(
      height: 92,
      width: 92,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF08131E),
        border: Border.all(color: blue, width: 2),
        boxShadow: [
          BoxShadow(color: blue.withValues(alpha: 0.15), blurRadius: 18),
        ],
        image: image == null
            ? null
            : DecorationImage(image: image, fit: BoxFit.cover),
      ),
      child: image == null
          ? const Icon(Icons.person_rounded, color: blue, size: 55)
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final name = profile['name']?.toString().trim() ?? '';
    final age = profile['age']?.toString().trim() ?? '';
    final height = profile['height']?.toString().trim() ?? '';
    final weight = profile['weight']?.toString().trim() ?? '';
    final goal = profile['goal']?.toString().trim() ?? '';

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context, profile),
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
        child: isLoading
            ? const Center(child: CircularProgressIndicator(color: blue))
            : RefreshIndicator(
                color: blue,
                backgroundColor: const Color(0xFF08131E),
                onRefresh: _loadProfile,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            _avatar(),
                            const SizedBox(height: 12),
                            Text(
                              name.isEmpty ? 'Your Name' : name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              profile['email']?.toString() ?? '',
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 14),
                            OutlinedButton.icon(
                              onPressed: _openEditProfile,
                              icon: const Icon(
                                Icons.edit_outlined,
                                color: blue,
                                size: 16,
                              ),
                              label: const Text(
                                'Edit Profile',
                                style: TextStyle(
                                  color: blue,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: blue.withValues(alpha: 0.5),
                                ),
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

                      _sectionTitle('Fitness Stats'),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _statCard(
                              Icons.fitness_center_rounded,
                              '24',
                              'Workouts',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _statCard(
                              Icons.local_fire_department_rounded,
                              '12',
                              'Day Streak',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _statCard(
                              Icons.timer_outlined,
                              '18h',
                              'Total Time',
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),
                      _sectionTitle('Body Information'),
                      const SizedBox(height: 12),
                      _sectionContainer(
                        child: Column(
                          children: [
                            _infoRow(
                              Icons.height_rounded,
                              'Height',
                              height.isEmpty ? 'Not set' : '$height cm',
                            ),
                            const Divider(color: Color(0xFF172331), height: 22),
                            _infoRow(
                              Icons.monitor_weight_outlined,
                              'Weight',
                              weight.isEmpty ? 'Not set' : '$weight kg',
                            ),
                            const Divider(color: Color(0xFF172331), height: 22),
                            _infoRow(
                              Icons.cake_outlined,
                              'Age',
                              age.isEmpty ? 'Not set' : '$age years',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),
                      _sectionTitle('Current Goal'),
                      const SizedBox(height: 12),
                      _sectionContainer(
                        child: Row(
                          children: [
                            Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                color: blue.withValues(alpha: 0.10),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.trending_up_rounded,
                                color: blue,
                                size: 26,
                              ),
                            ),
                            const SizedBox(width: 13),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    goal.isEmpty
                                        ? 'Set your fitness goal'
                                        : goal,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'Your current fitness target',
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),
                      _sectionTitle('Achievements'),
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
                      _sectionTitle('Account'),
                      const SizedBox(height: 12),
                      _accountItem(
                        Icons.person_outline_rounded,
                        'Personal Information',
                        _openEditProfile,
                      ),
                      _accountItem(
                        Icons.lock_outline_rounded,
                        'Change Password',
                        () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Change Password will be added later.',
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _sectionContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF08131E),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF172331)),
      ),
      child: child,
    );
  }

  Widget _statCard(IconData icon, String value, String label) {
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
