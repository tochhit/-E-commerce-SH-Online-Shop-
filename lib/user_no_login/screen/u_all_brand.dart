import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/brands/brand_card.dart';
import 'package:ecommerce/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/controllers/brand_controller.dart';
import 'package:ecommerce/user_no_login/screen/u_brand_product.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/shimmers/brands_shimmer.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';

class UAllBrandsScreen extends StatefulWidget {
  const UAllBrandsScreen({super.key});

  @override
  _UAllBrandsScreenState createState() => _UAllBrandsScreenState();
}

class _UAllBrandsScreenState extends State<UAllBrandsScreen> {
  late TextEditingController _searchController;
  final BrandController _brandController = BrandController.instance;
  bool _isSearchFocused = false; // Track if search bar is focused

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(_onSearchFocusChanged); // Listen for changes in search bar focus
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchFocusChanged() {
    setState(() {
      _isSearchFocused = _searchController.text.isNotEmpty; // Update _isSearchFocused based on search input
    });
  }

  void _clearSearch() {
    _searchController.clear();
    _onSearchFocusChanged();
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: const TAppBar(title: Text('Brand'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Search Bar
              TextField(
                controller: _searchController,
                onChanged: (value) => _onSearchFocusChanged(),
                decoration: InputDecoration(
                  labelText: 'Search Brands',
                  labelStyle: TextStyle(color: dark ? TColors.grey : TColors.grey),
                  prefixIcon: const Icon(Iconsax.search_normal),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: _clearSearch,
                  )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Heading
              const TSectionHeading(title: 'Brands', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Brands
              Obx(() {
                if (_brandController.isLoading.value) return const TBrandsShimmer();

                if (_brandController.allBrands.isEmpty) {
                  return Center(
                    child: Text(
                      'No Data Found!',
                      style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),
                    ),
                  );
                }

                // Filtered list of brands
                final filteredBrands = _brandController.allBrands.where((brand) {
                  final query = _searchController.text.toLowerCase();
                  final brandName = brand.name.toLowerCase();
                  return brandName.contains(query);
                }).toList();

                return TGridLayout(
                  itemCount: filteredBrands.length,
                  mainAxisExtent: 80,
                  itemBuilder: (_, index) {
                    final brand = filteredBrands[index];
                    return TBrandCard(
                      showBorder: true,
                      brand: brand,
                      onTap: () => Get.to(() => UBrandProducts(brand: brand)),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
