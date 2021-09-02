import 'package:flutter/material.dart';
import 'package:gsg_firebase/auth/models/user_model.dart';

class UserItem extends StatelessWidget {
  final UserModel userModel;
  UserItem({this.userModel});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(
              userModel.imageUrl,
            ),
            radius: 32.0,
          ),
          title: Text(
            '${userModel.fName} ${userModel.lName}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text('${userModel.email}'),
        ),
        Divider(),
      ],
    );
  }
}
