import 'package:flutter/material.dart';
import 'package:gsg_firebase/chat/ui/screens/profile_tab.dart';
import 'package:gsg_firebase/chat/ui/screens/users_tab.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: [
            UsersTab(),
            ProfileTab(),
          ],
        ),
      ),
    );
  }
}


// Consumer2<AuthProvider, FirestoreProvider>(
//       builder: (context, authProvider, firestoreProvider, child) {
//         return Scaffold(
//           appBar: AppBar(
//             title: Text('Chat Screen'),
//             actions: [
//               IconButton(
//                 icon: Icon(
//                   Icons.logout,
//                 ),
//                 onPressed: () {
//                   authProvider.logout();
//                   RouteHelper.routeHelper
//                       .pushReplacementNamed(AuthMainScreen.routeName);
//                 },
//               ),
//             ],
//           ),
//           body: ListView.builder(
//             itemBuilder: (context, index) {
//               return UserItem(
//                 userModel: firestoreProvider.users[index],
//               );
//             },
//             itemCount: firestoreProvider.users.length,
//           ),
//           floatingActionButton: FloatingActionButton(
//             child: Icon(Icons.file_download),
//             onPressed: () async {
//               await firestoreProvider.getAllUsers();
//             },
//           ),
//         );
//       },
//     );