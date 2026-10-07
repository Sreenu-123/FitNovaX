import 'package:flutter/material.dart';

import 'package:fit_nova_x/services/api_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  static const Color primaryColor = Color.fromARGB(255, 34, 174, 239);

  static const Color subtitleColor = Color.fromARGB(255, 198, 197, 197);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  bool isLoading = false;
  bool emailSent = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  // ============================================================
  // SEND RESET LINK
  // ============================================================

  Future<void> _sendResetLink() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final email = emailController.text.trim();

      // ========================================================
      // CALL FASTAPI
      // ========================================================

      final result = await ApiService.forgotPassword(email: email);

      if (!mounted) return;

      // ========================================================
      // SUCCESS
      // ========================================================

      if (result['success'] == true) {
        setState(() {
          isLoading = false;
          emailSent = true;
        });

        return;
      }

      // ========================================================
      // FAILED
      // ========================================================

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? 'Unable to send reset link.'),
        ),
      );
    } catch (error) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong. Please try again.'),
        ),
      );

      print('Forgot password error: $error');
    }
  }

  // ============================================================
  // BACK TO SIGN IN
  // ============================================================

  void _goBackToSignIn() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ==================================================
              // BACK BUTTON
              // ==================================================

              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: isLoading ? null : _goBackToSignIn,
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // ==================================================
              // LOGO
              // ==================================================
              Image.asset(
                'assets/Images/logoNoBack.png',
                height: 90,
                width: 90,
              ),

              const SizedBox(height: 20),

              if (!emailSent)
                _buildForgotPasswordForm()
              else
                _buildSuccessMessage(),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // FORGOT PASSWORD FORM
  // ============================================================

  Widget _buildForgotPasswordForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ======================================================
          // TITLE
          // ======================================================

          const Text(
            'Forgot Password?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 8),

          // ======================================================
          // SUBTITLE
          // ======================================================
          const Text(
            'Enter your email and we’ll send you a link\n'
            'to reset your password.',
            textAlign: TextAlign.center,
            style: TextStyle(color: subtitleColor, fontSize: 13, height: 1.5),
          ),

          const SizedBox(height: 40),

          // ======================================================
          // EMAIL
          // ======================================================
          TextFormField(
            controller: emailController,
            cursorColor: primaryColor,
            style: const TextStyle(color: Colors.white),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            enabled: !isLoading,
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: TextStyle(color: Colors.grey.shade500),
              prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
              filled: true,
              fillColor: const Color(0xFF151515),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: primaryColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.red),
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your email';
              }

              final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

              if (!emailRegex.hasMatch(value.trim())) {
                return 'Please enter a valid email';
              }

              return null;
            },
          ),

          const SizedBox(height: 25),

          // ======================================================
          // SEND RESET LINK
          // ======================================================
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: isLoading ? null : _sendResetLink,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                disabledBackgroundColor: primaryColor.withValues(alpha: 0.5),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      'Send Reset Link',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
          ),

          const SizedBox(height: 25),

          // ======================================================
          // BACK TO LOGIN
          // ======================================================
          TextButton(
            onPressed: isLoading ? null : _goBackToSignIn,
            child: const Text(
              'Back to Sign In',
              style: TextStyle(color: primaryColor, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SUCCESS MESSAGE
  // ============================================================

  Widget _buildSuccessMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 5),

        // ========================================================
        // SUCCESS ICON
        // ========================================================
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: primaryColor.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.mark_email_read_outlined,
            color: primaryColor,
            size: 36,
          ),
        ),

        const SizedBox(height: 25),

        // ========================================================
        // SUCCESS TITLE
        // ========================================================
        const Text(
          'Check Your Email',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 12),

        // ========================================================
        // SUCCESS MESSAGE
        // ========================================================
        Text(
          'We’ve sent a password reset link to\n'
          '${emailController.text.trim()}',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: subtitleColor,
            fontSize: 13,
            height: 1.5,
          ),
        ),

        const SizedBox(height: 35),

        // ========================================================
        // GO BACK TO SIGN IN
        // ========================================================
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _goBackToSignIn,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Go Back to Sign In',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}
