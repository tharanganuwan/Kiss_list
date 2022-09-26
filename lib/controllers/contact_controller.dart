import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kiss_list/model/contact_model.dart';
import 'package:logger/logger.dart';

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
  ) async {
    //upload the image task

    // UploadTask? task = uploadFile(img);
    // final snapshot = await task!.whenComplete(() {});
    // final downloadUrl = await snapshot.ref.getDownloadURL();
    // Logger().i(downloadUrl);

    //get the unique document id auto genrator
    String docId = contactDetails.doc().id;

    await contactDetails.doc(docId).set({
      'name': name,
      'gender': gender,
      'age': age,
      'uid': date,
      'notices': notices,
      'about': about,
      'rating': rating
    });
  }
  //get user data
  // Future<ContactModel?> getUserdata(String id) async {
  //   try {
  //     DocumentSnapshot snapshot = await contactDetails.doc(id).get();
  //     Logger().i(snapshot.data());
  //     ContactModel contactModel =
  //         ContactModel.fromMap(snapshot.data() as Map<String, dynamic>);
  //     Logger().d(contactModel.name);
  //     return contactModel;
  //   } catch (e) {
  //     Logger().e(e);
  //   }
  // }
}
