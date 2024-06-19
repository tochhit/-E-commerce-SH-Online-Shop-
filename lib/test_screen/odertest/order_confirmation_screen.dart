import 'package:flutter/material.dart';

import '../../common/widgets/appbar/appbar.dart';
import '../../features/shop/models/cart_item_model.dart';
import '../../utils/constants/sizes.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final String orderId;
  final List<CartItemModel> orderItems;
  final double totalAmount;

  const OrderConfirmationScreen({
    Key? key,
    required this.orderId,
    required this.orderItems,
    required this.totalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: Text('Order Confirmation'),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Order Details',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                'Order ID: $orderId',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                'Items:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: orderItems
                    .map((item) => _buildOrderItemWidget(context, item))
                    .toList(),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                'Total Amount: \$${totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: const Text('Back to Menu'),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _showCancelOrderDialog(context);
                  },
                  child: const Text('Cancel Order'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderItemWidget(BuildContext context, CartItemModel item) {
    return ListTile(
      leading: item.image != null
          ? SizedBox(
        width: 50,
        height: 50,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            item.image!,
            fit: BoxFit.cover,
          ),
        ),
      )
          : const SizedBox(
        width: 50,
        height: 50,
        child: Icon(Icons.image),
      ),
      title: Text(
        item.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text('Quantity: ${item.quantity}'),
      trailing:
      Text('\$${(item.quantity * item.price).toStringAsFixed(2)}'),
    );
  }


  void _showCancelOrderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Cancel Order'),
          content: const Text('Are you sure you want to cancel this order?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                // Perform cancellation logic here, e.g., call an API, update state, etc.
                Navigator.of(dialogContext).pop(); // Close the dialog
                _handleCancelOrder(); // Example function to handle cancellation
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _handleCancelOrder() {
    // Implement your cancellation logic here, such as calling an API, updating state, etc.
    print('Order cancelled');
    // Example: To navigate back to a specific screen after cancellation
    // Navigator.of(context).pushReplacementNamed('/home');
  }
}
