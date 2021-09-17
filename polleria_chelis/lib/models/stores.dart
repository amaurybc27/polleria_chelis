import 'package:cloud_firestore/cloud_firestore.dart';

class Stores{
  String address;
  String name;
  String id;
  List<dynamic> schedule = [];

  //COLLECTION NAME
  static const String COLLECTION_NAME = "stores";

  //ATTRIBUTES NAMES
  static const String ADDRESS = "address";
  static const String NAME = "name";
  static const String ID = "id";
  static const String SCHEDULE = "schedule";

  Stores(this.id, this.name, this.address, this.schedule);

  static Future getStores() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      QuerySnapshot postDocuments = await firestore.collection(Stores.COLLECTION_NAME).get();
      if (postDocuments.docs.isNotEmpty) {
        return postDocuments.docs
            .map((snapshot) => Stores.fromJson(snapshot.data() as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      print("Error on get Stores ");
      print(e);
      return e.toString();
    }
  }


  Stores.fromJson(Map<String, dynamic> json)
      : address = json[Stores.ADDRESS],
        name = json[Stores.NAME],
        id = json[Stores.ID],
        schedule = json[Stores.SCHEDULE];

  Map<String, dynamic> toMap() => {
    Stores.ADDRESS: address,
    Stores.NAME: name,
    Stores.ID: id,
    Stores.SCHEDULE: schedule,
  };
}