
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/utils/constants/enums.dart';
import 'package:ecommerce/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce/utils/exceptions/firebase_storage_service.dart';
import 'package:ecommerce/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/product_model.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  /// FireStore instance for database interactions.
  final _db = FirebaseFirestore.instance;

  /// Get limited featured products
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db.collection('Products').where('IsFeatured', isEqualTo: true).limit(4).get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get limited featured products
  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final snapshot = await _db.collection('Products').where('IsFeatured', isEqualTo: true).get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }



  /// Get Product based on the Brand
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs.map((doc) => ProductModel.fromQuerySnapshot(doc)).toList();
      return productList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }


  /// Upload dummy data to the Cloud Firebase
  Future<void> uploadDummyData(List<ProductModel> products) async {
    try {
      // Upload all the products along with their images
      final storage = Get.put(TFirebaseStorageService());

      // Loop through each product
      for (var product in products) {
        // Get image data link from local assets
        final thumbnail = await storage.getImageDataFromAssets(product.thumbnail);

        // Upload image and get its URL
        final url = await storage.uploadImageData('Products/Images', thumbnail, product.thumbnail.toString());

        // Assign URL to product.thumbnail attribute
        product.thumbnail = url;

        // Product list of images
        if (product.images != null && product.images!.isNotEmpty) {
          List<String> imagesUrl = [];
          for (var image in product.images!) {
            // Get image data link
            final assetImage = await storage.getImageDataFromAssets(image);

            // Upload image and get its URL
            final url = await storage.uploadImageData('Products/Images', assetImage, image);

            // Assign URL to product.thumbnail attribute
            imagesUrl.add(url);
          }
          product.images!.clear();
          product.images!.addAll(imagesUrl);
        }

        // Upload Variation Images
        if (product.productType == ProductType.variable.toString()) {
          for (var variation in product.productVariations!) {
            // Get image data link from local assets
            final assetImage = await storage.getImageDataFromAssets(variation.image);

            // Upload image and get its URL
            final url = await storage.uploadImageData('Products/Images', assetImage, variation.image);

            // Assign URL to variation.image attribute
            variation.image = url;

          }
        }

        // Store product in FireStore
        await _db.collection('Products').doc(product.id).set(product.toJson());
      }
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }


  }

}