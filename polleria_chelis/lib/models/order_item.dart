import 'package:polleria_chelis/models/products.dart';

class OrderItem{
  Products product;
  int quantity;

  //ATTRIBUTES NAMES
  static const String PRODUCTS = "products";
  static const String QUANTITY = "quantity";

  OrderItem({required this.quantity, required this.product});


  static OrderItem? fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return OrderItem(
      quantity: map[QUANTITY], product: Products.fromJson(map[PRODUCTS]),
    );
  }

  static List<OrderItem> fromArray(var map) {
    List<OrderItem> list =[];
    if (map == null) return list;

    for (var i=0; i<map.length; i++) {
      OrderItem summaryItem = OrderItem.fromJson(map[i]);
      list.add(summaryItem);
    }
    return list;
  }

  OrderItem.fromJson(Map<String, dynamic> json)
      : product = Products.fromJson(json['product']),
        quantity = json['quantity'];

  Map<String, dynamic> toMap() => {
    'product': product.toMap(),
    'quantity': quantity,
  };
}