import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'card_controller.dart';
import 'credit_card_model.dart';

class CardMethodItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final List<String>? logoPaths;
  final VoidCallback? onTap;
  final CardType cardType; // Add cardType parameter

  const CardMethodItem({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.description,
    this.logoPaths,
    this.onTap,
    required this.cardType, // Ensure cardType is required
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        imagePath,
        width: 40,
      ),
      title: Text(
        title, maxLines: 1, // Ensure title is shown in one line
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(description),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          // Show a confirmation dialog before deleting
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Confirm Deletion"),
                content: const Text("Are you sure you want to delete this card?"),
                actions: <Widget>[
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text("Delete"),
                    onPressed: () {
                      // Delete the card using CardController
                      Get.find<CardController>().deleteCardByType(cardType);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
      onTap: onTap,
    );
  }
}
