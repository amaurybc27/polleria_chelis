import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

/**
 * Todos los atributos son requeridos para mostrar el detalle del producto
 *
 */
class Products {
  String? id;
  String categoriName;
  String name;
  String photo;
  double price;
  String detail;
  bool status;

  //COLLECTION NAME
  static const String COLLECTION_NAME = "products";

  //ATTRIBUTES NAMES
  static const String CATEGORI_NAME = "categoriName";
  static const String NAME = "name";
  static const String PHOTO = "photo";
  static const String PRICE = "price";
  static const String DETAIL = "detail";
  static const String STATUS = "status";

  Products(this.categoriName, this.name, this.photo, this.price, this.detail, this.status);

  Products.fromJsonWithId(String id, Map<String, dynamic> json)
      : id = id,
        categoriName = json[Products.CATEGORI_NAME],
        name = json[Products.NAME],
        photo = json[Products.PHOTO],
        price = json[Products.PRICE].toDouble(),
        detail = json[Products.DETAIL],
        status = json[Products.STATUS];

  Products.fromJson(Map<String, dynamic> json)
      : categoriName = json[Products.CATEGORI_NAME],
        name = json[Products.NAME],
        photo = json[Products.PHOTO],
        price = json[Products.PRICE].toDouble(),
        detail = json[Products.DETAIL],
        status = json[Products.STATUS];

  Map<String, dynamic> toMap() => {
    Products.CATEGORI_NAME: categoriName,
    Products.NAME: name,
    Products.PHOTO: photo,
    Products.PRICE: price,
    Products.DETAIL: detail,
    Products.STATUS: status,
  };


  static Future getMapProducts() async {
    try {
      Map<String, List<Products>> _products = new HashMap<String, List<Products>>();
      await FirebaseFirestore.instance.collection(Products.COLLECTION_NAME).where(STATUS, isEqualTo: true).get().then((querySnapshot) {
        querySnapshot.docs.forEach((document) {

          if (_products.containsKey(
              document.data()[Products.CATEGORI_NAME])) {
            List<Products>? listProducts = _products[
            document.data()[Products.CATEGORI_NAME]];

            listProducts!.add(new Products(
              document.data()[Products.CATEGORI_NAME],
              document.data()[Products.NAME],
              document.data()[Products.PHOTO],
              document.data()[Products.PRICE].toDouble(),
              document.data()[Products.DETAIL],
              document.data()[Products.STATUS],));
            _products[document
                .data()[Products.CATEGORI_NAME]] = listProducts;
          } else {
            List<Products> listProduct = [];
            listProduct.add(new Products(
              document.data()[Products.CATEGORI_NAME],
              document.data()[Products.NAME],
              document.data()[Products.PHOTO],
              document.data()[Products.PRICE].toDouble(),
              document.data()[Products.DETAIL],
              document.data()[Products.STATUS],));

            _products[document
                .data()[Products.CATEGORI_NAME]] = listProduct;
          }

        });
      });
      return _products;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  static Future getProductsForAdmin() async {
    try {
      QuerySnapshot postDocuments = await FirebaseFirestore.instance.collection(COLLECTION_NAME).orderBy(NAME, descending: true).get();
      if (postDocuments.docs.isNotEmpty) {
        return postDocuments.docs
            .map((snapshot) =>
            Products.fromJsonWithId(snapshot.reference.id, snapshot.data() as Map<String, dynamic>)
        )
            .toList();
      }
    } catch (e) {
      print("Error in getProductsForAdmin" + e.toString());
      return e.toString();
    }
  }

  static void updateProductStatusAndPriceById(String id, bool status, double price){
    CollectionReference orders = FirebaseFirestore.instance.collection(COLLECTION_NAME);
    orders.doc(id)
        .set({STATUS: status, PRICE: price}, SetOptions(merge: true),)
        .then((value) => print("Updated product"))
        .catchError((error) => print("No it's possible update the product: $error"));

  }


}