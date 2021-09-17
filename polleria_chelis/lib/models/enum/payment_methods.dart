enum PaymentMethods { CASH, TPV }

extension PaymentMethodsExtension on PaymentMethods {

  String get method {
    switch (this) {
      case PaymentMethods.CASH:
        return 'Efectivo';
      case PaymentMethods.TPV:
        return 'Terminal';
      default:
        return 'null';
    }
  }

  static PaymentMethods fromString(String value){
    switch (value) {
      case 'Efectivo':
        return PaymentMethods.CASH;
      case 'Terminal':
        return PaymentMethods.TPV;
      default:
        return PaymentMethods.CASH;
    }
  }
}