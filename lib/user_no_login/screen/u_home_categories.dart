import 'package:ecommerce/common/widgets/shimmers/category_shimmer.dart';
import 'package:ecommerce/features/shop/controllers/category_controlleer.dart';
import 'package:ecommerce/user_no_login/screen/screen/u_sub_categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/image_text_widgets/vertical_image_text.dart';

class UHomeCategories extends StatelessWidget {
  const UHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return Obx(
            () {
          if(categoryController.isLoading.value) return const TCategoryShimmer();

          if(categoryController.featuredCategories.isEmpty) {
            return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)));
          }

          return SizedBox(
            height: 80,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: categoryController.featuredCategories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                final category = categoryController.featuredCategories[index];
                return TVerticalImageText(
                  image: category.image,
                  title: category.name,
                  onTap: () => Get.to(() => USubCategoriesScreen(category: category)),
                );
              },
            ),
          );
        }
    );
  }
}