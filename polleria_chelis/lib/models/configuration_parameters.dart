
import 'package:cloud_firestore/cloud_firestore.dart';

class ConfigurationParameters {
  //attributes in collection
  String key;
  dynamic value;

  //COLLECTION NAME
  static const String COLLECTION_NAME = "configurationParameters";

  //ATTRIBUTES NAMES
  static const String KEY = "key";
  static const String VALUE = "value";

  //keys constants
  static const sendingPrice = "sending.price";
  static const notesDenominations = "notes.denominations";

  //attribute for put configuration params (key and value)
  static var _configurationParameters = new Map();

  ConfigurationParameters(this.key, this.value);

  static init() async {
    var categories = FirebaseFirestore.instance.collection(COLLECTION_NAME);
    await categories.get()
        .then(
          (value) => {
        value.docs.forEach((element) {
          _configurationParameters[element.data()[KEY]] = element.data()[VALUE];
        },),
      },
    ).catchError((e) => print("Error fetching data configuration parameters sending price: $e"));
  }

  static dynamic getParameter(String key){
    return _configurationParameters[key];
  }
}