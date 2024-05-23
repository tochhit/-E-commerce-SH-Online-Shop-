import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/icons/t_circular_icon.dart';
import 'package:ecommerce/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce/common/widgets/loaders/animation_loader.dart';
import 'package:ecommerce/common/widgets/products/products_cards/product_card_vertical.dart';
import 'package:ecommerce/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:ecommerce/features/shop/controllers/product/favourites_controller.dart';
import 'package:ecommerce/navigation_menu.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavouritesController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text('Wishlist', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          TCircularIcon(icon:Iconsax.add, onPressed: () => Get.offAll(const NavigationMenu())),
        ],
      ),

      /// Body
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),

            /// Products Grid
            child: Obx(
              () => FutureBuilder(
                future: controller.favoriteProducts(),
                builder: (context, snapshot) {
                  /// Nothing Found Widget
                  final emptyWidget = TAnimationLoaderWidget(
                    text: 'Whoops! Wishlist is Empty...',
                    animation: TImages.successfullyRegisterAnimation,
                    showAction: true,
                    actionText: 'Let\'s add some',
                    onActionPressed: () => Get.offAll(() => const NavigationMenu()),
                  );

                  const loader = TVerticalProductShimmer(itemCount: 6);
                  final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader, nothingFound: emptyWidget);
                  if (widget != null) return widget;

                  final products = snapshot.data!;
                  return TGridLayout(
                      itemCount: products.length,
                      itemBuilder: (_, index) => TProductCardVertical(product: products[index]));


                }
              ),
            ),
        ),
      ),

    );
  }
}
