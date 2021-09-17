import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polleria_chelis/models/stores.dart';

import 'enum/shipping_methods.dart';

class Shipping{
  ShippingMethods shippingMethods;
  GeoPoint? address;
  Stores? store;
  String? paymentMethod;
  double? cashDenomination;

  Shipping(this.shippingMethods, this.address, this.store, this.paymentMethod, this.cashDenomination);

  //ATTRIBUTES NAMES
  static const String SHIPPING_METHOD = "shippingMethods";
  static const String ADDRESS = "address";
  static const String STORE = "store";
  static const String PAYMENT_METHOD = "paymentMethod";
  static const String CASH_DENOMINATION = "cashDenomination";

  Shipping.fromJson(Map<String, dynamic> json)
      : shippingMethods = ShippingMethodsExtension.fromString(json[Shipping.SHIPPING_METHOD]),
        address = json[Shipping.ADDRESS],
        store = json[Shipping.STORE] == null ? null :Stores.fromJson(json[Shipping.STORE]),
        paymentMethod = json[Shipping.PAYMENT_METHOD],
        cashDenomination = json[Shipping.CASH_DENOMINATION];

  Map<String, dynamic> toMap() => {
    Shipping.SHIPPING_METHOD: shippingMethods.method,
    Shipping.ADDRESS: address,
    Shipping.STORE: store != null ? store!.toMap() : null,
    Shipping.PAYMENT_METHOD: paymentMethod,
    Shipping.CASH_DENOMINATION: cashDenomination,
  };

}