import 'package:flutter/material.dart';

class HealthRecordsScreen extends StatefulWidget {
  const HealthRecordsScreen({super.key});

  @override
  State<HealthRecordsScreen> createState() => _HealthRecordsScreenState();
}

class _HealthRecordsScreenState extends State<HealthRecordsScreen> {
  static const Color blue = Color(0xFF008CFF);

  final List<Map<String, dynamic>> records = [
    {
      'title': 'Blood Test',
      'subtitle': 'Routine blood work',
      'date': '12 Aug 2026',
      'icon': Icons.bloodtype_outlined,
      'type': 'Medical Report',
    },
    {
      'title': 'Body Checkup',
      'subtitle': 'General health assessment',
      'date': '05 Jul 2026',
      'icon': Icons.health_and_safety_outlined,
      'type': 'Health Checkup',
    },
    {
      'title': 'Fitness Assessment',
      'subtitle': 'Body composition & fitness',
      'date': '20 Jun 2026',
      'icon': Icons.monitor_heart_outlined,
      'type': 'Fitness Record',
    },
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
          'Health Records',
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
                'Your Health Records',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Keep your important health and fitness records organized.',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),

              const SizedBox(height: 24),

              // ====================================================
              // SUMMARY CARD
              // ====================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: const Color(0xFF08131F),
                  borderRadius: BorderRadius.circular(19),

                  border: Border.all(color: const Color(0xFF142333)),
                ),

                child: Row(
                  children: [
                    Container(
                      height: 54,
                      width: 54,

                      decoration: BoxDecoration(
                        color: blue.withValues(alpha: 0.10),
                        shape: BoxShape.circle,
                      ),

                      child: const Icon(
                        Icons.folder_shared_outlined,
                        color: blue,
                        size: 28,
                      ),
                    ),

                    const SizedBox(width: 14),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Health Records',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            'Your health information in one place',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Text(
                      '${records.length}',
                      style: const TextStyle(
                        color: blue,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ====================================================
              // RECORDS
              // ====================================================
              const Text(
                'Recent Records',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              ...List.generate(records.length, (index) {
                return _recordCard(records[index]);
              }),

              const SizedBox(height: 18),

              // ====================================================
              // ADD RECORD
              // ====================================================
              GestureDetector(
                onTap: _showAddRecordSheet,

                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),

                  decoration: BoxDecoration(
                    color: blue.withValues(alpha: 0.08),

                    borderRadius: BorderRadius.circular(15),

                    border: Border.all(color: blue.withValues(alpha: 0.35)),
                  ),

                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Icon(Icons.add_rounded, color: blue, size: 21),

                      SizedBox(width: 8),

                      Text(
                        'Add Health Record',
                        style: TextStyle(
                          color: blue,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ====================================================
              // PRIVACY NOTE
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
                        Icons.lock_outline_rounded,
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
                            'Keep Your Records Secure',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            'Health records may contain sensitive '
                            'information. Store and share them carefully.',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 10,
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
  // RECORD CARD
  // ==============================================================

  Widget _recordCard(Map<String, dynamic> record) {
    return GestureDetector(
      onTap: () {
        _showRecordDetails(record);
      },

      child: Container(
        width: double.infinity,

        margin: const EdgeInsets.only(bottom: 10),

        padding: const EdgeInsets.all(15),

        decoration: BoxDecoration(
          color: const Color(0xFF08131F),

          borderRadius: BorderRadius.circular(17),

          border: Border.all(color: const Color(0xFF142333)),
        ),

        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,

              decoration: BoxDecoration(
                color: blue.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(14),
              ),

              child: Icon(record['icon'], color: blue, size: 25),
            ),

            const SizedBox(width: 13),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    record['title'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    record['subtitle'],
                    style: const TextStyle(color: Colors.white30, fontSize: 10),
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        color: blue,
                        size: 11,
                      ),

                      const SizedBox(width: 4),

                      Text(
                        record['date'],
                        style: const TextStyle(
                          color: blue,
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white30,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }

  // ==============================================================
  // ADD RECORD SHEET
  // ==============================================================

  void _showAddRecordSheet() {
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
                  'Add Health Record',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                _recordOption(
                  icon: Icons.bloodtype_outlined,
                  title: 'Blood Test',
                ),

                const SizedBox(height: 10),

                _recordOption(
                  icon: Icons.health_and_safety_outlined,
                  title: 'Health Checkup',
                ),

                const SizedBox(height: 10),

                _recordOption(
                  icon: Icons.monitor_heart_outlined,
                  title: 'Fitness Assessment',
                ),

                const SizedBox(height: 10),

                _recordOption(
                  icon: Icons.description_outlined,
                  title: 'Other Document',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ==============================================================
  // RECORD OPTION
  // ==============================================================

  Widget _recordOption({required IconData icon, required String title}) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$title selected'),
            duration: const Duration(seconds: 2),
          ),
        );
      },

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

  // ==============================================================
  // RECORD DETAILS
  // ==============================================================

  void _showRecordDetails(Map<String, dynamic> record) {
    showModalBottomSheet(
      context: context,

      backgroundColor: const Color(0xFF08131F),

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),

      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 25),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                Container(
                  height: 56,
                  width: 56,

                  decoration: BoxDecoration(
                    color: blue.withValues(alpha: 0.10),
                    shape: BoxShape.circle,
                  ),

                  child: Icon(record['icon'], color: blue, size: 28),
                ),

                const SizedBox(height: 14),

                Text(
                  record['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  record['subtitle'],
                  style: const TextStyle(color: Colors.white54, fontSize: 11),
                ),

                const SizedBox(height: 15),

                Text(
                  record['type'],
                  style: const TextStyle(
                    color: blue,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  record['date'],
                  style: const TextStyle(color: Colors.white38, fontSize: 10),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
