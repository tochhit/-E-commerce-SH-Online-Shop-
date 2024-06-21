import 'package:flutter/material.dart';

import '../../common/widgets/appbar/appbar.dart';
import '../../utils/constants/colors.dart';
import '../../utils/helpers/helper_functions.dart';

class PackagesScreen extends StatelessWidget {
  const PackagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text('Packages', style: Theme.of(context).textTheme.headlineSmall), showBackArrow: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DeliveryInstructionsSection(),
            const SizedBox(height: 16),
            const NotesSection(),
            const SizedBox(height: 16),
            PackageTrackingInformationSection(),
          ],
        ),
      ),
    );
  }
}

class DeliveryInstructionsSection extends StatelessWidget {
  const DeliveryInstructionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.delivery_dining, size: 30),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Delivery to Customer',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                'The courier is Vathana. If there is any problem, please contact : 0123456789',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class NotesSection extends StatelessWidget {
  const NotesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'NOTES',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Card(
          color: dark ? TColors.darkerGrey : TColors.softGrey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'VET Express:',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text('ID-WES795 (Items packed)',style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 5),
                Text(
                  'Address:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 5),
                const Text('Chhit, 085 5033422, 108, Home, Siem Reap, Cambodia'),
                const SizedBox(height: 5),
                const Text(
                  '18 June 2024 - 07:22',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PackageTrackingInformationSection extends StatelessWidget {
  final List<TrackingStep> trackingSteps = [
    TrackingStep('Delivery to Customer', '18 June, 2024', '07:24am'),
    TrackingStep('Pickup', '18 June, 2024', '07:56am'),
    TrackingStep('Arrived Siem Reap', '18 June, 2024', '08:24am'),
    TrackingStep('Transported from PP to SR', '18 June, 2024', '12:26am'),
    TrackingStep('Delivery VET', '17 June, 2023', '11:53am'),
    TrackingStep('Shipped Out SH-Online', '17 June, 2024', '10:56pm'),
  ];

  PackageTrackingInformationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: trackingSteps.length,
        itemBuilder: (context, index) {
          return TrackingStepWidget(step: trackingSteps[index]);
        },
      ),
    );
  }
}

class TrackingStep {
  final String status;
  final String date;
  final String time;

  TrackingStep(this.status, this.date, this.time);
}

class TrackingStepWidget extends StatelessWidget {
  final TrackingStep step;

  const TrackingStepWidget({Key? key, required this.step}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              children: [
                const Icon(Icons.radio_button_checked, color: Colors.grey),
                Container(height: 30, width: 2, color: Colors.grey),
              ],
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(step.status),
                const SizedBox(height: 5),
                Text('${step.date} - ${step.time}', style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
