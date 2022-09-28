import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kiss_list/model/contact_model.dart';
import 'package:kiss_list/providers/contact_provider.dart';
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

  //fetch contacts by the  id
  Future<List<ContactModel>> getContacts() async {
    List<ContactModel> list = [];
    try {
      // FirebaseFirestore.instance
      //     .collection('contactDetails')
      //     .get()
      //     .then((QuerySnapshot querySnapshot) {
      //   querySnapshot.docs.forEach((doc) {
      //     print(doc.data());
      //     Logger().i(doc.data());
      //   });
      // });

      //guery for fetch resturent products
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('contactDetails')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          print(doc.data());
          Logger().i(doc.data());
          ContactModel model =
              ContactModel.fromMap(item.data() as Map<String, dynamic>);
        });
      });
      //querying all the docs in this snapshot
      for (var item in snapshot.docs) {
        //mapping to a single model
        ContactModel model =
            ContactModel.fromMap(item.data() as Map<String, dynamic>);
        list.add(model);

        Logger().i(snapshot.docs);
      }
      //returning the list
      return list;
    } catch (e) {
      Logger().e(e);
      return list;
    }
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
}
