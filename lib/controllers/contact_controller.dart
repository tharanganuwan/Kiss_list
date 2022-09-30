import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:kiss_list/model/contact_model.dart';
import 'package:kiss_list/providers/contact_provider.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';

import '../components/custom_dialog.dart';
import '../screens/home_screen.dart';
import '../utills/util_functions.dart';

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
      'img': downloadUrl,
      'id': docId
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

  // Future<List<ContactModel>> getContactsss() async {
  //   List<ContactModel> list = [];

  //   //guery for fetch resturent products
  //   // QuerySnapshot snapshot = await contactDetails.get();
  //   // //querying all the docs in this snapshot
  //   // for (var item in snapshot.docs) {
  //   //   //mapping to a single model
  //   //   ContactModel model =
  //   //       ContactModel.fromMap(item.data() as Map<String, dynamic>);
  //   //   list.add(model);

  //   //   Logger().i(snapshot.docs);
  //   firestore.collection('collection').snapshots().map((snapshot) =>
  //       snapshot.docs.map((e) => ContactModel.fromMap(e.data())).toList());

  //   //returning the list

  //   return list;
  // }
  Stream<List<ContactModel>> getAContactFromFirebase() {
    Stream<List<ContactModel>> l = firestore
        .collection('contactDetails')

        //.orderBy('publishedDate', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((e) => ContactModel.fromMap(e.data())).toList());

    return l;
  }

  //update user address
  Future<void> updateUser(ContactModel model) async {
    return contactDetails
        .doc(model.id)
        .set(model.toMap())
        .then((value) => Logger().i("User updated"))
        .catchError((error) => Logger().i("Failed to updated user:$error"));
  }

  // update user user details
  Future<void> updateContact(
    String name,
    String gender,
    String age,
    String date,
    String notices,
    String about,
    String rating,
    File img,
  ) async {
    //upload the image task

    UploadTask? task = uploadFile(img);
    final snapshot = await task!.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();
    Logger().i(downloadUrl);

    String docId = contactDetails.doc().id;
    Logger().i(docId);

    await contactDetails.doc(contactDetails.doc().id).set({
      'name': name,
      'gender': gender,
      'age': age,
      'date': date,
      'notices': notices,
      'about': about,
      'rating': rating,
      'img': downloadUrl
    }).then((value) {
      print("user update sussessful!");
      // ContactProvider().setImage(downloadUrl.toString(), model);
    }).catchError((error) => print("Failed to update: $error"));
  }

  //get user data
  Future<ContactModel?> getContactDetails(String id) async {
    try {
      DocumentSnapshot snapshot = await contactDetails.doc(id).get();
      Logger().i(snapshot.data());
      ContactModel contactModel =
          ContactModel.fromMap(snapshot.data() as Map<String, dynamic>);
      Logger().d(contactModel.name);
      return contactModel;
    } catch (e) {
      Logger().e(e);
    }
  }

  //delete
  Future<void> deleteContact(String id) async {
    firestore.collection('contactDetails').doc(id).delete();
  }
}
