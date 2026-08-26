import 'package:flutter/material.dart';

class WorkoutScheduleScreen extends StatefulWidget {
  const WorkoutScheduleScreen({super.key});

  @override
  State<WorkoutScheduleScreen> createState() => _WorkoutScheduleScreenState();
}

class _WorkoutScheduleScreenState extends State<WorkoutScheduleScreen> {
  int currentStep = 0;

  final List<String> steps = [
    'Goal',
    'Fitness Level',
    'Location',
    'Equipment',
    'Workout Days',
  ];

  // Single selections
  String? selectedGoal;
  String? selectedFitnessLevel;
  String? selectedLocation;
  String? selectedWorkoutDays;

  // Multiple selections
  final Set<String> selectedEquipment = {};

  final Color blue = const Color(0xFF008CFF);

  // ------------------------------------------------------------
  // CONTINUE
  // ------------------------------------------------------------

  void nextStep() {
    if (!canContinue) return;

    if (currentStep < steps.length - 1) {
      setState(() {
        currentStep++;
      });
    } else {
      // Later:
      // Generate workout plan
    }
  }

  // ------------------------------------------------------------
  // BACK
  // ------------------------------------------------------------

  void previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    } else {
      Navigator.pop(context);
    }
  }

  // ------------------------------------------------------------
  // CHECK WHETHER CURRENT STEP HAS A SELECTION
  // ------------------------------------------------------------

  bool get canContinue {
    switch (currentStep) {
      case 0:
        return selectedGoal != null;

      case 1:
        return selectedFitnessLevel != null;

      case 2:
        return selectedLocation != null;

      case 3:
        return selectedEquipment.isNotEmpty;

      case 4:
        return selectedWorkoutDays != null;

      default:
        return false;
    }
  }

  // ------------------------------------------------------------
  // BUILD
  // ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,

        leading: IconButton(
          onPressed: previousStep,

          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),

        title: const Text(
          'Workout Setup',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // ------------------------------------------------
              // STEP INDICATOR
              // ------------------------------------------------
              Row(
                children: List.generate(steps.length, (index) {
                  final bool active = index <= currentStep;

                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),

                      height: 4,

                      decoration: BoxDecoration(
                        color: active ? blue : const Color(0xFF202832),

                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // STEP NUMBER
              // ------------------------------------------------
              Text(
                'Step ${currentStep + 1} of ${steps.length}',

                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),

              const SizedBox(height: 8),

              // ------------------------------------------------
              // STEP TITLE
              // ------------------------------------------------
              Text(
                steps[currentStep],

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Let’s personalize your workout plan.',

                style: TextStyle(color: Colors.white60, fontSize: 13),
              ),

              const SizedBox(height: 30),

              // ------------------------------------------------
              // STEP CONTENT
              // ------------------------------------------------
              Expanded(child: _buildStepContent()),

              // ------------------------------------------------
              // CONTINUE BUTTON
              // ------------------------------------------------
              if (canContinue) ...[
                const SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  height: 52,

                  child: ElevatedButton(
                    onPressed: nextStep,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),

                    child: Text(
                      currentStep == steps.length - 1
                          ? 'Generate Plan'
                          : 'Continue',

                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // STEP CONTENT
  // ------------------------------------------------------------

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _optionList([
          'Build Muscle',
          'Lose Weight',
          'Stay Fit',
          'Improve Endurance',
        ]);

      case 1:
        return _optionList(['Beginner', 'Intermediate', 'Advanced']);

      case 2:
        return _optionList(['Gym', 'Home', 'Gym + Home']);

      case 3:
        return _optionList([
          'Barbell',
          'Dumbbells',
          'Machine',
          'Kettlebells',
          'Cables',
          'Resistance Bands',
          'Bodyweight',
          'Other',
        ]);

      case 4:
        return _optionList(['3 Days', '4 Days', '5 Days', '6 Days']);

      default:
        return const SizedBox();
    }
  }

  // ------------------------------------------------------------
  // OPTION LIST
  // ------------------------------------------------------------

  Widget _optionList(List<String> options) {
    return ListView.separated(
      itemCount: options.length,

      separatorBuilder: (_, __) => const SizedBox(height: 12),

      itemBuilder: (context, index) {
        final String option = options[index];

        final bool isSelected = _isSelected(option);

        return GestureDetector(
          onTap: () {
            _selectOption(option);
          },

          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),

            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),

            decoration: BoxDecoration(
              color: isSelected
                  ? blue.withValues(alpha: 0.15)
                  : const Color(0xFF0A141F),

              borderRadius: BorderRadius.circular(14),

              border: Border.all(
                color: isSelected ? blue : const Color(0xFF172331),

                width: isSelected ? 1.5 : 1,
              ),
            ),

            child: Row(
              children: [
                // --------------------------------------------
                // OPTION TEXT
                // --------------------------------------------
                Expanded(
                  child: Text(
                    option,

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w600,
                    ),
                  ),
                ),

                // --------------------------------------------
                // SELECTION ICON
                // --------------------------------------------
                Container(
                  height: 24,
                  width: 24,

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    color: isSelected ? blue : Colors.transparent,

                    border: Border.all(
                      color: isSelected ? blue : Colors.white38,
                    ),
                  ),

                  child: isSelected
                      ? const Icon(Icons.check, color: Colors.white, size: 16)
                      : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ------------------------------------------------------------
  // CHECK SELECTED OPTION
  // ------------------------------------------------------------

  bool _isSelected(String option) {
    switch (currentStep) {
      case 0:
        return selectedGoal == option;

      case 1:
        return selectedFitnessLevel == option;

      case 2:
        return selectedLocation == option;

      case 3:
        return selectedEquipment.contains(option);

      case 4:
        return selectedWorkoutDays == option;

      default:
        return false;
    }
  }

  // ------------------------------------------------------------
  // SELECT / DESELECT OPTION
  // ------------------------------------------------------------

  void _selectOption(String option) {
    setState(() {
      switch (currentStep) {
        // --------------------------------------------
        // GOAL
        // --------------------------------------------

        case 0:
          selectedGoal = option;
          break;

        // --------------------------------------------
        // FITNESS LEVEL
        // --------------------------------------------

        case 1:
          selectedFitnessLevel = option;
          break;

        // --------------------------------------------
        // LOCATION
        // --------------------------------------------

        case 2:
          selectedLocation = option;
          break;

        // --------------------------------------------
        // EQUIPMENT - MULTIPLE SELECTION
        // --------------------------------------------

        case 3:
          if (selectedEquipment.contains(option)) {
            selectedEquipment.remove(option);
          } else {
            selectedEquipment.add(option);
          }
          break;

        // --------------------------------------------
        // WORKOUT DAYS
        // --------------------------------------------

        case 4:
          selectedWorkoutDays = option;
          break;
      }
    });
  }
}
