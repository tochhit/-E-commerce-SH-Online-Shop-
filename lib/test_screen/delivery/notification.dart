import 'package:flutter/material.dart';

import '../../common/widgets/appbar/appbar.dart';
import '../../utils/constants/colors.dart';
import '../../utils/helpers/helper_functions.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text('Notifications', style: Theme.of(context).textTheme.headlineSmall)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            NotificationItem(
              date: '18/June/24',
              time: '09:10:33',
              message: 'Delivery: We are delivering to you. The courier is Vathana. If there is any problem, please contact : 0123456789',
            ),
            NotificationItem(
              date: '17/June/24',
              time: '15:26:45',
              message: 'Delivery: Your orderID [Wes457] are being transported from Phnom Penh to Siem Reap',
              isLink: true,
            ),
            NotificationItem(
              date: '17/June/24',
              time: '13:40:26',
              message: 'Order: Your purchase was successful, we will ship to you shortly. Thanks you for Order',
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String date;
  final String time;
  final String message;
  final bool isLink;

  const NotificationItem({
    Key? key,
    required this.date,
    required this.time,
    required this.message,
    this.isLink = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: dark ? TColors.darkerGrey : TColors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$date - $time',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: dark ? TColors.grey : TColors.darkerGrey),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: _buildMessageSpans(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: dark ? TColors.white : TColors.black),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete,),
            onPressed: () {
              // Implement delete functionality here
            },
          ),
        ],
      ),
    );
  }

  List<TextSpan> _buildMessageSpans() {
    if (isLink) {
      final parts = message.split('[Wes457]');
      return [
        TextSpan(text: parts[0]),
        const TextSpan(
          text: '[Wes457]',
          style: TextStyle(color: Colors.blue),
        ),
        TextSpan(text: parts[1]),
      ];
    } else {
      return [TextSpan(text: message)];
    }
  }
}