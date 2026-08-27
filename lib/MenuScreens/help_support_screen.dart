import 'package:flutter/material.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  static const Color blue = Color(0xFF008CFF);

  final List<Map<String, String>> faqs = [
    {
      'question': 'How do I create a workout plan?',
      'answer':
          'Go to the Workout section and select Create Workout. Follow the setup steps to create your personalized workout plan.',
    },
    {
      'question': 'How can I track my progress?',
      'answer':
          'You can use Progress Photos, Body Stats, and other tracking features available in FitNovaX to monitor your progress.',
    },
    {
      'question': 'Can I change my workout plan?',
      'answer':
          'Yes. You can create or update your workout preferences from the Workout section.',
    },
    {
      'question': 'How do reminders work?',
      'answer':
          'Reminders can help you stay consistent with workouts, water intake, sleep, and other fitness activities.',
    },
    {
      'question': 'Is my health information private?',
      'answer':
          'Your health information should be handled carefully. Use the privacy and security settings to manage your account preferences.',
    },
  ];

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
          'Help & Support',
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
              // ==================================================
              // HEADER
              // ==================================================
              const Text(
                'How Can We Help?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Find answers or get help with FitNovaX.',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),

              const SizedBox(height: 24),

              // ==================================================
              // SUPPORT CARD
              // ==================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      blue.withValues(alpha: 0.18),
                      const Color(0xFF08131F),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),

                  borderRadius: BorderRadius.circular(19),

                  border: Border.all(color: blue.withValues(alpha: 0.25)),
                ),

                child: Row(
                  children: [
                    Container(
                      height: 54,
                      width: 54,

                      decoration: BoxDecoration(
                        color: blue.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),

                      child: const Icon(
                        Icons.support_agent_rounded,
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
                            'Need some help?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 5),

                          Text(
                            'We are here to help you get the most out of FitNovaX.',
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

              const SizedBox(height: 28),

              // ==================================================
              // QUICK HELP
              // ==================================================
              const Text(
                'Quick Help',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              _supportCard(
                icon: Icons.chat_bubble_outline_rounded,
                title: 'Contact Support',
                subtitle: 'Talk to the FitNovaX support team',
                onTap: () {
                  _showContactSupport();
                },
              ),

              const SizedBox(height: 10),

              _supportCard(
                icon: Icons.bug_report_outlined,
                title: 'Report a Problem',
                subtitle: 'Tell us about an issue you found',
                onTap: () {
                  _showReportProblem();
                },
              ),

              const SizedBox(height: 10),

              _supportCard(
                icon: Icons.lightbulb_outline_rounded,
                title: 'Send Feedback',
                subtitle: 'Share your ideas with us',
                onTap: () {
                  _showFeedback();
                },
              ),

              const SizedBox(height: 28),

              // ==================================================
              // FAQ
              // ==================================================
              const Text(
                'Frequently Asked Questions',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              ...List.generate(faqs.length, (index) {
                return _faqCard(faqs[index]);
              }),

              const SizedBox(height: 28),

              // ==================================================
              // STILL NEED HELP
              // ==================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: const Color(0xFF08131F),

                  borderRadius: BorderRadius.circular(18),

                  border: Border.all(color: const Color(0xFF142333)),
                ),

                child: Column(
                  children: [
                    Container(
                      height: 46,
                      width: 46,

                      decoration: BoxDecoration(
                        color: blue.withValues(alpha: 0.10),
                        shape: BoxShape.circle,
                      ),

                      child: const Icon(
                        Icons.help_outline_rounded,
                        color: blue,
                        size: 25,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Still need help?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      'Our support team is here to help you.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white30, fontSize: 10),
                    ),

                    const SizedBox(height: 14),

                    SizedBox(
                      width: double.infinity,
                      height: 45,

                      child: ElevatedButton(
                        onPressed: () {
                          _showContactSupport();
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: blue,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),

                        child: const Text(
                          'Contact Support',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
  // SUPPORT CARD
  // ==============================================================

  Widget _supportCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
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

            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white30,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }

  // ==============================================================
  // FAQ CARD
  // ==============================================================

  Widget _faqCard(Map<String, String> faq) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),

      child: Container(
        margin: const EdgeInsets.only(bottom: 10),

        decoration: BoxDecoration(
          color: const Color(0xFF08131F),

          borderRadius: BorderRadius.circular(15),

          border: Border.all(color: const Color(0xFF142333)),
        ),

        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 15),

          childrenPadding: const EdgeInsets.fromLTRB(15, 0, 15, 15),

          iconColor: blue,
          collapsedIconColor: Colors.white38,

          title: Text(
            faq['question']!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),

          children: [
            Align(
              alignment: Alignment.centerLeft,

              child: Text(
                faq['answer']!,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 10,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==============================================================
  // CONTACT SUPPORT
  // ==============================================================

  void _showContactSupport() {
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
                _sheetHandle(),

                const SizedBox(height: 22),

                const Text(
                  'Contact Support',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                _contactOption(
                  icon: Icons.email_outlined,
                  title: 'Email Support',
                  subtitle: 'support@fitnovax.com',
                ),

                const SizedBox(height: 10),

                _contactOption(
                  icon: Icons.chat_outlined,
                  title: 'Live Chat',
                  subtitle: 'Chat with our support team',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ==============================================================
  // REPORT PROBLEM
  // ==============================================================

  void _showReportProblem() {
    _showInputDialog(
      title: 'Report a Problem',
      hint: 'Describe the problem you are experiencing...',
      buttonText: 'Submit Report',
    );
  }

  // ==============================================================
  // FEEDBACK
  // ==============================================================

  void _showFeedback() {
    _showInputDialog(
      title: 'Send Feedback',
      hint: 'Tell us how we can improve FitNovaX...',
      buttonText: 'Send Feedback',
    );
  }

  // ==============================================================
  // INPUT DIALOG
  // ==============================================================

  void _showInputDialog({
    required String title,
    required String hint,
    required String buttonText,
  }) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF101C29),

          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          content: TextField(
            controller: controller,

            maxLines: 5,

            style: const TextStyle(color: Colors.white, fontSize: 12),

            cursorColor: blue,

            decoration: InputDecoration(
              hintText: hint,

              hintStyle: const TextStyle(color: Colors.white30, fontSize: 11),

              filled: true,

              fillColor: const Color(0xFF08131F),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: blue),
              ),
            ),
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

                ScaffoldMessenger.of(this.context).showSnackBar(
                  SnackBar(content: Text('$buttonText submitted')),
                );
              },

              child: Text(
                buttonText,
                style: const TextStyle(
                  color: blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ==============================================================
  // CONTACT OPTION
  // ==============================================================

  Widget _contactOption({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
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

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
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

  // ==============================================================
  // SHEET HANDLE
  // ==============================================================

  Widget _sheetHandle() {
    return Container(
      height: 4,
      width: 40,

      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
