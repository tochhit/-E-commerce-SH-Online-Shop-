import 'package:ecommerce/features/shop/controllers/all_products_controller.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../common/widgets/layouts/grid_layout.dart';
import '../products_cards/u_product_card_vertical.dart';

class USortableProducts extends StatelessWidget {
  const USortableProducts({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    // Initialize controller for managing product sorting
    final controller = Get.put(AllProductsController());
    controller.assignProducts(products);
    return Column(
      children: [
        /// Dropdown
        DropdownButtonFormField<String>(
          value: 'Name', // Initially selected value
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          onChanged: (value) {
            // Sort products based on the selected option
            controller.sortProducts(value!);
          },
          items: ['Name', 'Higher Price', 'Lower Price', 'Sale', 'Newest', 'Popularity']
              .map((option) => DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        /// Products
        Obx(() => TGridLayout(
          itemCount: controller.products.length,
          itemBuilder: (_, index) => UProductCardVertical(product: controller.products[index]),
        )),
      ],
    );
  }
}
