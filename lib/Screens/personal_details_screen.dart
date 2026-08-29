import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:fit_nova_x/Screens/founder_note_screen.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  static const Color primaryColor = Color.fromARGB(255, 34, 174, 239);

  static const Color subtitleColor = Color.fromARGB(255, 198, 197, 197);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  final SupabaseClient _supabase = Supabase.instance.client;

  DateTime? selectedDate;

  String? selectedGender;

  String selectedCountryCode = '+91';

  File? selectedImage;

  bool isSaving = false;

  final List<String> countryCodes = ['+91', '+1', '+44', '+61', '+971', '+65'];

  final List<String> genders = ['Male', 'Female', 'Other', 'Prefer not to say'];

  @override
  void dispose() {
    nameController.dispose();
    heightController.dispose();
    weightController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  // ===============================================================
  // PICK PROFILE IMAGE
  // ===============================================================

  Future<void> _pickProfileImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image == null) {
        return;
      }

      setState(() {
        selectedImage = File(image.path);
      });
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not select profile photo')),
      );
    }
  }

  // ===============================================================
  // SELECT DATE
  // ===============================================================

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: primaryColor,
              onPrimary: Colors.white,
              surface: Color(0xFF151515),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  // ===============================================================
  // UPLOAD PROFILE IMAGE
  // ===============================================================

  Future<String?> _uploadProfileImage(String userId) async {
    if (selectedImage == null) {
      return null;
    }

    final String filePath =
        '$userId/profile_${DateTime.now().millisecondsSinceEpoch}.jpg';

    await _supabase.storage
        .from('profile-images')
        .upload(
          filePath,
          selectedImage!,
          fileOptions: const FileOptions(
            upsert: true,
            contentType: 'image/jpeg',
          ),
        );

    final String imageUrl = _supabase.storage
        .from('profile-images')
        .getPublicUrl(filePath);

    return imageUrl;
  }

  // ===============================================================
  // SAVE PROFILE
  // ===============================================================

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your date of birth')),
      );

      return;
    }

    if (selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your gender')),
      );

      return;
    }

    final User? user = _supabase.auth.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please login again')));

      return;
    }

    setState(() {
      isSaving = true;
    });

    try {
      // -----------------------------------------------------------
      // Upload profile image if selected
      // -----------------------------------------------------------

      String? profileImageUrl;

      if (selectedImage != null) {
        profileImageUrl = await _uploadProfileImage(user.id);
      }

      // -----------------------------------------------------------
      // Save profile data
      // -----------------------------------------------------------

      await _supabase.from('profiles').upsert({
        'id': user.id,
        'name': nameController.text.trim(),
        'date_of_birth': _formatDateForDatabase(selectedDate!),
        'gender': selectedGender,
        'height': double.parse(heightController.text.trim()),
        'weight': double.parse(weightController.text.trim()),
        'phone': phoneController.text.trim(),
        'country_code': selectedCountryCode,
        'profile_image_url': profileImageUrl,
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile saved successfully')),
      );

      // -----------------------------------------------------------
      // Move to Founder Note
      // -----------------------------------------------------------

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FounderNoteScreen()),
      );
    } on StorageException catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image upload failed: ${error.message}')),
      );
    } on PostgrestException catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile save failed: ${error.message}')),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Something went wrong: $error')));
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  // ===============================================================
  // FORMAT DATE FOR SUPABASE
  // ===============================================================

  String _formatDateForDatabase(DateTime date) {
    final String month = date.month.toString().padLeft(2, '0');
    final String day = date.day.toString().padLeft(2, '0');

    return '${date.year}-$month-$day';
  }

  // ===============================================================
  // BUILD
  // ===============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // =====================================================
                // BACK BUTTON
                // =====================================================

                IconButton(
                  onPressed: isSaving
                      ? null
                      : () {
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                        },
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),

                const SizedBox(height: 20),

                // =====================================================
                // TITLE
                // =====================================================
                const Text(
                  'Create Your Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 7),

                const Text(
                  'Let’s get to know you better.',
                  style: TextStyle(color: subtitleColor, fontSize: 13),
                ),

                const SizedBox(height: 28),

                // =====================================================
                // PROFILE PICTURE
                // =====================================================
                Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 105,
                            width: 105,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF101820),
                              border: Border.all(
                                color: const Color(0xFF263441),
                                width: 2,
                              ),
                            ),
                            child: ClipOval(
                              child: selectedImage != null
                                  ? Image.file(
                                      selectedImage!,
                                      width: 105,
                                      height: 105,
                                      fit: BoxFit.cover,
                                    )
                                  : const Icon(
                                      Icons.person_rounded,
                                      color: Colors.white54,
                                      size: 55,
                                    ),
                            ),
                          ),

                          Positioned(
                            right: 0,
                            bottom: 3,
                            child: Container(
                              height: 34,
                              width: 34,
                              decoration: const BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: isSaving ? null : _pickProfileImage,
                                icon: const Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
                                  size: 17,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 9),

                      GestureDetector(
                        onTap: isSaving ? null : _pickProfileImage,
                        child: const Text(
                          'Add Profile Photo',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // =====================================================
                // FULL NAME
                // =====================================================
                _sectionLabel('Full Name'),

                const SizedBox(height: 8),

                TextFormField(
                  controller: nameController,
                  cursorColor: primaryColor,
                  style: const TextStyle(color: Colors.white),
                  textCapitalization: TextCapitalization.words,
                  decoration: _inputDecoration(
                    hintText: 'Enter your full name',
                    icon: Icons.person_outline_rounded,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your full name';
                    }

                    if (value.trim().length < 2) {
                      return 'Please enter a valid name';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // =====================================================
                // DATE OF BIRTH
                // =====================================================
                _sectionLabel('Date of Birth'),

                const SizedBox(height: 8),

                GestureDetector(
                  onTap: isSaving ? null : _selectDate,
                  child: AbsorbPointer(
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecoration(
                        hintText: selectedDate == null
                            ? 'Select your date of birth'
                            : '${selectedDate!.day.toString().padLeft(2, '0')}/'
                                  '${selectedDate!.month.toString().padLeft(2, '0')}/'
                                  '${selectedDate!.year}',
                        icon: Icons.calendar_today_outlined,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // =====================================================
                // GENDER
                // =====================================================
                _sectionLabel('Gender'),

                const SizedBox(height: 8),

                DropdownButtonFormField<String>(
                  value: selectedGender,
                  dropdownColor: const Color(0xFF151515),
                  iconEnabledColor: Colors.white54,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  decoration: _inputDecoration(
                    hintText: 'Select your gender',
                    icon: Icons.wc_outlined,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your gender';
                    }

                    return null;
                  },
                  items: genders.map((gender) {
                    return DropdownMenuItem(value: gender, child: Text(gender));
                  }).toList(),
                  onChanged: isSaving
                      ? null
                      : (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                ),

                const SizedBox(height: 20),

                // =====================================================
                // HEIGHT & WEIGHT
                // =====================================================
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sectionLabel('Height'),

                          const SizedBox(height: 8),

                          TextFormField(
                            controller: heightController,
                            cursorColor: primaryColor,
                            style: const TextStyle(color: Colors.white),
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: _inputDecoration(
                              hintText: 'Height (cm)',
                              icon: Icons.height_rounded,
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Required';
                              }

                              final double? height = double.tryParse(
                                value.trim(),
                              );

                              if (height == null ||
                                  height < 50 ||
                                  height > 250) {
                                return 'Invalid height';
                              }

                              return null;
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sectionLabel('Weight'),

                          const SizedBox(height: 8),

                          TextFormField(
                            controller: weightController,
                            cursorColor: primaryColor,
                            style: const TextStyle(color: Colors.white),
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: _inputDecoration(
                              hintText: 'Weight (kg)',
                              icon: Icons.monitor_weight_outlined,
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Required';
                              }

                              final double? weight = double.tryParse(
                                value.trim(),
                              );

                              if (weight == null ||
                                  weight < 20 ||
                                  weight > 300) {
                                return 'Invalid weight';
                              }

                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // =====================================================
                // PHONE NUMBER
                // =====================================================
                _sectionLabel('Phone Number'),

                const SizedBox(height: 8),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 56,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF151515),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFF303030)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedCountryCode,
                          dropdownColor: const Color(0xFF151515),
                          iconEnabledColor: Colors.white54,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                          items: countryCodes.map((code) {
                            return DropdownMenuItem(
                              value: code,
                              child: Text(code),
                            );
                          }).toList(),
                          onChanged: isSaving
                              ? null
                              : (value) {
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
                        decoration: _inputDecoration(
                          hintText: 'Phone number',
                          icon: Icons.phone_outlined,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your phone number';
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

                const SizedBox(height: 35),

                // =====================================================
                // CONTINUE BUTTON
                // =====================================================
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: isSaving ? null : _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      disabledBackgroundColor: primaryColor.withValues(
                        alpha: 0.5,
                      ),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: isSaving
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===============================================================
  // SECTION LABEL
  // ===============================================================

  Widget _sectionLabel(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  // ===============================================================
  // INPUT DECORATION
  // ===============================================================

  InputDecoration _inputDecoration({
    required String hintText,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 13),
      prefixIcon: Icon(icon, color: Colors.grey, size: 20),
      filled: true,
      fillColor: const Color(0xFF151515),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFF303030)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFF303030)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }
}
