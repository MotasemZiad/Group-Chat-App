import 'package:flutter/material.dart';
import 'package:gsg_firebase/auth/models/country_model.dart';
import 'package:gsg_firebase/auth/providers/auth_provider.dart';
import 'package:gsg_firebase/auth/ui/widgets/custom_textfield.dart';
import 'package:gsg_firebase/utils/constants.dart';
import 'package:gsg_firebase/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: marginHorizontal,
            vertical: marginVertical,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(top: 48.0),
                //   child: Text(
                //     'Sign Up',
                //     textAlign: TextAlign.center,
                //     style: TextStyle(
                //       color: colorPrimary,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 36.0,
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 16.0,
                // ),
                Padding(padding: EdgeInsets.only(top: 48.0)),
                GestureDetector(
                  onTap: () {
                    authProvider.selectFile();
                  },
                  child: Center(
                    child: authProvider.file == null
                        ? Container(
                            height: imageWidthAndHeight,
                            width: imageWidthAndHeight,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/pick_image.png'),
                                fit: BoxFit.cover,
                                alignment: Alignment.topRight,
                              ),
                            ),
                          )
                        : Container(
                            height: imageWidthAndHeight,
                            width: imageWidthAndHeight,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(52.0),
                              image: DecorationImage(
                                image: FileImage(
                                  authProvider.file,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 12.0),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: authProvider.fNameController,
                        label: 'First Name',
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Expanded(
                      child: CustomTextField(
                        controller: authProvider.lNameController,
                        label: 'Last Name',
                        keyboardType: TextInputType.name,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6.0,
                ),
                CustomTextField(
                  controller: authProvider.emailController,
                  label: 'Email',
                  hint: 'example@gmail.com',
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 6.0,
                ),
                CustomTextField(
                  controller: authProvider.passwordController,
                  label: 'Password',
                  hint: '******',
                  isObscure: true,
                ),
                SizedBox(
                  height: 6.0,
                ),
                authProvider.countries == null
                    ? Container()
                    : Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 5.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                        child: DropdownButton<CountryModel>(
                          isExpanded: true,
                          // hint: Text('Country'),
                          underline: Container(),
                          value: authProvider.selectedCountry,
                          onChanged: (value) {
                            authProvider.selectCountry(value);
                          },
                          items: authProvider.countries
                              .map(
                                (e) => DropdownMenuItem(
                                  child: Text(e.name),
                                  value: e,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                SizedBox(
                  height: 6.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: DropdownButton<dynamic>(
                    isExpanded: true,
                    // hint: Text('City'),
                    underline: Container(),
                    value: authProvider.selectedCity,
                    onChanged: (value) {
                      authProvider.selectCity(value);
                    },
                    items: authProvider.cities
                        .map(
                          (e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ),
                        )
                        .toList(),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                CustomButton(
                  label: 'Sign Up',
                  onPressed: () async {
                    await authProvider.signup();
                    // if (result) {
                    //   GlobalWidgets.globalWidgets.showSnackBar(
                    //     context: context,
                    //     message: 'User singed up successfully',
                    //     backgroundColor: Colors.green,
                    //     duration: 1500,
                    //   );
                    // }
                    authProvider.resetController();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
