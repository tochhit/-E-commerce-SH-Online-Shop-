import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/appbar/tabbar.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ecommerce/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce/common/widgets/shimmers/brands_shimmer.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/controllers/brand_controller.dart';
import 'package:ecommerce/features/shop/controllers/category_controlleer.dart';
import 'package:ecommerce/user_no_login/screen/products_cards/u_category_tab.dart';
import 'package:ecommerce/user_no_login/screen/u_all_product.dart';
import 'package:ecommerce/user_no_login/screen/u_brand_products.dart';
import 'package:ecommerce/user_no_login/screen/u_cart_menu_icon.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/brands/brand_card.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../features/shop/controllers/product/product_controller.dart';
import '../u_all_brand.dart';


class UStoreScreen extends StatelessWidget {
  const UStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = Get.put(BrandController());
    final categories = CategoryController.instance.featuredCategories;
    final controller = Get.put(ProductController());

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        /// Appbar
        appBar: TAppBar(
          title: Text('Store', style: Theme.of(context).textTheme.headlineMedium,),
          actions: const [UCartCounterIcon()],
        ),
        body: NestedScrollView(
          /// Header
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                expandedHeight: 440,
                automaticallyImplyLeading: false,
                backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.black : TColors.white,

                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      /// -- Search bar
                      const SizedBox(height: TSizes.spaceBtwItems),
                      TSearchContainer(
                        text: 'Search in Store', showBorder: true, showBackground: false, padding: EdgeInsets.zero, onTap: () {
                        // Navigate to AllProducts screen when TSearchContainer is tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UAllProducts(title: 'Search Results', futureMethod: controller.fetchAllFeaturedProducts())),
                        );
                      },),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      /// -- Featured Brands
                      TSectionHeading(title: 'Featured Brands', onPressed: () => Get.to(() => const UAllBrandsScreen())),
                      const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                      /// Brands GRID
                      Obx(
                            () {
                          if(brandController.isLoading.value) return const TBrandsShimmer();

                          if (brandController.featuredBrands.isEmpty) {
                            return Center(
                                child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)));
                          }

                          return TGridLayout(
                            itemCount: brandController.featuredBrands.length,
                            mainAxisExtent: 80,
                            itemBuilder: (_, index) {
                              final brand = brandController.featuredBrands[index];
                              return TBrandCard(showBorder: true, brand: brand, onTap: () => Get.to(() => UBrandProducts(brand: brand)));
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                /// Tabs
                bottom: TTabBar(tabs: categories.map((category) => Tab(child: Text(category.name))).toList()),
              ),
            ];
          }, body: TabBarView(
            children: categories.map((category) => UCategoryTab(category: category)).toList()
        ),
        ),
      ),
    );
  }
}





