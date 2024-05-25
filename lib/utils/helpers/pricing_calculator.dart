class TPricingCalcutator {
  static double calculateTotalPrice(double subTotal, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = subTotal * taxRate;

    double shippingCost = getShippingCost(location);

    double totalPrice = subTotal + taxAmount + shippingCost;
    return totalPrice;

  }

  /// -- Calculate shipping cost
  static String calculateShippingCost(double subTotal, String location) {
    double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }


  /// -- Calculate tax
  static String calculateTax(double subTotal, String location) {
    double texRate = getTaxRateForLocation(location);
    double taxAmount = subTotal * texRate;
    return taxAmount.toStringAsFixed(2);
  }

  static double getTaxRateForLocation(String location) {
    return 0.10;
  }

  static double getShippingCost(String location) {
    return 5.00;
  }

  /// Sum all cart values and return total amount
  // static double calculateCartTotal (CartModel cart) {
  //    return cart.items.map((e) => e.price).fold(0, (previousPrice, currentPrice) => previousPrice + (currentPrice ?? 0))
  //  }

}