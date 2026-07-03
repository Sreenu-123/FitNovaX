import 'package:flutter/material.dart';

class HomeScreen
    extends
        StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<
    HomeScreen
  >
  createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends
        State<
          HomeScreen
        > {
  int
  currentIndex =
      0;
  @override
  Widget
  build(
    BuildContext
    context,
  ) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.account_circle_outlined,
            color: Colors.white,
            size: 25,
          ),
          onPressed: () {
            // Handle back button press
          },
        ),
        title: const Text(
          "FX",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: const Center(
        child: Text(
          "Home Screen",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(
          20,
        ),
        height: 70,
        decoration: BoxDecoration(
          color: const Color(
            0xFF151515,
          ),
          borderRadius: BorderRadius.circular(
            35,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 20,
              offset: const Offset(
                0,
                8,
              ),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor:
                    currentIndex ==
                        0
                    ? const Color.fromARGB(
                        255,
                        0,
                        200,
                        255,
                      ).withValues(
                        alpha: 0.25,
                      )
                    : Colors.transparent,
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
              ),
              icon: Icon(
                Icons.home,
                color:
                    currentIndex ==
                        0
                    ? const Color.fromARGB(
                        255,
                        0,
                        200,
                        255,
                      )
                    : Colors.white,
              ),
              onPressed: () {
                // Handle home button press
                setState(
                  () {
                    currentIndex = 0;
                  },
                );
              },
            ),
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor:
                    currentIndex ==
                        1
                    ? const Color.fromARGB(
                        255,
                        0,
                        200,
                        255,
                      ).withValues(
                        alpha: 0.25,
                      )
                    : Colors.transparent,
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
              ),
              icon: Icon(
                Icons.restaurant_menu,
                color:
                    currentIndex ==
                        1
                    ? const Color.fromARGB(
                        255,
                        0,
                        200,
                        255,
                      )
                    : Colors.white,
              ),
              onPressed: () {
                // Handle search button press
                setState(
                  () {
                    currentIndex = 1;
                  },
                );
              },
            ),
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor:
                    currentIndex ==
                        2
                    ? const Color.fromARGB(
                        255,
                        0,
                        200,
                        255,
                      ).withValues(
                        alpha: 0.25,
                      )
                    : Colors.transparent,
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
              ),
              icon: Image.asset(
                'assets/Images/logoNoBack.png',
                width: 44,
                height: 44,
                color:
                    currentIndex ==
                        2
                    ? const Color.fromARGB(
                        255,
                        0,
                        200,
                        255,
                      )
                    : Colors.white,
              ),
              onPressed: () {
                // Handle profile button press
                setState(
                  () {
                    currentIndex = 2;
                  },
                );
              },
            ),
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor:
                    currentIndex ==
                        3
                    ? const Color.fromARGB(
                        255,
                        0,
                        200,
                        255,
                      ).withValues(
                        alpha: 0.25,
                      )
                    : Colors.transparent,
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
              ),
              icon: Icon(
                Icons.route,
                color:
                    currentIndex ==
                        3
                    ? const Color.fromARGB(
                        255,
                        0,
                        200,
                        255,
                      )
                    : Colors.white,
              ),
              onPressed: () {
                // Handle profile button press
                setState(
                  () {
                    currentIndex = 3;
                  },
                );
              },
            ),
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor:
                    currentIndex ==
                        4
                    ? const Color.fromARGB(
                        255,
                        0,
                        200,
                        255,
                      ).withValues(
                        alpha: 0.25,
                      )
                    : Colors.transparent,
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
              ),
              icon: Icon(
                Icons.menu,
                color:
                    currentIndex ==
                        4
                    ? const Color.fromARGB(
                        255,
                        0,
                        200,
                        255,
                      )
                    : Colors.white,
              ),
              onPressed: () {
                // Handle profile button press
                setState(
                  () {
                    currentIndex = 4;
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
