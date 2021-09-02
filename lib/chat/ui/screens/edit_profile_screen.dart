import 'package:flutter/material.dart';
import 'package:gsg_firebase/auth/providers/auth_provider.dart';
import 'package:gsg_firebase/auth/ui/widgets/custom_textfield.dart';
import 'package:gsg_firebase/utils/constants.dart';
import 'package:gsg_firebase/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/edit-profile';
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return Container(
            margin: EdgeInsets.symmetric(
                horizontal: marginHorizontal, vertical: marginVertical),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 6.0,
                  ),
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 52.0,
                        backgroundImage: authProvider.updatedImageFile == null
                            ? NetworkImage(
                                authProvider.user.imageUrl,
                              )
                            : FileImage(authProvider.updatedImageFile),
                      ),
                      Positioned(
                        right: 2.0,
                        bottom: 0.15,
                        child: GestureDetector(
                          onTap: () {
                            // ? here we can upload another image...
                            authProvider.captureUpdateImageProfile();
                          },
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(52.0),
                              color: colorPrimary,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: authProvider.fNameController,
                          label: 'First Name',
                        ),
                      ),
                      SizedBox(
                        width: spaceBetweenItems,
                      ),
                      Expanded(
                        child: CustomTextField(
                          controller: authProvider.lNameController,
                          label: 'Last Name',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: spaceBetweenItems,
                  ),
                  CustomTextField(
                    controller: authProvider.countryController,
                    label: 'Country',
                  ),
                  SizedBox(
                    height: spaceBetweenItems,
                  ),
                  CustomTextField(
                    controller: authProvider.cityController,
                    label: 'City',
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  CustomButton(
                    label: 'Save',
                    onPressed: () {
                      authProvider.updateProfile();
                    },
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
