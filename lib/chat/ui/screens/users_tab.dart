import 'package:flutter/material.dart';
import 'package:gsg_firebase/auth/providers/auth_provider.dart';
import 'package:gsg_firebase/chat/ui/widgets/user_item.dart';
import 'package:provider/provider.dart';

class UsersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Contacts'),
        ),
        body: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return authProvider.users == null
                ? Center(child: CircularProgressIndicator())
                : Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return UserItem(
                          userModel: authProvider.users[index],
                        );
                      },
                      itemCount: authProvider.users.length,
                    ),
                  );
          },
        ));
  }
}
