import 'package:flutter/material.dart';
import 'package:fit_nova_x/MainScreens/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordHidden = true;

  static const Color primaryColor = Color.fromARGB(255, 34, 174, 239);
  static const Color subtitleColor = Color.fromARGB(255, 198, 197, 197);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/Images/logoNoBack.png',
                height: 100,
                width: 100,
              ),

              const SizedBox(height: 20),

              // Welcome text
              const Text(
                'Welcome Back',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Continue Your Fitness Journey',
                style: TextStyle(color: subtitleColor, fontSize: 13),
              ),

              const SizedBox(height: 40),

              // Email
              TextField(
                cursorColor: primaryColor,
                keyboardType: TextInputType.emailAddress,

                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.grey.shade500),

                  prefixIcon: const Icon(Icons.email_outlined),

                  filled: true,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: primaryColor),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Password
              TextField(
                cursorColor: primaryColor,
                obscureText: isPasswordHidden,

                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.grey.shade500),

                  prefixIcon: const Icon(Icons.lock_outline),

                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden;
                      });
                    },

                    icon: Icon(
                      isPasswordHidden
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),

                  filled: true,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: primaryColor),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,

                child: TextButton(
                  onPressed: () {
                    // Forgot password
                  },

                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: primaryColor, fontSize: 14),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Sign In
              SizedBox(
                width: double.infinity,
                height: 50,

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

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),

                    elevation: 0,
                  ),

                  child: const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // OR divider
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade700)),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'OR',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),

                  Expanded(child: Divider(color: Colors.grey.shade700)),
                ],
              ),

              const SizedBox(height: 22),

              // Social Login Buttons
              Row(
                children: [
                  // Google
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Google sign-in
                      },

                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 50),

                        side: const BorderSide(color: Colors.grey),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Image.asset(
                            'assets/Images/google.png',
                            height: 20,
                            width: 20,
                          ),

                          const SizedBox(width: 8),

                          const Text(
                            'Google',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Facebook
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Facebook sign-in
                      },

                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 50),

                        side: const BorderSide(color: Colors.grey),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Image.asset(
                            'assets/Images/facebook.png',
                            height: 35,
                            width: 35,
                          ),

                          const SizedBox(width: 8),

                          const Text(
                            'Facebook',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // Sign Up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),

                  TextButton(
                    onPressed: () {
                      // Sign up navigation
                    },

                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: primaryColor, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
