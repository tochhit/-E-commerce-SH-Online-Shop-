import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AboutMenu extends StatelessWidget {
  const AboutMenu({
    super.key,
    required this.onPressed,
    required this.title,
    required this.value,
    this.icon,

  });


  final IconData? icon;
  final VoidCallback onPressed;
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwItems / 1.5),
        child: Row(
          children: [
            Expanded(flex: 3, child: Text(title, style: Theme.of(context).textTheme.headlineSmall, overflow: TextOverflow.ellipsis)),
            Expanded(
              flex: 8,
              child: Text(value, style: Theme.of(context).textTheme.titleSmall, overflow: TextOverflow.ellipsis),
            ),
            Expanded(child: Icon(icon, size: 18)),
          ],
        ),
      ),
    );
  }
}
