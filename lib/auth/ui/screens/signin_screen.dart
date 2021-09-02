import 'package:flutter/material.dart';
import 'package:gsg_firebase/auth/providers/auth_provider.dart';
import 'package:gsg_firebase/auth/ui/screens/reset_password_screen.dart';
import 'package:gsg_firebase/auth/ui/widgets/custom_textfield.dart';
import 'package:gsg_firebase/services/route_helper.dart';
import 'package:gsg_firebase/utils/constants.dart';
import 'package:gsg_firebase/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) {
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
                //     'Sign In',
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
                FlutterLogo(
                  size: imageWidthAndHeight,
                  style: FlutterLogoStyle.stacked,
                  textColor: colorPrimary,
                ),
                SizedBox(
                  height: 16.0,
                ),
                CustomTextField(
                  controller: value.emailController,
                  label: 'Email',
                  hint: 'example@gmail.com',
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: spaceBetweenItems,
                ),
                CustomTextField(
                  controller: value.passwordController,
                  label: 'Password',
                  hint: '******',
                  isObscure: true,
                ),
                SizedBox(
                  height: 15.0,
                ),
                CustomButton(
                  label: 'Sign In',
                  onPressed: () async {
                    await value.signin();
                    // if (result) {
                    //   GlobalWidgets.globalWidgets.showSnackBar(
                    //     context: context,
                    //     message: 'User sing in successfully',
                    //     backgroundColor: Colors.green,
                    //     duration: 1000,
                    //   );
                    // }
                    value.resetController();
                  },
                ),
                GestureDetector(
                  onTap: () {
                    RouteHelper.routeHelper
                        .pushNamed(ResetPasswordScreen.routeName);
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'Forget Password?',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
