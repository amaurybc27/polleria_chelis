import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polleria_chelis/models/shipping.dart';
import 'package:polleria_chelis/models/order_item.dart';

import 'enum/order_status.dart';

class Orders{
  String? id;
  String userPhoneNumber;
  String userName;
  double subtotal;
  double total;
  String status;
  double shippingPrice;
  Timestamp creationDate;
  List<OrderItem> products = [];
  Shipping shipping;

  Orders(this.userPhoneNumber, this.userName, this.subtotal, this.total, this.status, this.shippingPrice, this.creationDate, this.products, this.shipping);

  //COLLECTION NAME
  static const String COLLECTION_NAME = "orders";

  //ATTRIBUTES NAMES
  static const String USER_PHONE_NUMBER = "userPhoneNumber";
  static const String USER_NAME = "userName";
  static const String SUBTOTAL = "subtotal";
  static const String TOTAL = "total";
  static const String STATUS = "status";
  static const String SHIPPING_PRICE = "shippingPrice";
  static const String CREATION_DATE = "creationDate";
  static const String PRODUCTS = "products";
  static const String SHIPPING = "shipping";


  Orders.fromJson(String id, Map<String, dynamic> json)
      : id = id,
        userPhoneNumber = json[Orders.USER_PHONE_NUMBER],
        userName = json[Orders.USER_NAME],
        subtotal = json[Orders.SUBTOTAL],
        total = json[Orders.TOTAL],
        status = json[Orders.STATUS],
        shippingPrice = json[Orders.SHIPPING_PRICE],
        creationDate = json[Orders.CREATION_DATE],
        products = OrderItem.fromArray(json[Orders.PRODUCTS]),
        shipping = Shipping.fromJson(json[Orders.SHIPPING]);

  Map<String, dynamic> toMap() => {
    Orders.USER_PHONE_NUMBER : userPhoneNumber,
    Orders.USER_NAME : userName,
    Orders.SUBTOTAL: subtotal,
    Orders.TOTAL: total,
    Orders.STATUS: status,
    Orders.SHIPPING_PRICE: shippingPrice,
    Orders.CREATION_DATE: creationDate,
    Orders.PRODUCTS: products.map<Map<String, dynamic>>((item) { return item.toMap(); }).toList(),
    Orders.SHIPPING: shipping.toMap(),
  };

  static Future<void> saveOrder(Orders order) {
    CollectionReference orders = FirebaseFirestore.instance.collection(Orders.COLLECTION_NAME);
    return orders
        .add(order.toMap())
        .then((value) => print("Order Added"))
        .catchError((error) => print("Failed to add order: $error"));
  }

  static Future getOrdersByUser(String phoneNumber) async {
    try {
      QuerySnapshot postDocuments = await FirebaseFirestore.instance.collection(Orders.COLLECTION_NAME).where(Orders.USER_PHONE_NUMBER, isEqualTo: phoneNumber).orderBy(Orders.CREATION_DATE, descending: true).orderBy(Orders.STATUS, descending: true).get();
      if (postDocuments.docs.isNotEmpty) {
        return postDocuments.docs
            .map((snapshot) => Orders.fromJson(snapshot.reference.id, snapshot.data() as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      print("Error in getOrdersByUser" + e.toString());
      return e.toString();
    }
  }

  static Future getOrdersForAdminByStatus(String status) async {
    try {
      QuerySnapshot postDocuments = await FirebaseFirestore.instance.collection(Orders.COLLECTION_NAME).where(Orders.STATUS, isEqualTo: status).orderBy(Orders.CREATION_DATE, descending: true).get();
      if (postDocuments.docs.isNotEmpty) {
        return postDocuments.docs
            .map((snapshot) =>
          Orders.fromJson(
              snapshot.reference.id, snapshot.data() as Map<String, dynamic>)
            )
            .toList();
      }
    } catch (e) {
      print("Error in getOrdersByUser" + e.toString());
      return e.toString();
    }
  }

  static void updateOrderStatus(String id, String status){
    CollectionReference orders = FirebaseFirestore.instance.collection(COLLECTION_NAME);
    orders.doc(id)
        .set({STATUS: status}, SetOptions(merge: true),)
        .then((value) => print("Updated order status"))
        .catchError((error) => print("No it's possible update order status: $error"));

  }

}