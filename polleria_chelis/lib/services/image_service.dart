
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ImageService{

  Future<Widget> getImage(String image) async {
    var ref = FirebaseStorage.instance.ref().child(image);
    String url = (await ref.getDownloadURL()).toString();
    return Image.network(url, fit: BoxFit.scaleDown);
  }

  Future<dynamic> loadImage(String image) async {
    try {
      return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
    }catch (e){
      print("Error al cargar imagenes...!!!");
      print(e.toString());
    }
  }
}