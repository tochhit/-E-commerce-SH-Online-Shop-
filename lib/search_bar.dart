import 'package:ecommerce/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';

class TSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final VoidCallback? onClear;
  final bool isSearchFocused;
  final List<String> searchHistory;

  const TSearchBar({
    Key? key,
    required this.controller,
    required this.isSearchFocused,
    required this.searchHistory,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Column(
      children: [
        TextField(
          controller: controller,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          decoration: InputDecoration(
            labelText: 'Search in Store',
            labelStyle: TextStyle(color: dark ? TColors.grey : TColors.grey),
            prefixIcon: const Icon(Iconsax.search_normal),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: onClear,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        if (isSearchFocused && searchHistory.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Recent Searches', style: Theme.of(context).textTheme.titleLarge),
                    TextButton(
                      onPressed: () {}, // Implement clear all history
                      child: const Text('Clear All'),
                    ),
                  ],
                ),
                Wrap(
                  spacing: 8.0,
                  children: searchHistory.map((item) {
                    return Chip(
                      label: Text(item),
                      deleteIcon: const Icon(Icons.close),
                      onDeleted: () {}, // Implement remove history item
                    );
                  }).toList(),
                ),
                const SizedBox(height: TSizes.defaultSpace),
              ],
            ),
          ),
      ],
    );
  }
}