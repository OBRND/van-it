import 'dart:io' as io;
import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
class Storage{

  final FirebaseStorage storage = FirebaseStorage.instance;

  Future uploadfile(File fileselected, String uid) async{
    File file = fileselected;
    try{
      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': fileselected.path},
      );
      final ref = await storage.ref().child('profile/$uid');
      ref.putFile(File(fileselected.path), metadata);
    } on FirebaseException catch(e){
      print(e);
    }
  }
  Future uploadfilechat(File fileselected, String uid) async{
    File file = fileselected;
    try{
      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': fileselected.path},
      );
      final ref = await storage.ref().child('Chats/$uid');
      ref.putFile(File(fileselected.path), metadata);
    } on FirebaseException catch(e){
      print(e);
    }
  }
  Future getImage(String uid) async{
    final result = await storage.ref(
        'profile/$uid');
    // result.items.forEach((Reference ref) {
    //   print('found file: $ref');
    // });
    print(result.name);
    return result.name;
  }
  Future getdata(String uid) async{
    // String name = await getImage(tradesID);
    String downloadUrL = await storage.ref('profile/$uid').getDownloadURL();
    print(downloadUrL);
    return downloadUrL;
  }


}