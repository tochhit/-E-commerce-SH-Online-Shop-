import 'package:flutter/material.dart';
class PaymentMethodItem extends StatelessWidget {
  const PaymentMethodItem({
    super.key,
    required this.imagePath,
    required this.title,
    this.description = '',
    this.logoPaths,
    this.onTap,
  });

  final String imagePath;
  final String title;
  final String description;
  final List<String>? logoPaths;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Image.asset(
        imagePath,
        width: 40,
        height: 40,
      ),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(description, style: Theme.of(context).textTheme.labelMedium),
          if (logoPaths != null)
            Row(
              children: logoPaths!
                  .map((logoPath) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.asset(
                  logoPath,
                  width: 24,
                  height: 24,
                ),
              ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}
class CPaymentMethodItem extends StatelessWidget {
  const CPaymentMethodItem({
    super.key,
    required this.imagePath,
    required this.title,
    this.logoPaths,
    this.onTap,
  });

  final String imagePath;
  final String title;
  final List<String>? logoPaths;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Image.asset(
        imagePath,
        width: 40,
        height: 40,
      ),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (logoPaths != null)
            Row(
              children: logoPaths!
                  .map((logoPath) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.asset(
                  logoPath,
                  width: 24,
                  height: 24,
                ),
              ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}