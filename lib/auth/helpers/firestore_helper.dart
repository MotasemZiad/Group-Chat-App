import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gsg_firebase/auth/helpers/auth_helper.dart';
import 'package:gsg_firebase/auth/models/country_model.dart';
import 'package:gsg_firebase/auth/models/register_request.dart';
import 'package:gsg_firebase/auth/models/user_model.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static final usersCollection = 'users';
  static final countriesCollection = 'countries';
  static final chatsCollection = 'chats';

  addUserToFirestore(RegisterRequest registerRequest) async {
    // DocumentReference documentReference = await firebaseFirestore
    //     .collection('users')
    //     .add(registerRequest.toMap());
    await firebaseFirestore
        .collection(usersCollection)
        .doc(registerRequest.id)
        .set(registerRequest.toMap());
  }

  Future<UserModel> getUserFromFirestore(String userId) async {
    // await firebaseFirestore
    //     .collection('users')
    //     .where('id', isEqualTo: userId)
    //     .get();
    DocumentSnapshot<Map<String, dynamic>> result =
        await firebaseFirestore.collection(usersCollection).doc(userId).get();
    return UserModel.fromMap(result.data());
  }

  Future<List<UserModel>> getAllUsersFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firebaseFirestore.collection(usersCollection).get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<UserModel> users =
        docs.map((e) => UserModel.fromMap(e.data())).toList();
    print(users);
    return users;
  }

  Future<List<CountryModel>> getAllCountriesFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firebaseFirestore.collection(countriesCollection).get();
    List<CountryModel> countries = querySnapshot.docs.map(
      (e) {
        Map map = e.data();
        map['id'] = e.id;
        return CountryModel.fromMap(map);
      },
    ).toList();
    return countries;
  }

  updateProfile(UserModel userModel) async {
    await firebaseFirestore
        .collection(usersCollection)
        .doc(userModel.id)
        .update(userModel.toMap());
  }

  // Chats methods
  addMessageToFirestore(Map map) async {
    await firebaseFirestore.collection(chatsCollection).add(
      {
        ...map,
        'userId': AuthHelper.authHelper.getUserId(),
      },
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getFirestoreMessagesStream() {
    return firebaseFirestore
        .collection(chatsCollection)
        .orderBy('dateTime')
        .snapshots();
  }
}
