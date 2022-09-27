import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kiss_list/model/contact_model.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';

class ContactController {
  //Firestore instance create
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //create a collection reference
  CollectionReference contactDetails =
      FirebaseFirestore.instance.collection('contactDetails');
  //save user contact information

  Future<void> saveContactDetails(
      String name,
      String gender,
      String age,
      String date,
      String notices,
      String about,
      String rating,
      File img) async {
    //upload the image task

    UploadTask? task = uploadFile(img);
    final snapshot = await task!.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();
    Logger().i(downloadUrl);

    //get the unique document id auto genrator
    String docId = contactDetails.doc().id;

    await contactDetails.doc(docId).set({
      'name': name,
      'gender': gender,
      'age': age,
      'date': date,
      'notices': notices,
      'about': about,
      'rating': rating,
      'img': downloadUrl
    });
  }

  // uplod image to db
  UploadTask? uploadFile(File file) {
    try {
      final fileName = basename(file.path);
      final destination = 'resImages/$fileName';
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  //get user data
  Future<ContactModel?> getContactDetails(String id) async {
    try {
      DocumentSnapshot snapshot = await contactDetails.doc(id).get();
      Logger().i(snapshot.data());
      ContactModel contactModel =
          ContactModel.fromJson(snapshot.data() as Map<String, dynamic>);
      Logger().d(contactModel.name);
      return contactModel;
    } catch (e) {
      Logger().e(e);
    }
  }
}
