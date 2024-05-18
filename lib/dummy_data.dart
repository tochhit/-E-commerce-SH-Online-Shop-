import 'package:ecommerce/features/shop/models/banner_model.dart';
import 'package:ecommerce/routes/routes.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';

import 'features/shop/models/category_model.dart';

class TDummyData {

  /// Banners
  static final List<BannerModel> banners = [
    BannerModel(imageUrl: TImages.promoBanner1, targetScreen: TRoutes.store, active: false),
    BannerModel(imageUrl: TImages.promoBanner2, targetScreen: TRoutes.cart, active: true),
    BannerModel(imageUrl: TImages.promoBanner3, targetScreen: TRoutes.favourites, active: true),
  ];



  /// List of all Categories
  static final List<CategoryModel> categories = [
    CategoryModel(id: '1', name: 'Shoes', image: TImages.shoeIcon , isFeatured: true),
    CategoryModel(id: '2', name: 'Clothing', image: TImages.clothIcon , isFeatured: true),
  ];

 }