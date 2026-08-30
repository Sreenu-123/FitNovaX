import 'package:flutter/material.dart';
import 'package:fit_nova_x/Screens/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  static const Color primaryColor = Color.fromARGB(255, 34, 174, 239);
  static const Color subtitleColor = Color.fromARGB(255, 198, 197, 197);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;
  bool termsAccepted = false;
  bool isCreatingAccount = false;

  String selectedCountryCode = '+91';

  final List<String> countryCodes = [
    '+91',
    '+1',
    '+44',
    '+61',
    '+971',
    '+65',
    '+81',
    '+82',
    '+49',
    '+33',
  ];

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // ===============================================================
  // CREATE ACCOUNT
  // ===============================================================

  Future<void> _createAccount() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!termsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to the Terms & Conditions.'),
        ),
      );
      return;
    }

    setState(() {
      isCreatingAccount = true;
    });

    try {
      final supabase = Supabase.instance.client;

      final response = await supabase.auth.signUp(
        email: emailController.text.trim(),
        password: passwordController.text,
        emailRedirectTo: 'fitnovax://login-callback',
        data: {
          'full_name': nameController.text.trim(),
          'country_code': selectedCountryCode,
          'phone_number': phoneController.text.trim(),
        },
      );

      if (!mounted) return;

      setState(() {
        isCreatingAccount = false;
      });

      if (response.user != null) {
        // Wait for the email confirmation callback.
        isWaitingForAccountConfirmation = true;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Account created! Please check your email and verify your account.',
            ),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    } on AuthException catch (error) {
      if (!mounted) return;

      setState(() {
        isCreatingAccount = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.message)));
    } catch (error) {
      if (!mounted) return;

      setState(() {
        isCreatingAccount = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // =====================================================
                // LOGO
                // =====================================================

                Image.asset(
                  'assets/Images/logoNoBack.png',
                  height: 90,
                  width: 90,
                ),

                const SizedBox(height: 20),

                // =====================================================
                // TITLE
                // =====================================================
                const Text(
                  'Create Account',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  'Start your fitness journey',
                  style: TextStyle(color: subtitleColor, fontSize: 13),
                ),

                const SizedBox(height: 35),

                // =====================================================
                // NAME
                // =====================================================
                TextFormField(
                  controller: nameController,
                  cursorColor: primaryColor,
                  style: const TextStyle(color: Colors.white),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Full Name',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    prefixIcon: const Icon(
                      Icons.person_outline,
                      color: Colors.grey,
                    ),
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
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 18),

                // =====================================================
                // EMAIL
                // =====================================================
                TextFormField(
                  controller: emailController,
                  cursorColor: primaryColor,
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Colors.grey,
                    ),
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

                const SizedBox(height: 18),

                // =====================================================
                // PHONE NUMBER
                // =====================================================
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 56,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF151515),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedCountryCode,
                          dropdownColor: const Color(0xFF151515),
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          items: countryCodes.map((code) {
                            return DropdownMenuItem<String>(
                              value: code,
                              child: Text(
                                code,
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value == null) return;

                            setState(() {
                              selectedCountryCode = value;
                            });
                          },
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: TextFormField(
                        controller: phoneController,
                        cursorColor: primaryColor,
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          prefixIcon: const Icon(
                            Icons.phone_outlined,
                            color: Colors.grey,
                          ),
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
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Enter phone number';
                          }

                          if (value.trim().length < 7) {
                            return 'Invalid phone number';
                          }

                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // =====================================================
                // PASSWORD
                // =====================================================
                TextFormField(
                  controller: passwordController,
                  cursorColor: primaryColor,
                  style: const TextStyle(color: Colors.white),
                  obscureText: isPasswordHidden,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: Colors.grey,
                    ),
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
                        color: Colors.grey,
                      ),
                    ),
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
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }

                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 18),

                // =====================================================
                // CONFIRM PASSWORD
                // =====================================================
                TextFormField(
                  controller: confirmPasswordController,
                  cursorColor: primaryColor,
                  style: const TextStyle(color: Colors.white),
                  obscureText: isConfirmPasswordHidden,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: Colors.grey,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isConfirmPasswordHidden = !isConfirmPasswordHidden;
                        });
                      },
                      icon: Icon(
                        isConfirmPasswordHidden
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    ),
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
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }

                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 15),

                // =====================================================
                // TERMS
                // =====================================================
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: termsAccepted,
                      activeColor: primaryColor,
                      checkColor: Colors.white,
                      side: const BorderSide(color: Colors.grey),
                      onChanged: (value) {
                        setState(() {
                          termsAccepted = value ?? false;
                        });
                      },
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            termsAccepted = !termsAccepted;
                          });
                        },
                        child: const Text.rich(
                          TextSpan(
                            text: 'I agree to the ',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                            children: [
                              TextSpan(
                                text: 'Terms & Conditions',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // =====================================================
                // CREATE ACCOUNT
                // =====================================================
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isCreatingAccount ? null : _createAccount,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      disabledBackgroundColor: primaryColor.withValues(
                        alpha: 0.5,
                      ),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    child: isCreatingAccount
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : const Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 25),

                // =====================================================
                // LOGIN
                // =====================================================
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(color: primaryColor, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
