enum ShippingMethods { DELIVERY, IN_STORE }

extension ShippingMethodsExtension on ShippingMethods {

  String get method {
    switch (this) {
      case ShippingMethods.DELIVERY:
        return 'Domicilio';
      case ShippingMethods.IN_STORE:
        return 'Tienda';
      default:
        return 'null';
    }
  }

  static String toText(ShippingMethods shippingMethods) {
    switch (shippingMethods) {
      case ShippingMethods.DELIVERY:
        return 'Domicilio';
      case ShippingMethods.IN_STORE:
        return 'Tienda';
      default:
        return 'null';
    }
  }

  static ShippingMethods fromString(String value){
    switch (value) {
      case 'Domicilio':
        return ShippingMethods.DELIVERY;
      case 'Tienda':
        return ShippingMethods.IN_STORE;
      default:
        return ShippingMethods.IN_STORE;
    }
  }
}