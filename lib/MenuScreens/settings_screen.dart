import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static const Color blue = Color(0xFF008CFF);

  bool notificationsEnabled = true;
  bool workoutReminderEnabled = true;
  bool darkModeEnabled = true;

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
          'Settings',
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
              const Text(
                'App Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Customize your FitNovaX experience.',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),

              const SizedBox(height: 28),

              // ==================================================
              // PREFERENCES
              // ==================================================
              _sectionTitle('Preferences'),

              const SizedBox(height: 10),

              _settingCard(
                icon: Icons.notifications_none_rounded,
                title: 'Notifications',
                subtitle: 'Receive app notifications',
                trailing: Switch(
                  value: notificationsEnabled,
                  activeThumbColor: blue,
                  onChanged: (value) {
                    setState(() {
                      notificationsEnabled = value;
                    });
                  },
                ),
              ),

              const SizedBox(height: 10),

              _settingCard(
                icon: Icons.alarm_rounded,
                title: 'Workout Reminders',
                subtitle: 'Get reminded about your workouts',
                trailing: Switch(
                  value: workoutReminderEnabled,
                  activeThumbColor: blue,
                  onChanged: (value) {
                    setState(() {
                      workoutReminderEnabled = value;
                    });
                  },
                ),
              ),

              const SizedBox(height: 10),

              _settingCard(
                icon: Icons.dark_mode_outlined,
                title: 'Dark Mode',
                subtitle: 'Use dark appearance',
                trailing: Switch(
                  value: darkModeEnabled,
                  activeThumbColor: blue,
                  onChanged: (value) {
                    setState(() {
                      darkModeEnabled = value;
                    });
                  },
                ),
              ),

              const SizedBox(height: 28),

              // ==================================================
              // APP
              // ==================================================
              _sectionTitle('App'),

              const SizedBox(height: 10),

              _navigationCard(
                icon: Icons.language_rounded,
                title: 'Language',
                subtitle: 'English',
                onTap: () {
                  _showLanguageSheet();
                },
              ),

              const SizedBox(height: 10),

              _navigationCard(
                icon: Icons.lock_outline_rounded,
                title: 'Privacy & Security',
                subtitle: 'Manage your privacy',
                onTap: () {},
              ),

              const SizedBox(height: 10),

              _navigationCard(
                icon: Icons.help_outline_rounded,
                title: 'Help & Support',
                subtitle: 'Get help with FitNovaX',
                onTap: () {},
              ),

              const SizedBox(height: 10),

              _navigationCard(
                icon: Icons.info_outline_rounded,
                title: 'About FitNovaX',
                subtitle: 'Version 1.0.0',
                onTap: () {
                  _showAboutDialog();
                },
              ),

              const SizedBox(height: 28),

              // ==================================================
              // ACCOUNT
              // ==================================================
              _sectionTitle('Account'),

              const SizedBox(height: 10),

              _navigationCard(
                icon: Icons.logout_rounded,
                title: 'Log Out',
                subtitle: 'Sign out from your account',
                iconColor: Colors.redAccent,
                onTap: () {
                  _showLogoutDialog();
                },
              ),

              const SizedBox(height: 10),

              _navigationCard(
                icon: Icons.delete_outline_rounded,
                title: 'Delete Account',
                subtitle: 'Permanently delete your account',
                iconColor: Colors.redAccent,
                onTap: () {
                  _showDeleteAccountDialog();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==============================================================
  // SECTION TITLE
  // ==============================================================

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

  // ==============================================================
  // SETTING CARD
  // ==============================================================

  Widget _settingCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
  }) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),

      decoration: BoxDecoration(
        color: const Color(0xFF08131F),
        borderRadius: BorderRadius.circular(17),

        border: Border.all(color: const Color(0xFF142333)),
      ),

      child: Row(
        children: [
          Container(
            height: 45,
            width: 45,

            decoration: BoxDecoration(
              color: blue.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(13),
            ),

            child: Icon(icon, color: blue, size: 23),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white30, fontSize: 10),
                ),
              ],
            ),
          ),

          trailing,
        ],
      ),
    );
  }

  // ==============================================================
  // NAVIGATION CARD
  // ==============================================================

  Widget _navigationCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color iconColor = blue,
  }) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        width: double.infinity,

        padding: const EdgeInsets.all(15),

        decoration: BoxDecoration(
          color: const Color(0xFF08131F),
          borderRadius: BorderRadius.circular(17),

          border: Border.all(color: const Color(0xFF142333)),
        ),

        child: Row(
          children: [
            Container(
              height: 45,
              width: 45,

              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(13),
              ),

              child: Icon(icon, color: iconColor, size: 23),
            ),

            const SizedBox(width: 13),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: iconColor == Colors.redAccent
                          ? Colors.redAccent
                          : Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.white30, fontSize: 10),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.arrow_forward_ios_rounded,
              color: iconColor == Colors.redAccent
                  ? Colors.redAccent.withValues(alpha: 0.5)
                  : Colors.white30,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }

  // ==============================================================
  // LANGUAGE SHEET
  // ==============================================================

  void _showLanguageSheet() {
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
                  'Language',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                _languageOption('English', true),
                const SizedBox(height: 10),
                _languageOption('Malayalam', false),
                const SizedBox(height: 10),
                _languageOption('Hindi', false),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _languageOption(String language, bool selected) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },

      child: Container(
        width: double.infinity,

        padding: const EdgeInsets.all(15),

        decoration: BoxDecoration(
          color: selected
              ? blue.withValues(alpha: 0.10)
              : const Color(0xFF101C29),

          borderRadius: BorderRadius.circular(14),

          border: Border.all(
            color: selected
                ? blue.withValues(alpha: 0.4)
                : const Color(0xFF172A3A),
          ),
        ),

        child: Row(
          children: [
            Text(
              language,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),

            const Spacer(),

            if (selected)
              const Icon(Icons.check_rounded, color: blue, size: 20),
          ],
        ),
      ),
    );
  }

  // ==============================================================
  // ABOUT
  // ==============================================================

  void _showAboutDialog() {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF101C29),

          title: const Text(
            'FitNovaX',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),

          content: const Text(
            'Your personal fitness companion.\n\nVersion 1.0.0',
            style: TextStyle(color: Colors.white60, height: 1.5),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text('Close', style: TextStyle(color: blue)),
            ),
          ],
        );
      },
    );
  }

  // ==============================================================
  // LOGOUT
  // ==============================================================

  void _showLogoutDialog() {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF101C29),

          title: const Text(
            'Log Out?',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),

          content: const Text(
            'Are you sure you want to log out?',
            style: TextStyle(color: Colors.white60),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white54),
              ),
            ),

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text(
                'Log Out',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        );
      },
    );
  }

  // ==============================================================
  // DELETE ACCOUNT
  // ==============================================================

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF101C29),

          title: const Text(
            'Delete Account?',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),

          content: const Text(
            'This action cannot be undone. Your account and '
            'associated data may be permanently removed.',
            style: TextStyle(color: Colors.white60, height: 1.4),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white54),
              ),
            ),

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        );
      },
    );
  }
}
