import 'package:flutter/material.dart';
import 'package:fit_nova_x/MainScreens/main_screen.dart';

class FounderNoteScreen extends StatelessWidget {
  const FounderNoteScreen({super.key});

  static const Color primaryColor = Color.fromARGB(255, 34, 174, 239);
  static const Color subtitleColor = Color.fromARGB(255, 198, 197, 197);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 25, 25, 25),

          child: Column(
            children: [
              // =====================================================
              // TOP
              // =====================================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 40),

                  const Text(
                    'FitNovaX',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(width: 40),
                ],
              ),

              const SizedBox(height: 35),

              // =====================================================
              // LOGO
              // =====================================================
              Container(
                height: 85,
                width: 85,

                decoration: BoxDecoration(
                  color: const Color(0xFF0D1820),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: primaryColor.withValues(alpha: 0.35),
                    width: 1.5,
                  ),
                ),

                padding: const EdgeInsets.all(17),

                child: Image.asset(
                  'assets/Images/logoNoBack.png',
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 25),

              // =====================================================
              // TITLE
              // =====================================================
              const Text(
                'A Note From',
                textAlign: TextAlign.center,

                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),

              const SizedBox(height: 3),

              const Text(
                'The Founder',
                textAlign: TextAlign.center,

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 25),

              // =====================================================
              // FOUNDER NOTE CARD
              // =====================================================
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,

                    padding: const EdgeInsets.all(22),

                    decoration: BoxDecoration(
                      color: const Color(0xFF0D151C),

                      borderRadius: BorderRadius.circular(20),

                      border: Border.all(color: const Color(0xFF1B2A35)),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        // QUOTE
                        const Text(
                          '“',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 45,
                            height: 0.7,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          'FitNovaX was born from personal experience.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            height: 1.4,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 22),

                        const Text(
                          'I created FitNovaX because fitness is not just something I wanted to build an app around. It is something I have experienced personally.',
                          style: TextStyle(
                            color: subtitleColor,
                            fontSize: 14,
                            height: 1.7,
                          ),
                        ),

                        const SizedBox(height: 16),

                        const Text(
                          'Through my own experience, I understood how difficult it can be to stay consistent, understand what your body needs, keep track of progress, and maintain the motivation to continue.',
                          style: TextStyle(
                            color: subtitleColor,
                            fontSize: 14,
                            height: 1.7,
                          ),
                        ),

                        const SizedBox(height: 16),

                        const Text(
                          'That experience made me think about creating something different — something that could bring workouts, nutrition, progress, and guidance together in one place.',
                          style: TextStyle(
                            color: subtitleColor,
                            fontSize: 14,
                            height: 1.7,
                          ),
                        ),

                        const SizedBox(height: 16),

                        const Text(
                          'FitNovaX is my attempt to turn that experience into something useful for people who are also trying to become a better version of themselves.',
                          style: TextStyle(
                            color: subtitleColor,
                            fontSize: 14,
                            height: 1.7,
                          ),
                        ),

                        const SizedBox(height: 22),

                        Container(
                          height: 1,
                          width: double.infinity,
                          color: const Color(0xFF20303B),
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          'This is more than just a fitness app to me.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            height: 1.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          'It started with my own experience, and I hope it becomes something that can genuinely help you with yours.',
                          style: TextStyle(
                            color: subtitleColor,
                            fontSize: 13,
                            height: 1.7,
                          ),
                        ),

                        const SizedBox(height: 25),

                        const Align(
                          alignment: Alignment.centerRight,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,

                            children: [
                              Text(
                                '— Sreenu',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              SizedBox(height: 3),

                              Text(
                                'Founder, FitNovaX',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // =====================================================
              // CONTINUE BUTTON
              // =====================================================
              SizedBox(
                width: double.infinity,
                height: 54,

                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainScreen(),
                      ),
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),

                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      SizedBox(width: 8),

                      Icon(Icons.arrow_forward_rounded, size: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
