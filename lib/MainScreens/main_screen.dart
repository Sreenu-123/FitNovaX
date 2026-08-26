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

      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(20),
        height: 70,

        decoration: BoxDecoration(
          color: const Color(0xFF151515),
          borderRadius: BorderRadius.circular(35),
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // HOME
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: _selectedIndex == 0
                    ? const Color.fromARGB(
                        255,
                        0,
                        200,
                        255,
                      ).withValues(alpha: 0.25)
                    : Colors.transparent,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),

              icon: Icon(
                Icons.home,
                color: _selectedIndex == 0
                    ? const Color.fromARGB(255, 0, 200, 255)
                    : Colors.white,
              ),

              onPressed: () => _onItemTapped(0),
            ),

            // DIET
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: _selectedIndex == 1
                    ? const Color.fromARGB(
                        255,
                        0,
                        200,
                        255,
                      ).withValues(alpha: 0.25)
                    : Colors.transparent,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),

              icon: Icon(
                Icons.restaurant_menu,
                color: _selectedIndex == 1
                    ? const Color.fromARGB(255, 0, 200, 255)
                    : Colors.white,
              ),

              onPressed: () => _onItemTapped(1),
            ),

            // WORKOUT
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: _selectedIndex == 2
                    ? const Color.fromARGB(
                        255,
                        0,
                        200,
                        255,
                      ).withValues(alpha: 0.25)
                    : Colors.transparent,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              ),

              icon: Image.asset(
                'assets/Images/logoNoBack.png',
                width: 44,
                height: 44,
                color: _selectedIndex == 2
                    ? const Color.fromARGB(255, 0, 200, 255)
                    : Colors.white,
              ),

              onPressed: () => _onItemTapped(2),
            ),

            // ROADMAP
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: _selectedIndex == 3
                    ? const Color.fromARGB(
                        255,
                        0,
                        200,
                        255,
                      ).withValues(alpha: 0.25)
                    : Colors.transparent,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),

              icon: Icon(
                Icons.route,
                color: _selectedIndex == 3
                    ? const Color.fromARGB(255, 0, 200, 255)
                    : Colors.white,
              ),

              onPressed: () => _onItemTapped(3),
            ),

            // MENU
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: _selectedIndex == 4
                    ? const Color.fromARGB(
                        255,
                        0,
                        200,
                        255,
                      ).withValues(alpha: 0.25)
                    : Colors.transparent,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),

              icon: Icon(
                Icons.menu,
                color: _selectedIndex == 4
                    ? const Color.fromARGB(255, 0, 200, 255)
                    : Colors.white,
              ),

              onPressed: () => _onItemTapped(4),
            ),
          ],
        ),
      ),
    );
  }
}
