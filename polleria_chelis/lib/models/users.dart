import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String phoneNumber;
  String email;
  String name;
  String lastName;
  String birthDate;
  String gender;
  String rol;

  //COLLECTION NAME
  static const String COLLECTION_NAME = "users";

  //ATTRIBUTES NAMES
  static const String PHONENUMBER = "phoneNumber";
  static const String ROL = "rol";
  static const String EMAIL = "email";
  static const String NAME = "name";
  static const String LASTNAME = "lastName";
  static const String BIRTHDATE = "birthDate";
  static const String GENDER = "gender";

  Users(this.phoneNumber, this.email, this.name, this.lastName, this.birthDate,
      this.gender, this.rol);

  Users.fromJson(Map<String, dynamic> json)
      : phoneNumber = json[Users.PHONENUMBER],
        email = json[Users.EMAIL],
        name = json[Users.NAME],
        lastName = json[Users.LASTNAME],
        birthDate = json[Users.BIRTHDATE],
        gender = json[Users.GENDER],
        rol = json[Users.ROL];

  Map<String, dynamic> toMap() => {
        Users.PHONENUMBER: phoneNumber,
        Users.EMAIL: email,
        Users.NAME: name,
        Users.LASTNAME: lastName,
        Users.BIRTHDATE: birthDate,
        Users.GENDER: gender,
        Users.ROL: rol
      };

  static Future<void> saveUser(Users user) {
    CollectionReference users =
        FirebaseFirestore.instance.collection(Users.COLLECTION_NAME);
    return users
        .add(user.toMap())
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  static Future<Users?> getUserByPhoneNumber(String phoneNumber) async {
    /*try {
      QuerySnapshot postDocuments = await FirebaseFirestore.instance
          .collection(Users.COLLECTION_NAME)
          .where(Users.PHONENUMBER, isEqualTo: phoneNumber)
          .get();
      if (postDocuments.docs.isNotEmpty) {
        return postDocuments.docs
            .map((snapshot) => Users.fromJson(snapshot.data() as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      print(e);
      return e.toString();
    }*/

    try {
      QuerySnapshot postDocuments = await FirebaseFirestore.instance
          .collection(Users.COLLECTION_NAME)
          .where(Users.PHONENUMBER, isEqualTo: phoneNumber)
          .get();
      if (postDocuments.docs.isNotEmpty) {
        DocumentSnapshot doc = postDocuments.docs.first;
        Users user = Users.fromJson(doc.data() as Map<String, dynamic>);
        return user;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future updateUser(String phoneNumber, Users userUpdate) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(Users.COLLECTION_NAME)
        .where(Users.PHONENUMBER, isEqualTo: phoneNumber)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      QueryDocumentSnapshot queryDocumentSnapshot = querySnapshot.docs[0];
      DocumentReference documentReference = queryDocumentSnapshot.reference;
      await documentReference.update(userUpdate.toMap());
    }
  }

  static Future<bool> existeUser(String phoneNumber) async {
    try {
      QuerySnapshot postDocuments = await FirebaseFirestore.instance
          .collection(Users.COLLECTION_NAME)
          .where(Users.PHONENUMBER, isEqualTo: phoneNumber)
          .get();
      if (postDocuments.docs.isNotEmpty) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> isAdminUser(String phoneNumber) async {
    try {
      QuerySnapshot postDocuments = await FirebaseFirestore.instance
          .collection(Users.COLLECTION_NAME)
          .where(Users.PHONENUMBER, isEqualTo: phoneNumber)
          .get();
      if (postDocuments.docs.isNotEmpty) {
        DocumentSnapshot doc = postDocuments.docs.first;
        Users user = Users.fromJson(doc.data() as Map<String, dynamic>);

        if (user.rol == 'ADMIN') {
          return true;
        } else {
          return false;
        }
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
