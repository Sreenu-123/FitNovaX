import 'package:flutter/material.dart';

class ProgressPhotosScreen extends StatefulWidget {
  const ProgressPhotosScreen({super.key});

  @override
  State<ProgressPhotosScreen> createState() => _ProgressPhotosScreenState();
}

class _ProgressPhotosScreenState extends State<ProgressPhotosScreen> {
  static const Color blue = Color(0xFF008CFF);

  // Temporary data.
  // Later these will come from the user's uploaded photos.
  final List<Map<String, String>> progressPhotos = [
    {'title': 'Starting Point', 'date': 'Today'},
    {'title': 'Week 4', 'date': '4 weeks ago'},
    {'title': 'Week 8', 'date': '8 weeks ago'},
    {'title': 'Week 12', 'date': '12 weeks ago'},
  ];

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
          'Progress Photos',
          style: TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

          padding: const EdgeInsets.fromLTRB(16, 10, 16, 30),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ====================================================
              // HEADER
              // ====================================================
              const Text(
                'Track Your Progress',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Take photos regularly and watch your transformation.',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),

              const SizedBox(height: 24),

              // ====================================================
              // ADD PHOTO CARD
              // ====================================================
              GestureDetector(
                onTap: _addPhoto,

                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20),

                  decoration: BoxDecoration(
                    color: const Color(0xFF08131F),

                    borderRadius: BorderRadius.circular(16),

                    border: Border.all(color: blue.withValues(alpha: 0.45)),
                  ),

                  child: Column(
                    children: [
                      Container(
                        height: 52,
                        width: 52,

                        decoration: BoxDecoration(
                          color: blue.withValues(alpha: 0.10),
                          shape: BoxShape.circle,
                        ),

                        child: const Icon(
                          Icons.add_a_photo_outlined,
                          color: blue,
                          size: 25,
                        ),
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        'Add Progress Photo',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      const Text(
                        'Capture your latest progress',
                        style: TextStyle(color: Colors.white54, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ====================================================
              // PROGRESS PHOTOS
              // ====================================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Your Progress',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    '${progressPhotos.length} Photos',
                    style: const TextStyle(
                      color: blue,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // ====================================================
              // PHOTO GRID
              // ====================================================
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),

                itemCount: progressPhotos.length,

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,

                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,

                  childAspectRatio: 0.82,
                ),

                itemBuilder: (context, index) {
                  final photo = progressPhotos[index];

                  return _photoCard(
                    title: photo['title']!,
                    date: photo['date']!,
                  );
                },
              ),

              const SizedBox(height: 28),

              // ====================================================
              // TIP
              // ====================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: const Color(0xFF08131F),

                  borderRadius: BorderRadius.circular(16),

                  border: Border.all(color: const Color(0xFF142333)),
                ),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 36,
                      width: 36,

                      decoration: BoxDecoration(
                        color: blue.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: const Icon(
                        Icons.lightbulb_outline_rounded,
                        color: blue,
                        size: 20,
                      ),
                    ),

                    const SizedBox(width: 12),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Progress Tip',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            'Take your photos in the same lighting, '
                            'angle and pose to make your progress '
                            'easier to compare.',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 11,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==============================================================
  // PHOTO CARD
  // ==============================================================

  Widget _photoCard({required String title, required String date}) {
    return GestureDetector(
      onTap: () {
        // Later: Open full-size photo
      },

      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF08131F),

          borderRadius: BorderRadius.circular(16),

          border: Border.all(color: const Color(0xFF142333)),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,

                decoration: BoxDecoration(
                  color: const Color(0xFF101A25),

                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),

                child: const Center(
                  child: Icon(
                    Icons.image_outlined,
                    color: Colors.white24,
                    size: 45,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 11),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    date,
                    style: const TextStyle(color: Colors.white38, fontSize: 9),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==============================================================
  // ADD PHOTO
  // ==============================================================

  void _addPhoto() {
    showModalBottomSheet(
      context: context,

      backgroundColor: const Color(0xFF08131F),

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),

      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 25),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                Container(
                  height: 4,
                  width: 40,

                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 22),

                const Text(
                  'Add Progress Photo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                _photoOption(
                  icon: Icons.camera_alt_outlined,
                  title: 'Take Photo',
                  onTap: () {
                    Navigator.pop(context);
                    // Later: Open camera
                  },
                ),

                const SizedBox(height: 10),

                _photoOption(
                  icon: Icons.photo_library_outlined,
                  title: 'Choose from Gallery',
                  onTap: () {
                    Navigator.pop(context);
                    // Later: Open gallery
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ==============================================================
  // PHOTO OPTION
  // ==============================================================

  Widget _photoOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),

        decoration: BoxDecoration(
          color: const Color(0xFF101C29),

          borderRadius: BorderRadius.circular(14),

          border: Border.all(color: const Color(0xFF172A3A)),
        ),

        child: Row(
          children: [
            Icon(icon, color: blue, size: 23),

            const SizedBox(width: 13),

            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),

            const Spacer(),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white38,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
