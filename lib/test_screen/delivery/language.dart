import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';

import '../../common/widgets/appbar/appbar.dart';
import '../../utils/constants/colors.dart';
import '../../utils/helpers/helper_functions.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text('Language', style: Theme.of(context).textTheme.headlineSmall)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LanguageItem(
              flagPath: TImages.cambodia,
              language: 'Khmer',
              isSelected: selectedLanguage == 'Khmer',
              onTap: () {
                setState(() {
                  selectedLanguage = 'Khmer';
                });
              },
            ),
            LanguageItem(
              flagPath: TImages.english,
              language: 'English',
              isSelected: selectedLanguage == 'English',
              onTap: () {
                setState(() {
                  selectedLanguage = 'English';
                });
              },
            ),
            LanguageItem(
              flagPath: TImages.china,
              language: 'Chinese',
              isSelected: selectedLanguage == 'Chinese',
              onTap: () {
                setState(() {
                  selectedLanguage = 'Chinese';
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageItem extends StatelessWidget {
  final String flagPath;
  final String language;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageItem({
    Key? key,
    required this.flagPath,
    required this.language,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: dark ? TColors.darkerGrey : TColors.softGrey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Image.asset(flagPath, width: 40, height: 40),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                language,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            if (isSelected)
              const Icon(Icons.check, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
