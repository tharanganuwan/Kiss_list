import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kiss_list/controllers/contact_controller.dart';
import 'package:kiss_list/model/contact_model.dart';
import 'package:kiss_list/screens/home_screen.dart';
import 'package:kiss_list/utills/util_functions.dart';
import 'package:logger/logger.dart';

import 'dart:io';

import '../components/custom_dialog.dart';

class ContactProvider extends ChangeNotifier {
  //resturent controller
  final ContactController _contactController = ContactController();
//image picker
  final ImagePicker _picker = ImagePicker();

  File _image = File("");

  var _isObscure = true;
  final _name = TextEditingController();
  final _gender = TextEditingController();
  final _age = TextEditingController();
  final _date = TextEditingController();
  final _notices = TextEditingController();
  final _about = TextEditingController();
  final _rating = TextEditingController();
  bool _isLoading = false;

//get obscure state
  bool get isObscure => _isObscure;

//get loading state
  bool get isLoading => _isLoading;

  //get firstname controller
  TextEditingController get nameController => _name;

  //get lastname controller
  TextEditingController get genderController => _gender;

  //get email controller
  TextEditingController get ageController => _age;

  //get password controller
  TextEditingController get dateController => _date;

  //get lastname controller
  TextEditingController get noticesController => _notices;

  //get email controller
  TextEditingController get aboutController => _about;

  //get password controller
  TextEditingController get ratingController => _rating;

  //change obscure state
  void changeObscure() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  //get image file
  File get getImg => _image;

  List<ContactModel> _contactModel = [];

  List<ContactModel> get contactModel => _contactModel;

  //validation function

  bool inputValidation() {
    var isValid = false;
    if (_name.text.isEmpty) {
      isValid = false;
    } else {
      isValid = true;
    }
    return isValid;
  }

  Future<void> startAddContactDetails(BuildContext context) async {
    try {
      if (inputValidation()) {
        setLoading(true);
        await _contactController
            .saveContactDetails(
          _name.text,
          _gender.text,
          _age.text,
          _date.text,
          _notices.text,
          _about.text,
          _rating.text,
          _image,
        )
            .whenComplete(() {
          // UserProvider().fetchSingleUser(
          //   AuthController().userCredential2.user!.uid.toString(),
          // );

          CustomAwesomDialog().dialogBox(context, "Success...!",
              "Congratulations...! Successfully added.", DialogType.SUCCES);

          Future.delayed(Duration(seconds: 5), () {
            UtilFunctions.pushRemoveNavigator(context, HomeScreen());
          });
        });
        ;
        setLoading();
      } else {
        CustomAwesomDialog().dialogBox(
            context, "Error!", "Please check fields.", DialogType.SUCCES);
      }
    } catch (e) {
      setLoading();
      Logger().e(e);
    }
  }

  //change loading state
  void setLoading([bool val = false]) {
    _isLoading = val;
    notifyListeners();
  }

//function to pick image from gallery
  Future<void> selectImage() async {
    try {
      // Pick an image
      final XFile? pickFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickFile != null) {
        _image = File(pickFile.path);
        Logger().w(_image.path);
        notifyListeners();
      } else {
        Logger().e("No Image Selected");
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  void setImage(String a, ContactModel model) {
    model.img = a;
    // model.fname = _fNameController.text;
    // model.lname = _lNameController.text;
    // model.email = _emailController.text;
    // model.occupation = _occupationController.text;
    // model.status = _statusController.text;
    loding = false;
    notifyListeners();
  }
  //fetch product by resturent id
  // Future<void> fetchContactsById() async {
  //   try {
  //     _contactModel.clear();
  //     // setLoading(true);
  //     await _contactController.getContacts().then((value) {
  //       _contactModel = value;

  //       // for (var i = 0; i < value.length; i++) {
  //       //   _minproductsList.add(value[i]);
  //       //   if (i == 2) break;
  //       // }

  //       Logger().w(_contactModel.length);
  //       Logger().i(contactModel[2].id);

  //       //  setLoading();
  //       notifyListeners();
  //     });
  //   } catch (e) {
  //     Logger().e(e);
  //     //setLoading();
  //   }
  // }

  // //change loading state
  // void setLoading([bool val = false]) {
  //   _isLoading = val;
  bool loding = false;
  Future<void> updateUser(BuildContext context) async {
    loding = true;
    try {
      _contactController.updateContact(
        _name.text,
        _gender.text,
        _age.text,
        _date.text,
        _notices.text,
        _about.text,
        _rating.text,
        _image,
      );

      notifyListeners();
    } catch (e) {}
  }

  // void setImage(String a, UserModel model) {
  //   model.img = a;
  //   // model.fname = _fNameController.text;
  //   // model.lname = _lNameController.text;
  //   // model.email = _emailController.text;
  //   // model.occupation = _occupationController.text;
  //   // model.status = _statusController.text;
  //   loding = false;
  //   notifyListeners();
  // }
  // Future<void> deleteUser(String id) async {

  //   try {
  //     _contactController.deleteContact(

  //     );

  //     notifyListeners();
  //   } catch (e) {}
  // }
}
