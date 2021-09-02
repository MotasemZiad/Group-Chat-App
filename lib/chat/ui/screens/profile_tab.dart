import 'package:flutter/material.dart';
import 'package:gsg_firebase/auth/providers/auth_provider.dart';
import 'package:gsg_firebase/chat/ui/screens/edit_profile_screen.dart';
import 'package:gsg_firebase/chat/ui/widgets/item_widget.dart';
import 'package:gsg_firebase/services/route_helper.dart';
import 'package:gsg_firebase/utils/constants.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  void initState() {
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).getUserFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Profile'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
            ),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false)
                  .fillControllers();
              RouteHelper.routeHelper.pushNamed(EditProfileScreen.routeName);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.logout,
            ),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
          ),
        ],
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return authProvider.user == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: marginHorizontal, vertical: marginVertical),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 6.0,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 52.0,
                          backgroundImage: NetworkImage(
                            authProvider.user.imageUrl,
                          ),
                        ),
                        SizedBox(
                          height: spaceBetweenItems,
                        ),
                        ItemWidget(
                          label: 'Full Name',
                          value:
                              '${authProvider.user.fName} ${authProvider.user.lName}',
                        ),
                        SizedBox(
                          height: spaceBetweenItems,
                        ),
                        ItemWidget(
                          label: 'Email',
                          value: '${authProvider.user.email}',
                        ),
                        SizedBox(
                          height: spaceBetweenItems,
                        ),
                        ItemWidget(
                          label: 'Country',
                          value: '${authProvider.user.country}',
                        ),
                        SizedBox(
                          height: spaceBetweenItems,
                        ),
                        ItemWidget(
                          label: 'City',
                          value: '${authProvider.user.city}',
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
