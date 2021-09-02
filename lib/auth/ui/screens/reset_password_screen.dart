import 'package:flutter/material.dart';
import 'package:gsg_firebase/auth/providers/auth_provider.dart';
import 'package:gsg_firebase/auth/ui/widgets/custom_textfield.dart';
import 'package:gsg_firebase/utils/constants.dart';
import 'package:gsg_firebase/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatelessWidget {
  static const routeName = '/reset-password';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) => Container(
          margin: EdgeInsets.symmetric(
            horizontal: marginHorizontal,
            vertical: marginVertical,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 48.0),
                  child: CustomTextField(
                    controller: authProvider.emailController,
                    label: 'Email',
                    hint: 'example@gmail.com',
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                CustomButton(
                  label: 'Reset',
                  onPressed: () {
                    authProvider.resetPassword();
                    authProvider.emailController.clear();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
