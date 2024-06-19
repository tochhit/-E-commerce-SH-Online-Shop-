import 'package:ecommerce/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:ecommerce/features/shop/controllers/product/product_controller.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:ecommerce/user_no_login/screen/products_cards/u_product_card_vertical.dart';
import 'package:ecommerce/user_no_login/screen/u_all_product.dart';
import 'package:ecommerce/user_no_login/screen/u_home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../u_home_categories.dart';

class UHomeScreen extends StatelessWidget {
  const UHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            TPrimaryHeaderContainer(
                child: Column(
                  children: [
                    /// Appbar
                    const UHomeAppBar(),
                    const SizedBox(height: TSizes.spaceBtwSections /2),

                    /// Searchbar
                    TSearchContainer(text: 'Search in Store', showBorder: false, onTap: () {
                      // Navigate to AllProducts screen when TSearchContainer is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UAllProducts(title: 'Search Results', futureMethod: controller.fetchAllFeaturedProducts())),
                      );
                    },),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    /// Categories
                    const Padding(
                      padding: EdgeInsets.only(left: TSizes.defaultSpace),
                      child: Column(
                        children: [
                          /// Heading
                          TSectionHeading(title: 'Popular Categories', showActionButton: false, textColor: Colors.white),
                          SizedBox(height: TSizes.spaceBtwItems),

                          /// Categories
                          UHomeCategories(),
                        ],
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),
                  ],
                )
            ),
            /// Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// Promo Slider
                  const TPromoSlider(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// -- Heading
                  TSectionHeading(
                      title: 'Popular Products',
                      onPressed: () => Get.to(
                              () => UAllProducts(
                            title: 'Popular Products',
                            futureMethod: controller.fetchAllFeaturedProducts(),
                          ))),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// Popular Products
                  Obx((){
                    if(controller.isLoading.value) return const TVerticalProductShimmer();

                    if(controller.featuredProducts.isEmpty) {
                      return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium));
                    }

                    return TGridLayout(
                      itemCount: controller.featuredProducts.length,
                      itemBuilder: (_, index) => UProductCardVertical(product: controller.featuredProducts[index]),
                    );
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}