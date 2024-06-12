import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:ecommerce/features/shop/controllers/all_products_controller.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/products/sortable/sortable_products.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  late TextEditingController _searchController;
  final AllProductsController _controller = Get.put(AllProductsController());
  final List<String> _searchHistory = [];
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

  void _onSearchSubmitted(String query) {
    if (query.isNotEmpty && !_searchHistory.contains(query)) {
      setState(() {
        _searchHistory.add(query);
      });
    }
  }

  void _clearSearch() {
    _searchController.clear();
    _onSearchFocusChanged();
  }

  void _clearSearchHistory() {
    setState(() {
      _searchHistory.clear();
    });
  }

  void _removeSearchHistoryItem(String item) {
    setState(() {
      _searchHistory.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      // AppBar
      appBar: TAppBar(title: Text(widget.title), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Search Bar
              TextField(
                controller: _searchController,
                onChanged: (value) => _onSearchFocusChanged(),
                onSubmitted: _onSearchSubmitted,
                decoration: InputDecoration(
                  labelText: 'Search in Store', labelStyle: TextStyle(color: dark ? TColors.grey : TColors.grey),
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

              // Search History
              if (_isSearchFocused && _searchHistory.isNotEmpty) // Show only if actively searching
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
                            onPressed: _clearSearchHistory,
                            child: const Text('Clear All'),
                          ),
                        ],
                      ),
                      Wrap(
                        spacing: 8.0,
                        children: _searchHistory.map((item) {
                          return Chip(
                            label: Text(item),
                            deleteIcon: const Icon(Icons.close),
                            onDeleted: () => _removeSearchHistoryItem(item),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: TSizes.defaultSpace),
                    ],
                  ),
                ),

              // Product List
              FutureBuilder(
                future: widget.futureMethod ?? _controller.fetchProductsByQuery(widget.query),
                builder: (context, snapshot) {
                  // Check the state of the FutureBuilder snapshot
                  const loader = TVerticalProductShimmer();
                  final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);

                  if (widget != null) return widget;

                  // Products found!
                  final products = snapshot.data!.where((product) {
                    final query = _searchController.text.toLowerCase();
                    final productName = product.title.toLowerCase();
                    final brandName = product.brand!.name.toLowerCase(); // Get brand name
                    return productName.contains(query) || brandName.contains(query); // Search by title or brand name
                  }).toList();

                  return TSortableProducts(products: products);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
