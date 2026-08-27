import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  static const Color blue = Color(0xFF00C8FF);

  final TextEditingController nameController = TextEditingController(
    text: 'Sreenu',
  );

  final TextEditingController emailController = TextEditingController(
    text: 'sreenu@gmail.com',
  );

  final TextEditingController ageController = TextEditingController(text: '21');

  final TextEditingController heightController = TextEditingController(
    text: '175',
  );

  final TextEditingController weightController = TextEditingController(
    text: '72',
  );

  String selectedGoal = 'Build Muscle';

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();

    super.dispose();
  }

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
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // PROFILE IMAGE
              Center(
                child: Stack(
                  children: [
                    Container(
                      height: 100,
                      width: 100,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,

                        color: const Color(0xFF0A141F),

                        border: Border.all(color: blue, width: 2),
                      ),

                      child: const Icon(Icons.person, color: blue, size: 55),
                    ),

                    Positioned(
                      right: 0,
                      bottom: 0,

                      child: Container(
                        height: 32,
                        width: 32,

                        decoration: const BoxDecoration(
                          color: blue,
                          shape: BoxShape.circle,
                        ),

                        child: const Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // PERSONAL INFORMATION
              const Text(
                'Personal Information',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              _buildTextField(
                controller: nameController,
                label: 'Name',
                icon: Icons.person_outline_rounded,
              ),

              const SizedBox(height: 14),

              _buildTextField(
                controller: emailController,
                label: 'Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 14),

              _buildTextField(
                controller: ageController,
                label: 'Age',
                icon: Icons.cake_outlined,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 28),

              // BODY INFORMATION
              const Text(
                'Body Information',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              _buildTextField(
                controller: heightController,
                label: 'Height (cm)',
                icon: Icons.height_rounded,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 14),

              _buildTextField(
                controller: weightController,
                label: 'Weight (kg)',
                icon: Icons.monitor_weight_outlined,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 28),

              // FITNESS GOAL
              const Text(
                'Fitness Goal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Container(
                width: double.infinity,

                padding: const EdgeInsets.symmetric(horizontal: 16),

                decoration: BoxDecoration(
                  color: const Color(0xFF0A141F),

                  borderRadius: BorderRadius.circular(14),

                  border: Border.all(color: const Color(0xFF172331)),
                ),

                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedGoal,

                    dropdownColor: const Color(0xFF0A141F),

                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.white70,
                    ),

                    style: const TextStyle(color: Colors.white, fontSize: 15),

                    items: const [
                      DropdownMenuItem(
                        value: 'Build Muscle',
                        child: Text('Build Muscle'),
                      ),
                      DropdownMenuItem(
                        value: 'Lose Weight',
                        child: Text('Lose Weight'),
                      ),
                      DropdownMenuItem(
                        value: 'Stay Fit',
                        child: Text('Stay Fit'),
                      ),
                      DropdownMenuItem(
                        value: 'Improve Endurance',
                        child: Text('Improve Endurance'),
                      ),
                    ],

                    onChanged: (value) {
                      if (value == null) return;

                      setState(() {
                        selectedGoal = value;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 35),

              // SAVE BUTTON
              SizedBox(
                width: double.infinity,
                height: 52,

                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: blue,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),

                  child: const Text(
                    'Save Changes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,

      keyboardType: keyboardType,

      style: const TextStyle(color: Colors.white, fontSize: 15),

      cursorColor: blue,

      decoration: InputDecoration(
        labelText: label,

        labelStyle: const TextStyle(color: Colors.white54),

        prefixIcon: Icon(icon, color: blue, size: 21),

        filled: true,

        fillColor: const Color(0xFF0A141F),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),

          borderSide: const BorderSide(color: Color(0xFF172331)),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),

          borderSide: const BorderSide(color: blue, width: 1.2),
        ),
      ),
    );
  }
}
