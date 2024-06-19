import 'package:ecommerce/user_no_login/screen/u_cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../features/shop/screens/cart/cart.dart';
import '../../../../utils/helpers/helper_functions.dart';

class UCartCounterIcon extends StatefulWidget {
  const UCartCounterIcon({
    Key? key,
    this.iconColor,
    this.counterBgColor,
    this.counterTextColor,
  }) : super(key: key);

  final Color? iconColor, counterBgColor, counterTextColor;

  @override
  _UCartCounterIconState createState() => _UCartCounterIconState();
}

class _UCartCounterIconState extends State<UCartCounterIcon> {
  int _cartItemCount = 0; // Local state for cart item count

  void _updateCartItemCount() {
    // Replace with your logic to fetch cart item count
    // Example: Fetch from local storage, API, etc.
    setState(() {
      // Example: Setting a dummy value
      _cartItemCount = 0; // Replace with actual logic to fetch cart count
    });
  }

  @override
  void initState() {
    super.initState();
    _updateCartItemCount(); // Initialize or fetch cart item count on widget initialization
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Stack(
      children: [
        IconButton(
          onPressed: () => Get.to(() => const UCartScreen()),
          icon: Icon(Iconsax.shopping_bag, color: widget.iconColor),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: widget.counterBgColor ?? (dark ? TColors.white : TColors.black),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                _cartItemCount.toString(),
                style: Theme.of(context).textTheme.subtitle2!.apply(
                  color: widget.counterTextColor ?? (dark ? TColors.black : TColors.white),
                  fontSizeFactor: 0.8,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
