import 'package:flutter/material.dart';
import 'package:gsg_firebase/auth/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((value) =>
        Provider.of<AuthProvider>(context, listen: false).checkLogin());
    return Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 150.0,
        ),
      ),
    );
  }
}
