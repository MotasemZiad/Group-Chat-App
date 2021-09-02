import 'package:flutter/material.dart';
import 'package:gsg_firebase/auth/providers/auth_provider.dart';
import 'package:gsg_firebase/auth/ui/screens/signin_screen.dart';
import 'package:gsg_firebase/auth/ui/screens/signup_screen.dart';
import 'package:provider/provider.dart';

class AuthMainScreen extends StatefulWidget {
  static const routeName = '/auth';
  @override
  _AuthMainScreenState createState() => _AuthMainScreenState();
}

class _AuthMainScreenState extends State<AuthMainScreen>
    with TickerProviderStateMixin {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<AuthProvider>(context).tabController =
        TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    Provider.of<AuthProvider>(context, listen: false).tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat App',
        ),
        bottom: TabBar(
          tabs: [
            Tab(
              text: 'Sign Up',
            ),
            Tab(
              text: 'Sign In',
            ),
          ],
          controller: Provider.of<AuthProvider>(context).tabController,
        ),
      ),
      body: TabBarView(
        children: [
          SignUpScreen(),
          SignInScreen(),
        ],
        controller: Provider.of<AuthProvider>(context).tabController,
      ),
    );
  }
}
