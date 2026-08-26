import 'package:flutter/material.dart';
import 'package:fit_nova_x/Screens/home_screen.dart';
import 'package:fit_nova_x/MainScreens/workout_screen.dart';
import 'package:fit_nova_x/MainScreens/diet_screen.dart';
import 'package:fit_nova_x/MainScreens/roadmap_screen.dart';
import 'package:fit_nova_x/MainScreens/menu_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const Color blue = Color(0xFF00C8FF);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(
        onWorkoutTap: () {
          _onItemTapped(2);
        },
      ),
      const DietScreen(),
      const WorkoutScreen(),
      const RoadmapScreen(),
      const MenuScreen(),
    ];

    return Scaffold(
      backgroundColor: Colors.black,

      body: screens[_selectedIndex],

      // ============================================================
      // FLOATING GLASS BOTTOM NAVIGATION
      // ============================================================
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 0, 14, 8),

          child: Container(
            height: 72,

            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.92),

              borderRadius: BorderRadius.circular(36),

              border: Border.all(
                color: Colors.white.withValues(alpha: 0.08),
                width: 1,
              ),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.8),
                  blurRadius: 25,
                  offset: const Offset(0, 8),
                ),
              ],
            ),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(36),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  // HOME
                  _navItem(index: 0, icon: Icons.home_rounded),

                  // DIET
                  _navItem(index: 1, icon: Icons.restaurant_menu_rounded),

                  // WORKOUT
                  _navItem(
                    index: 2,
                    customIcon: Image.asset(
                      'assets/Images/logoNoBack.png',
                      width: 42,
                      height: 42,
                    ),
                  ),

                  // ROADMAP
                  _navItem(index: 3, icon: Icons.route_rounded),

                  // MENU
                  _navItem(index: 4, icon: Icons.menu_rounded),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // NAVIGATION ITEM
  // ============================================================

  Widget _navItem({required int index, IconData? icon, Widget? customIcon}) {
    final bool selected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        _onItemTapped(index);
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),

        curve: Curves.easeOut,

        height: 52,
        width: 60,

        decoration: BoxDecoration(
          color: selected ? blue.withValues(alpha: 0.16) : Colors.transparent,

          borderRadius: BorderRadius.circular(26),

          boxShadow: selected
              ? [
                  BoxShadow(
                    color: blue.withValues(alpha: 0.12),
                    blurRadius: 14,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),

        child: Center(
          child: customIcon != null
              ? ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    selected ? blue : Colors.white,
                    BlendMode.srcIn,
                  ),

                  child: customIcon,
                )
              : Icon(icon, size: 24, color: selected ? blue : Colors.white70),
        ),
      ),
    );
  }
}
