import 'package:flutter/material.dart';
import 'package:fit_nova_x/Screens/sign_up_screen.dart';
import 'package:fit_nova_x/Screens/forgot_password_screen.dart';
import 'package:fit_nova_x/Screens/personal_details_screen.dart';

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
              _buildLogo(),

              const SizedBox(height: 20),

              _buildHeader(),

              const SizedBox(height: 40),

              _buildEmailField(),

              const SizedBox(height: 20),

              _buildPasswordField(),

              const SizedBox(height: 12),

              _buildForgotPassword(),

              const SizedBox(height: 8),

              _buildSignInButton(),

              const SizedBox(height: 28),

              _buildDivider(),

              const SizedBox(height: 22),

              _buildSocialButtons(),

              const SizedBox(height: 25),

              _buildSignUp(),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // LOGO
  // ------------------------------------------------------------

  Widget _buildLogo() {
    return Image.asset('assets/Images/logoNoBack.png', height: 100, width: 100);
  }

  // ------------------------------------------------------------
  // HEADER
  // ------------------------------------------------------------

  Widget _buildHeader() {
    return const Column(
      children: [
        Text(
          'Welcome Back',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),

        SizedBox(height: 5),

        Text(
          'Continue Your Fitness Journey',
          style: TextStyle(color: subtitleColor, fontSize: 13),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // EMAIL FIELD
  // ------------------------------------------------------------

  Widget _buildEmailField() {
    return TextField(
      cursorColor: primaryColor,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Email',
        hintStyle: TextStyle(color: Colors.grey.shade500),
        prefixIcon: const Icon(Icons.email_outlined),
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: primaryColor),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // PASSWORD FIELD
  // ------------------------------------------------------------

  Widget _buildPasswordField() {
    return TextField(
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
            isPasswordHidden ? Icons.visibility : Icons.visibility_off,
          ),
        ),
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: primaryColor),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // FORGOT PASSWORD
  // ------------------------------------------------------------

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ForgotPasswordScreen(),
            ),
          );
          // TODO: Forgot password
        },
        child: const Text(
          'Forgot Password?',
          style: TextStyle(color: primaryColor, fontSize: 14),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // SIGN IN BUTTON
  // ------------------------------------------------------------

  Widget _buildSignInButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PersonalDetailsScreen(),
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
        child: const Text(
          'Sign In',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // OR DIVIDER
  // ------------------------------------------------------------

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade700)),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('OR', style: TextStyle(color: Colors.grey, fontSize: 12)),
        ),

        Expanded(child: Divider(color: Colors.grey.shade700)),
      ],
    );
  }

  // ------------------------------------------------------------
  // SOCIAL BUTTONS
  // ------------------------------------------------------------

  Widget _buildSocialButtons() {
    return Row(
      children: [
        Expanded(
          child: _socialButton(
            imagePath: 'assets/Images/google.png',
            label: 'Google',
            imageSize: 20,
            onPressed: () {
              // TODO: Google sign-in
            },
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: _socialButton(
            imagePath: 'assets/Images/facebook.png',
            label: 'Facebook',
            imageSize: 35,
            onPressed: () {
              // TODO: Facebook sign-in
            },
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // REUSABLE SOCIAL BUTTON
  // ------------------------------------------------------------

  Widget _socialButton({
    required String imagePath,
    required String label,
    required double imageSize,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 50),
        side: const BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: imageSize, width: imageSize),

          const SizedBox(width: 8),

          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // SIGN UP
  // ------------------------------------------------------------

  Widget _buildSignUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),

        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUpScreen()),
            );
            // TODO: Sign up navigation
          },
          child: const Text(
            'Sign Up',
            style: TextStyle(color: primaryColor, fontSize: 13),
          ),
        ),
      ],
    );
  }
}
