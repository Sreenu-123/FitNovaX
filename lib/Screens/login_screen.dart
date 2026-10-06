import 'package:flutter/material.dart';

import 'package:fit_nova_x/Screens/sign_up_screen.dart';
import 'package:fit_nova_x/Screens/forgot_password_screen.dart';
import 'package:fit_nova_x/Screens/personal_details_screen.dart';
import 'package:fit_nova_x/services/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const Color primaryColor = Color.fromARGB(255, 34, 174, 239);

  static const Color subtitleColor = Color.fromARGB(255, 198, 197, 197);

  bool isPasswordHidden = true;
  bool isSigningIn = false;
  bool isGoogleSigningIn = false;

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

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

  // ============================================================
  // LOGO
  // ============================================================

  Widget _buildLogo() {
    return Image.asset('assets/Images/logoNoBack.png', height: 100, width: 100);
  }

  // ============================================================
  // HEADER
  // ============================================================

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

  // ============================================================
  // EMAIL FIELD
  // ============================================================

  Widget _buildEmailField() {
    return TextField(
      controller: emailController,

      cursorColor: primaryColor,

      keyboardType: TextInputType.emailAddress,

      enabled: !isSigningIn && !isGoogleSigningIn,

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

  // ============================================================
  // PASSWORD FIELD
  // ============================================================

  Widget _buildPasswordField() {
    return TextField(
      controller: passwordController,

      cursorColor: primaryColor,

      obscureText: isPasswordHidden,

      enabled: !isSigningIn && !isGoogleSigningIn,

      decoration: InputDecoration(
        hintText: 'Password',

        hintStyle: TextStyle(color: Colors.grey.shade500),

        prefixIcon: const Icon(Icons.lock_outline),

        suffixIcon: IconButton(
          onPressed: isSigningIn || isGoogleSigningIn
              ? null
              : () {
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

  // ============================================================
  // FORGOT PASSWORD
  // ============================================================

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,

      child: TextButton(
        onPressed: isSigningIn || isGoogleSigningIn
            ? null
            : () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ForgotPasswordScreen(),
                  ),
                );
              },

        child: const Text(
          'Forgot Password?',

          style: TextStyle(color: primaryColor, fontSize: 14),
        ),
      ),
    );
  }

  // ============================================================
  // SIGN IN BUTTON
  // ============================================================

  Widget _buildSignInButton() {
    return SizedBox(
      width: double.infinity,

      height: 50,

      child: ElevatedButton(
        onPressed: isSigningIn || isGoogleSigningIn ? null : _signIn,

        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,

          foregroundColor: Colors.white,

          disabledBackgroundColor: primaryColor.withValues(alpha: 0.5),

          elevation: 0,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),

        child: isSigningIn
            ? const SizedBox(
                height: 22,

                width: 22,

                child: CircularProgressIndicator(
                  strokeWidth: 2,

                  color: Colors.white,
                ),
              )
            : const Text(
                'Sign In',

                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
      ),
    );
  }

  // ============================================================
  // EMAIL / PASSWORD LOGIN
  // ============================================================

  Future<void> _signIn() async {
    final email = emailController.text.trim();

    final password = passwordController.text;

    // ----------------------------------------------------------
    // VALIDATION
    // ----------------------------------------------------------

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email and password')),
      );

      return;
    }

    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

    if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address')),
      );

      return;
    }

    setState(() {
      isSigningIn = true;
    });

    try {
      // --------------------------------------------------------
      // FASTAPI LOGIN
      // --------------------------------------------------------

      final result = await ApiService.login(email: email, password: password);

      if (!mounted) return;

      // --------------------------------------------------------
      // LOGIN SUCCESS
      // --------------------------------------------------------

      if (result['success'] == true) {
        final String? userId = result['user_id'] as String?;

        final String? name = result['name'] as String?;

        if (userId == null || userId.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login failed. User ID not found.')),
          );

          return;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'] ?? 'Login successful.')),
        );

        // ------------------------------------------------------
        // TEMPORARY FLOW
        //
        // Every successful login currently goes to
        // Personal Details.
        //
        // Later:
        // Check whether UserProfile exists.
        // If profile exists -> MainScreen
        // If profile doesn't exist -> PersonalDetailsScreen
        // ------------------------------------------------------

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) =>
                PersonalDetailsScreen(userId: userId, name: name),
          ),
          (route) => false,
        );

        return;
      }

      // --------------------------------------------------------
      // LOGIN FAILED
      // --------------------------------------------------------

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? 'Invalid email or password.'),
        ),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not connect to server. Please try again.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isSigningIn = false;
        });
      }
    }
  }

  // ============================================================
  // GOOGLE LOGIN
  // ============================================================

  Future<void> _signInWithGoogle() async {
    if (isSigningIn || isGoogleSigningIn) {
      return;
    }

    setState(() {
      isGoogleSigningIn = true;
    });

    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    setState(() {
      isGoogleSigningIn = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Google login will be added later.')),
    );
  }

  // ============================================================
  // DIVIDER
  // ============================================================

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

  // ============================================================
  // SOCIAL BUTTONS
  // ============================================================

  Widget _buildSocialButtons() {
    return Row(
      children: [
        Expanded(
          child: _socialButton(
            imagePath: 'assets/Images/google.png',

            label: 'Google',

            imageSize: 20,

            onPressed: _signInWithGoogle,

            isLoading: isGoogleSigningIn,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: _socialButton(
            imagePath: 'assets/Images/facebook.png',

            label: 'Facebook',

            imageSize: 35,

            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Facebook login will be added next.'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SOCIAL BUTTON
  // ============================================================

  Widget _socialButton({
    required String imagePath,
    required String label,
    required double imageSize,
    required VoidCallback onPressed,
    bool isLoading = false,
  }) {
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,

      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 50),

        side: const BorderSide(color: Colors.grey),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),

      child: isLoading
          ? const SizedBox(
              height: 20,

              width: 20,

              child: CircularProgressIndicator(
                strokeWidth: 2,

                color: primaryColor,
              ),
            )
          : Row(
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

  // ============================================================
  // SIGN UP
  // ============================================================

  Widget _buildSignUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        const Text(
          "Don't have an account?",

          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),

        TextButton(
          onPressed: isSigningIn || isGoogleSigningIn
              ? null
              : () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  );
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
