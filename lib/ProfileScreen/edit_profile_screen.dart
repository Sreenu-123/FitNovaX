import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fit_nova_x/services/profile_persistence_service.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> initialProfile;

  const EditProfileScreen({super.key, required this.initialProfile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  static const Color blue = Color(0xFF00C8FF);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();

  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController ageController;
  late final TextEditingController heightController;
  late final TextEditingController weightController;

  late String selectedGoal;

  String? profileImagePath;
  bool isSaving = false;
  bool isPickingImage = false;

  @override
  void initState() {
    super.initState();

    final profile = widget.initialProfile;

    nameController = TextEditingController(
      text: profile['name']?.toString() ?? '',
    );

    emailController = TextEditingController(
      text: profile['email']?.toString() ?? '',
    );

    ageController = TextEditingController(
      text: profile['age']?.toString() ?? '',
    );

    heightController = TextEditingController(
      text: profile['height']?.toString() ?? '',
    );

    weightController = TextEditingController(
      text: profile['weight']?.toString() ?? '',
    );

    const goals = <String>[
      'Build Muscle',
      'Lose Weight',
      'Stay Fit',
      'Improve Endurance',
    ];

    final existingGoal = profile['goal']?.toString() ?? 'Build Muscle';

    selectedGoal = goals.contains(existingGoal) ? existingGoal : 'Build Muscle';

    profileImagePath = profile['profileImagePath']?.toString();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();

    super.dispose();
  }

  Future<void> _pickProfileImage() async {
    if (isPickingImage || isSaving) return;

    setState(() {
      isPickingImage = true;
    });

    try {
      final XFile? pickedImage = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1200,
      );

      if (pickedImage == null) return;

      // Copy the selected image to the app's permanent documents
      // directory and store its path for this logged-in user.
      final permanentPath = await ProfilePersistenceService.persistImage(
        pickedImage.path,
      );

      if (!mounted) return;

      if (permanentPath == null || permanentPath.isEmpty) {
        throw Exception('Could not save the selected profile photo.');
      }

      final permanentFile = File(permanentPath);

      if (!await permanentFile.exists()) {
        throw Exception('The saved profile photo could not be found.');
      }

      setState(() {
        profileImagePath = permanentPath;
      });
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not save profile photo: $error')),
      );
    } finally {
      if (mounted) {
        setState(() {
          isPickingImage = false;
        });
      }
    }
  }

  ImageProvider<Object>? _profileImage() {
    final path = profileImagePath;

    if (path == null || path.isEmpty) {
      return null;
    }

    final file = File(path);

    if (!file.existsSync()) {
      return null;
    }

    return FileImage(file);
  }

  Future<void> _saveChanges() async {
    if (isSaving || isPickingImage) return;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isSaving = true;
    });

    final updatedProfile = <String, dynamic>{
      ...widget.initialProfile,
      'name': nameController.text.trim(),
      'email': emailController.text.trim(),
      'age': ageController.text.trim(),
      'height': heightController.text.trim(),
      'weight': weightController.text.trim(),
      'goal': selectedGoal,
      'profileImagePath': profileImagePath,
    };

    try {
      final success = await ProfilePersistenceService.saveProfile(
        updatedProfile,
      );

      if (!mounted) return;

      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Could not save profile. Check your backend '
              'connection and try again.',
            ),
          ),
        );

        return;
      }

      Navigator.pop<Map<String, dynamic>>(context, updatedProfile);
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Profile save failed: $error')));
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final image = _profileImage();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          onPressed: isSaving ? null : () => Navigator.pop(context),
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 104,
                            width: 104,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF0A141F),
                              border: Border.all(color: blue, width: 2),
                              image: image == null
                                  ? null
                                  : DecorationImage(
                                      image: image,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            child: image == null
                                ? const Icon(
                                    Icons.person,
                                    color: blue,
                                    size: 55,
                                  )
                                : null,
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Material(
                              color: blue,
                              shape: const CircleBorder(),
                              child: InkWell(
                                customBorder: const CircleBorder(),
                                onTap: isPickingImage || isSaving
                                    ? null
                                    : _pickProfileImage,
                                child: SizedBox(
                                  height: 34,
                                  width: 34,
                                  child: isPickingImage
                                      ? const Padding(
                                          padding: EdgeInsets.all(9),
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Icon(
                                          Icons.camera_alt_rounded,
                                          color: Colors.white,
                                          size: 17,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextButton.icon(
                        onPressed: isPickingImage || isSaving
                            ? null
                            : _pickProfileImage,
                        icon: const Icon(
                          Icons.photo_library_outlined,
                          size: 17,
                        ),
                        label: const Text('Change profile photo'),
                        style: TextButton.styleFrom(foregroundColor: blue),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                _sectionTitle('Personal Information'),
                const SizedBox(height: 15),

                _buildTextField(
                  controller: nameController,
                  label: 'Name',
                  icon: Icons.person_outline_rounded,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 14),

                _buildTextField(
                  controller: emailController,
                  label: 'Email',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    final email = value?.trim() ?? '';

                    if (email.isEmpty ||
                        !email.contains('@') ||
                        !email.contains('.')) {
                      return 'Enter a valid email address';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 14),

                _buildTextField(
                  controller: ageController,
                  label: 'Age',
                  icon: Icons.cake_outlined,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    final age = int.tryParse(value?.trim() ?? '');

                    if (age == null || age < 1 || age > 120) {
                      return 'Enter a valid age';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 28),

                _sectionTitle('Body Information'),
                const SizedBox(height: 15),

                _buildTextField(
                  controller: heightController,
                  label: 'Height (cm)',
                  icon: Icons.height_rounded,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (value) {
                    final height = double.tryParse(value?.trim() ?? '');

                    if (height == null || height <= 0 || height > 300) {
                      return 'Enter a valid height';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 14),

                _buildTextField(
                  controller: weightController,
                  label: 'Weight (kg)',
                  icon: Icons.monitor_weight_outlined,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (value) {
                    final weight = double.tryParse(value?.trim() ?? '');

                    if (weight == null || weight <= 0 || weight > 700) {
                      return 'Enter a valid weight';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 28),

                _sectionTitle('Fitness Goal'),
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
                      isExpanded: true,
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
                      onChanged: isSaving
                          ? null
                          : (value) {
                              if (value == null) return;

                              setState(() {
                                selectedGoal = value;
                              });
                            },
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: isSaving || isPickingImage ? null : _saveChanges,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: blue.withValues(alpha: 0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: isSaving
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Save Changes',
                            style: TextStyle(
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
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(color: Colors.white, fontSize: 15),
      cursorColor: blue,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white54),
        prefixIcon: Icon(icon, color: blue, size: 21),
        filled: true,
        fillColor: const Color(0xFF0A141F),
        errorStyle: const TextStyle(color: Colors.redAccent),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF172331)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: blue, width: 1.2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.2),
        ),
      ),
    );
  }
}
