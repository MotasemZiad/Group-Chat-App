import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase/auth/helpers/auth_helper.dart';
import 'package:gsg_firebase/auth/helpers/firestore_helper.dart';
import 'package:gsg_firebase/auth/helpers/storage_helper.dart';
import 'package:gsg_firebase/auth/models/country_model.dart';
import 'package:gsg_firebase/auth/models/register_request.dart';
import 'package:gsg_firebase/auth/models/user_model.dart';
import 'package:gsg_firebase/auth/ui/screens/auth_main_screen.dart';
import 'package:gsg_firebase/chat/ui/screens/chat_screen.dart';
import 'package:gsg_firebase/services/route_helper.dart';
import 'package:gsg_firebase/widgets/global_widgets.dart';
import 'package:image_picker/image_picker.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    getAllCountries();
  }
  TabController tabController;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();

  List<UserModel> users = []; // List of Users (all users)
  String myId;
  getAllUsersFromFirestore() async {
    users = await FirestoreHelper.firestoreHelper.getAllUsersFromFirestore();
    users.removeWhere((element) => element.id == myId);
    notifyListeners();
  }

  UserModel user; // Single User (current user)
  getUserFromFirestore() async {
    String userId = AuthHelper.authHelper.getUserId();
    user = await FirestoreHelper.firestoreHelper.getUserFromFirestore(userId);
    notifyListeners();
  }

  List<CountryModel> countries = [];
  List<dynamic> cities = [];
  CountryModel selectedCountry;
  String selectedCity = '';

  selectCountry(CountryModel countryModel) {
    selectedCountry = countryModel;
    cities = countryModel.cities;
    selectCity(cities.first.toString());
    notifyListeners();
  }

  selectCity(dynamic city) {
    selectedCity = city;
    notifyListeners();
  }

  getAllCountries() async {
    countries =
        await FirestoreHelper.firestoreHelper.getAllCountriesFromFirestore();
    selectCountry(countries.first);
    notifyListeners();
  }

  resetController() {
    emailController.clear();
    passwordController.clear();
    fNameController.clear();
    lNameController.clear();
  }

  signup() async {
    UserCredential userCredential = await AuthHelper.authHelper
        .signup(emailController.text, passwordController.text);
    this.myId = AuthHelper.authHelper.getUserId();
    String imageUrl = await StorageHelper.storageHelper.uploadImage(file);
    final registerRequest = RegisterRequest(
      id: userCredential.user.uid,
      email: emailController.text,
      password: passwordController.text,
      city: selectedCity.toString(),
      country: selectedCountry.name,
      fName: fNameController.text,
      lName: lNameController.text,
      imageUrl: imageUrl,
    );
    await FirestoreHelper.firestoreHelper.addUserToFirestore(registerRequest);
    await AuthHelper.authHelper.verifyEmail();
    await AuthHelper.authHelper.logoutOnly();
    // * navigate to login tab in the auth screen.
    tabController.animateTo(1);
  }

  Future<UserCredential> signin() async {
    UserCredential userCredential = await AuthHelper.authHelper
        .signin(emailController.text, passwordController.text);
    FirestoreHelper.firestoreHelper
        .getUserFromFirestore(userCredential.user.uid);
    return userCredential;
  }

  resetPassword() async {
    await AuthHelper.authHelper.resetPassword(emailController.text);
  }

  logout() async {
    await AuthHelper.authHelper.logout();
  }

  checkLogin() {
    bool isLoggedIn = AuthHelper.authHelper.checkUserLogin();
    if (isLoggedIn) {
      this.myId = AuthHelper.authHelper.getUserId();
      getAllUsersFromFirestore();
      // RouteHelper.routeHelper.pushReplacementNamed(HomeScreen.routeName);
      RouteHelper.routeHelper.pushReplacementNamed(ChatScreen.routeName);
    } else {
      RouteHelper.routeHelper.pushReplacementNamed(AuthMainScreen.routeName);
    }
  }

  fillControllers() {
    emailController.text = user.email;
    fNameController.text = user.fName;
    lNameController.text = user.lName;
    countryController.text = user.country;
    cityController.text = user.city;
  }

  File updatedImageFile;
  captureUpdateImageProfile() async {
    XFile imageFile = await ImagePicker().pickImage(source: ImageSource.camera);
    updatedImageFile = File(imageFile.path);
    notifyListeners();
  }

  updateProfile() async {
    String imageUrl;
    if (updatedImageFile != null) {
      imageUrl =
          await StorageHelper.storageHelper.uploadImage(updatedImageFile);
    }
    UserModel userModel = UserModel(
      id: user.id,
      email: user.email,
      fName: fNameController.text,
      lName: lNameController.text,
      city: cityController.text,
      country: countryController.text,
      imageUrl: imageUrl ?? user.imageUrl,
    );
    await FirestoreHelper.firestoreHelper.updateProfile(userModel);
    getUserFromFirestore();
    GlobalWidgets.globalWidgets.showSnackBar(
      context: RouteHelper.routeHelper.navigatorKey.currentContext,
      message: 'Profile Updated successfully',
      backgroundColor: Colors.green,
      duration: 1500,
    );
  }

  // Upload Image (Firebase Firestore & Firebase Storage)
  File file;
  selectFile() async {
    XFile imageFile = await ImagePicker().pickImage(source: ImageSource.camera);
    file = File(imageFile.path);
    notifyListeners();
  }

  // Chat
  sendImageToChat([String message]) async {
    XFile imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    String imageUrl = await StorageHelper.storageHelper
        .uploadImage(File(imageFile.path), 'chats');
    FirestoreHelper.firestoreHelper.addMessageToFirestore({
      'userId': this.myId,
      'dateTime': DateTime.now(),
      'message': message ?? '',
      'imageUrl': imageUrl,
    });
    notifyListeners();
  }
}
