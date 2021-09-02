import 'package:flutter/cupertino.dart';
import 'package:gsg_firebase/auth/helpers/firestore_helper.dart';
import 'package:gsg_firebase/auth/models/user_model.dart';

class FirestoreProvider extends ChangeNotifier {
  List<UserModel> _users = [];
  List<UserModel> get users => _users;

  getAllUsers() async {
    await FirestoreHelper.firestoreHelper.getAllUsersFromFirestore();
  }
}
