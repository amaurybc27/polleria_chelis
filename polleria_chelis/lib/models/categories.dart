import 'package:cloud_firestore/cloud_firestore.dart';

/**
 * El name de la categoria es necesario para poder mostrar el listado de productos por categoria
 * La photo de la categoria es opcional y es la url de firebase storage
 * El color de la categoria es opcional, actualmente no se ocupa
 */
class Categories {
  String name;
  String photo;
  String color;

  //Collention nam
  static const String COLLECTION_NAME = "categories";
  //Attributes names
  static const String NAME = "name";
  static const String PHOTO = "photo";
  static const String COLOR = "color";

  Categories(this.name, this.photo, this.color);

  Categories.fromJson(Map<String, dynamic> json)
      : name = json[Categories.NAME],
        photo = json[Categories.PHOTO],
        color = json[Categories.COLOR];

  Map<String, dynamic> toMap() => {
    Categories.NAME: name,
    Categories.PHOTO: photo,
    Categories.COLOR: color,
  };

  static Future getCategories() async {
    try {
      QuerySnapshot postDocuments = await FirebaseFirestore.instance.collection(Categories.COLLECTION_NAME).get();
      if (postDocuments.docs.isNotEmpty) {
        return postDocuments.docs
            .map((snapshot) => Categories.fromJson(snapshot.data() as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
}